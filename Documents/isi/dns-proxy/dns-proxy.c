/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2010-2015 Intel Corporation
 */

#include <rte_cycles.h>
#include <rte_eal.h>
#include <rte_ether.h>
#include <rte_ethdev.h>
#include <rte_lcore.h>
#include <rte_mbuf.h>
#include <rte_malloc.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define RX_RING_SIZE 1024
#define TX_RING_SIZE 1024

#define NUM_MBUFS 8191
#define MBUF_CACHE_SIZE 250
#define BURST_SIZE 32

/* dns-proxy.c: DPDK wrapper to catch bad NXDOMAINs by verifying packets. */

char *tlds[5000];
int num_tld = 0;
uint16_t ports[3];

static const struct rte_eth_conf port_conf_default = {
    .rxmode =
        {
            .max_rx_pkt_len = RTE_ETHER_MAX_LEN,
        },
};

/*
 * Initializes a given port using global settings and with the RX buffers
 * coming from the mbuf_pool passed as a parameter.
 */
static inline int port_init(uint16_t port, struct rte_mempool *mbuf_pool) {
  struct rte_eth_conf port_conf = port_conf_default;
  const uint16_t rx_rings = 1, tx_rings = 1;
  uint16_t nb_rxd = RX_RING_SIZE;
  uint16_t nb_txd = TX_RING_SIZE;
  int retval;
  uint16_t q;
  struct rte_eth_dev_info dev_info;
  struct rte_eth_txconf txconf;

  if (!rte_eth_dev_is_valid_port(port))
    return -1;

  rte_eth_dev_info_get(port, &dev_info);
  if (dev_info.tx_offload_capa & DEV_TX_OFFLOAD_MBUF_FAST_FREE)
    port_conf.txmode.offloads |= DEV_TX_OFFLOAD_MBUF_FAST_FREE;

  /* Configure the Ethernet device. */
  retval = rte_eth_dev_configure(port, rx_rings, tx_rings, &port_conf);
  if (retval != 0)
    return retval;

  retval = rte_eth_dev_adjust_nb_rx_tx_desc(port, &nb_rxd, &nb_txd);
  if (retval != 0)
    return retval;

  /* Allocate and set up 1 RX queue per Ethernet port. */
  for (q = 0; q < rx_rings; q++) {
    retval = rte_eth_rx_queue_setup(
        port, q, nb_rxd, rte_eth_dev_socket_id(port), NULL, mbuf_pool);
    if (retval < 0)
      return retval;
  }

  txconf = dev_info.default_txconf;
  txconf.offloads = port_conf.txmode.offloads;
  /* Allocate and set up 1 TX queue per Ethernet port. */
  for (q = 0; q < tx_rings; q++) {
    retval = rte_eth_tx_queue_setup(port, q, nb_txd,
                                    rte_eth_dev_socket_id(port), &txconf);
    if (retval < 0)
      return retval;
  }

  /* Start the Ethernet port. */
  retval = rte_eth_dev_start(port);
  if (retval < 0)
    return retval;

  /* Display the port MAC address. */
  struct rte_ether_addr addr;
  rte_eth_macaddr_get(port, &addr);
  printf("Port %u MAC: %02" PRIx8 " %02" PRIx8 " %02" PRIx8 " %02" PRIx8
         " %02" PRIx8 " %02" PRIx8 "\n",
         port, addr.addr_bytes[0], addr.addr_bytes[1], addr.addr_bytes[2],
         addr.addr_bytes[3], addr.addr_bytes[4], addr.addr_bytes[5]);

  /* Enable RX in promiscuous mode for the Ethernet device. */
  rte_eth_promiscuous_enable(port);

  return 0;
}

/*
 * Checks if a string is in the list of valid TLDs, case insensitive
 */
static char is_valid_tld(char *test) {
  for (int i = 0; i < num_tld; i++) {
    if (strcasecmp(test, tlds[i]))
      return 1;
  }
  return 0;
};

/*
 * The lcore main. This is the main thread that does the work, reading from
 * an input port and writing to an output port.
 */
static __attribute__((noreturn)) void lcore_main(void) {
  uint16_t port;

  /*
   * Check that the port is on the same NUMA node as the polling thread
   * for best performance.
   */
  RTE_ETH_FOREACH_DEV(port)
  if (rte_eth_dev_socket_id(port) > 0 &&
      rte_eth_dev_socket_id(port) != (int)rte_socket_id())
    printf("WARNING, port %u is on remote NUMA node to "
           "polling thread.\n\tPerformance will "
           "not be optimal.\n",
           port);

  printf("\nCore %u forwarding packets. [Ctrl+C to quit]\n", rte_lcore_id());

  /* Run until the application is quit or killed. */
  for (;;) {
    /* Get burst of RX packets, from first port. */
    struct rte_mbuf *bufs[BURST_SIZE];
    struct rte_mbuf *fwd[BURST_SIZE];
    int fwd_cnt = 0;
    const uint16_t nb_rx = rte_eth_rx_burst(ports[0], 0, bufs, BURST_SIZE);

    // loop through and check each mbuf's packet data
    for(int i = 0; i < BURST_SIZE; i++) {
      struct rte_ether_hdr* ehdr = rte_pktmbuf_mtod(bufs[i], struct rte_ether_hdr*);

      if(ehdr->ether_type == RTE_ETHER_TYPE_IPV4) {
        char* buf = rte_pktmbuf_mtod(bufs[i], char*);
        buf += 12; // TODO: check offset is correct

        char* url_str = (char*) rte_malloc("url_str", *buf, 0);
        char err_flag = 0;

        // go through the URL and keep looking for strings, last one is the TLD
        while (!err_flag) {
          int len = *buf;

          for(int it = 0; it < len; it++) {
            // Make sure request is not deformed
            if(buf + it != NULL) {
              strcat(url_str, buf + it);
            } else {
              err_flag = 1;
              break;
            }
          }
          
          // Check if end of request, if not get next one
          if ((*(buf + len) == 0x00) && ! err_flag) {
            break;
          } else if (!err_flag) {
            rte_free(url_str);
            url_str = (char*) rte_malloc("url_str", *(buf + 1), 0);
            buf += len;
          }
        }

        // test if the TLD is valid, if so, add to fwd buffer
        if(is_valid_tld(url_str)) {
          fwd[fwd_cnt] = bufs[i];
          fwd_cnt++;
        }

        // Free up url_str
        rte_free(url_str);
      }
    }
    if (unlikely(nb_rx == 0))
      continue;

    /* Send burst of TX packets, to second port. */
    const uint16_t nb_tx = rte_eth_tx_burst(ports[1], 0, fwd, nb_rx);

    /* Free any unsent packets. */
    if (unlikely(nb_tx < nb_rx)) {
      uint16_t buf;
      for (buf = nb_tx; buf < nb_rx; buf++)
        rte_pktmbuf_free(bufs[buf]);
    }
  }
}

/*
 * The main function, which does initialization and calls the per-lcore
 * functions.
 */
int main(int argc, char *argv[]) {
  // Setting 5000 for now, but there are only about 2000 TLDs actually
  char *tlds[5000];
  char line[500];

  FILE *file = fopen("tlds.txt", "r");

  while (fgets(line, sizeof line, file) != NULL) {
    // add each filename into array of TLDs
    tlds[num_tld] = (char*) rte_malloc("tlds", strlen(line), 0);
    strcpy(tlds[num_tld], line);
    // count number of TLDs in file
    num_tld++;
  }

  // check to be sure going into array correctly
  for (int j = 0; j < num_tld + 1; j++) {
    printf("\n%s", tlds[j]);
  }

  fclose(file);

  struct rte_mempool *mbuf_pool;
  unsigned nb_ports;
  uint16_t portid;

  /* Initialize the Environment Abstraction Layer (EAL). */
  int ret = rte_eal_init(argc, argv);
  if (ret < 0)
    rte_exit(EXIT_FAILURE, "Error with EAL initialization\n");

  argc -= ret;
  argv += ret;

  /* Check that there is an even number of ports to send/receive on. */
  nb_ports = rte_eth_dev_count_avail();
  if (nb_ports < 2 || (nb_ports & 1))
    rte_exit(EXIT_FAILURE, "Error: number of ports must be even\n");

  /* Creates a new mempool in memory to hold the mbufs. */
  mbuf_pool = rte_pktmbuf_pool_create(
      "MBUF_POOL", NUM_MBUFS * nb_ports, MBUF_CACHE_SIZE, 0,
      RTE_MBUF_DEFAULT_BUF_SIZE, rte_socket_id());

  if (mbuf_pool == NULL)
    rte_exit(EXIT_FAILURE, "Cannot create mbuf pool\n");

  /* Initialize all ports. */
  RTE_ETH_FOREACH_DEV(portid)
  if (port_init(portid, mbuf_pool) != 0)
    rte_exit(EXIT_FAILURE, "Cannot init port %" PRIu16 "\n", portid);

  int i = 0;
  /* Create an array of ports*/
  RTE_ETH_FOREACH_DEV(portid) {
    ports[i] = portid;
    i++;
  }

  if (rte_lcore_count() > 1)
    printf("\nWARNING: Too many lcores enabled. Only 1 used.\n");

  /* Call lcore_main on the master core only. */
  lcore_main();

  return 0;
}
