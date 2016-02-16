#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=timer-Dark.ico
#AutoIt3Wrapper_Res_Icon_Add=Light.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
opt("TrayAutoPause",0)
Global $tdiff, $timer, $input, $seconds
$input = InputBox("CursorTimer", "How long should I set the timer for?"&@CRLF&"Format is MM:SS", "")
If StringInStr($input, ":") Then
	$inputtemp = StringSplit($input, ":")
	$input = $inputtemp[1] * 60 + $inputtemp[2]
EndIf
If $input = "" Then $input = 60 * 20
$tdiff = TimerInit()
While 1
	$rTimer = TimerInit()
	$timer = TimerDiff($tdiff)
	$timer = $input * 1000 - $timer
	$timer = Round($timer, -1)
	$timer = $timer / 1000
	$seconds = $timer
	While $seconds > 60
		If $seconds > 60 Then $seconds = $seconds - 60
	WEnd
	$seconds = StringFormat("%02d", $seconds)
	ToolTip("Time Left: " & Floor($timer / 60) & ":" & $seconds)
	If $timer < 1 Then
		HotKeySet("{esc}", "_exit")
		While 1
			For $j = 1 To 3
				For $i = 1 To 2
					ToolTip("Time Left: Done!" & @CRLF & "Press Exit to Silence Alarm.")
					Beep(500, 120)
				Next
				$lTimer = TimerInit()
				Do
					ToolTip("Time Left: Done!" & @CRLF & "Press Exit to Silence Alarm.")
					Sleep(1000 / @DesktopRefresh)
				Until TimerDiff($lTimer) > 500
			Next
			$kTimer = TimerInit()
			Do
				ToolTip("Time Left: Done!" & @CRLF & "Press Exit to Silence Alarm.")
				Sleep(1000 / @DesktopRefresh)
			Until TimerDiff($kTimer) > 2 * 1000
		WEnd
	EndIf
	$RDiff = TimerDiff($rTimer)
	Sleep(1000 / @DesktopRefresh - $RDiff)
WEnd
Func _exit()
	Exit
EndFunc   ;==>_exit
