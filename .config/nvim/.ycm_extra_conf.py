def Settings( **kwargs ):
  return {
    'flags': ['-x',
        'c++',
        '-std=c++17',
        '-Wall',
        '-Wextra',
        '-Werror',
        '-isystem',
        '/usr/include/c++/8.2.1/',
        '-isystem',
        '/usr/include/boost'],
    'interpreter_path': '/bin/python3.7'
  }

def PythonSysPath( **kwargs ):
  sys_path = kwargs['sys_path']
  return sys_path
