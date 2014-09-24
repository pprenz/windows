#include <ScreenCapture.au3>

_Main()

Func _Main()
    Local $hBmp

    ; Capture full screen
    $hBmp = _ScreenCapture_Capture ("")

    ; Save bitmap to file
    _ScreenCapture_SaveImage (@DesktopDir & "\screenshots\teacher_Image.jpg", $hBmp)
EndFunc   ;==>_Main

