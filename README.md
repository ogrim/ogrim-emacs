# OGRIM-EMACS

Just some notes from myself after slapping things around for Win11 and Emacs 29.1

Make sure Emacs bin folder is on the PATH.

Go to `shell:startup` and stick `StartEmacsServer.bat` there to startup the Emacs server automatically.

Stick `emacs.bat` on the PATH and use that to open one frame only. Calling `emacs.bat` directly will open my work.org (old approach stopped working, so needed to pass a file). Passing any other parameter will open that instead, making it easy to open files in Emacs from the console.
