; vim:fenc=utf-8:tw=80:com+=\:;

#SingleInstance Force
SetCapsLockState Off

#IfWinActive ahk_exe gvim.exe
  ; Provide multiple behaviors to capslock:
  ; - Press it once: escape.
  ; - Hold and press another key: ctrl.
  ; - Hold shift before pessing: good ol' capslock.
  CapsLock::
    key=
    Input key, B C L1 T60, {Esc}
    if (ErrorLevel = "Max")
      Send {Ctrl Down}%key%
    KeyWait CapsLock
  return
  CapsLock up::
    if key
      Send {Ctrl Up}
    else
      Send {Esc 2}
  return
#IfWinActive

