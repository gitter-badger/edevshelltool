# [Home](Home)/ Includes

Index:

* CMD
  * [.../shell.cmd](#cmd-shell)
    * [LOGFILE](#cmd-shell-logfile)
    * [ELEVATESCRIPT](#cmd-shell-elevatescript)
  * [.../netutil.cmd](#cmd-netutil)
    * [DOWNFILE](#cmd-netutil-downfile)
  * [.../sysutil.cmd](#cmd-sysutil)
    * [CPUARCH](#cmd-sysutil-cpuarch)

## CMD

### CMD. SHELL

* [scriptFullPath] - .../include/cmd/shell.cmd

#### CMD. SHELL. LOGFILE

Redirects _stringToLog_ to _logPath_ file.

```bat
call [scriptFullPath] "LOGFILE" "[logPath]" "[stringToLog]"
```

* %~1 - label: LOGFILE
* %~2 - logPath
* %~3 - stringToLog

#### CMD. SHELL. ELEVATESCRIPT

Elevate cmd shell and run a elevated script.

```bat
call [scriptFullPath] "ELEVATESCRIPT" "[scriptRunPath]" [title] "[logPath]"
```

* %~1 - label: ELEVATESCRIPT
* %~2 - scriptRunPath
* %~3 - title
* %~4 - logPath

### CMD. NETUTIL

* [scriptFullPath] - .../include/cmd/netutil.cmd

#### CMD. NETUTIL. DOWNFILE

Download a file.

```bat
call [scriptFullPath] "DOWNFILE" "[rootPath]" "[scriptRunPath]" "[title]"
```

* %~1 - label: DOWNFILE
* %~2 - rootPath
* %~3 - scriptRunPath
* %~4 - title

### CMD. SYSUTIL

* [scriptFullPath] - .../include/cmd/netutil.cmd

#### CMD. SYSUTIL. CPUARCH

Get the CPU Architecture.

```bat
call [scriptFullPath] "CPUARCH" "[rootPath]" "[scriptRunPath]" "[title]"
```

* %~1 - label: CPUARCH
* %~2 - rootPath
* %~3 - scriptRunPath
* %~4 - title
