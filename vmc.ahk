#SingleInstance Force
SetCapsLockState Off

#IfWinActive ahk_exe gvim.exe
  ; Provide multiple behaviors to capslock:
  ; - Press it once: escape.
  ; - Hold and press another key: ctrl.
  ; - Hold shift before pessing: good ol' capslock.
  ; https://www.autohotkey.com/board/topic/104173-capslock-to-control-and-escape/?p=669777
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

