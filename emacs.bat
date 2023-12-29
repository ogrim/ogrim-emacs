@echo off

IF [%1] == [] (goto LABEL1) else (goto LABEL2)

:LABEL1

emacsclientw.exe --no-wait --alternate-editor runemacs.exe --server-file %HOME%\.emacs.d\server\server "c:\org\work.org"

GOTO EOF

:LABEL2

emacsclientw.exe --no-wait --alternate-editor runemacs.exe --server-file %HOME%\.emacs.d\server\server "%~1"

GOTO EOF

:EOF
