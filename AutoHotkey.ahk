^!e::
If WinExist("ahk_class Emacs")
{
  If WinActive("ahk_class Emacs") {
    WinActivateBottom, ahk_class Emacs
  } Else {
    WinActivate
  }
}
Else
{
  Run emacs
  WinWait ahk_class Emacs
  WinActivate
}
Return

!F2::Send #r
