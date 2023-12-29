^!e::
{
if WinExist("ahk_class Emacs") {
  If WinActive("ahk_class Emacs") {
    WinActivateBottom "ahk_class Emacs"
  } Else {
    WinActivate
  }
}
Return
}
