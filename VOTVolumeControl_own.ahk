#SingleInstance ignore
;#NoTrayIcon
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input

#Include VMR.ahk/VMR.ahk
#include auto_oculus_touch.ahk

voicemeeter := new VMR()
voicemeeter.login()
trigger := False

InitOculus()
Loop {
    Sleep 55
    Poll()
    down                := GetButtonsDown()
    pressed             := GetButtonsPressed()
    released            := GetButtonsReleased()
    rightY              := GetThumbStick(RightHand, YAxis)
    leftY               := GetThumbStick(LeftHand, YAxis)
    leftHandTrigger     := GetAxis(AxisHandTriggerLeft)
    rightHandTrigger    := GetAxis(AxisHandTriggerRight)

    if (rightY >= 0.7) && (rightHandTrigger >= 0.7) && ovrRThumb && down
        voicemeeter.strip[6].gain += 0.5
    else if (rightY <= -0.7) && (rightHandTrigger >= 0.7) && ovrRThumb && down
        voicemeeter.strip[6].gain -= 0.5
    else if (leftY >= 0.7) && (leftHandTrigger >= 0.7) && ovrLThumb && down
        voicemeeter.strip[7].gain += 0.5
    else if (leftY <= -0.7) && (leftHandTrigger >= 0.7) && ovrLThumb && down
        voicemeeter.strip[7].gain -= 0.5

    If ProcessExist("VRChat.exe") && !ProcessExist("AdvancedSettings.exe") {
        Run, "steam://rungameid/1009850"
    }

    Process, Exist, OculusClient.exe
} Until !ErrorLevel

ProcessExist(name) {
    Process, Exist, %name%
    Return ErrorLevel
}