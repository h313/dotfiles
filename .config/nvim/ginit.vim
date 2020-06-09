if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Inconsolata 16')
  let g:GuiInternalClipboard = 1
endif
