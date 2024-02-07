/**
 * @encode: gbk
 * @author: ceynri
 * @Project: https://github.com/ceynri/awesome-ahk
 * @document: https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm
 *
 * Notes:  # == win    ! == Alt    ^ == Ctrl    + == Shift
 */

#SingleInstance Force  ; �ظ�������ʱ���Զ�����
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; ������2������������100�ο�ݼ�������������Ի��򣬱��ⳤ�������ʱ��������
#HotkeyInterval 2000
#MaxHotkeysPerInterval 100

; ������ԱȨ�ޣ�û�����Թ���ԱȨ�����������ű������ⲿ��������޷�ʹ��ahk
full_command_line := DllCall("GetCommandLine", "str")

if not (A_IsAdmin or RegExMatch(full_command_line, " /restart(?!\S)"))
{
    try
    {
        if A_IsCompiled
            Run *RunAs "%A_ScriptFullPath%" /restart
        else
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
    }
    ExitApp
}

; ����
userDir := "C:\ceynri"
sysUserDir := "C:\Users\" . A_UserName

#IfWinActive, ahk_exe Explorer.EXE

; ---------------------------------------------------------
; Win + H ��ʾ/����ϵͳ�����ļ�
; ---------------------------------------------------------
toggleSysHiddenFileDisplay() {
    If value = 1
        value := 2
    Else
        value = 1
    RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\, Hidden, %Value%
    Send {Browser_Refresh}
}
#H::toggleSysHiddenFileDisplay()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + Z ��ʾ/���������ļ�
; ---------------------------------------------------------
toggleDesktopFileDisplay() {
    ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
    If class = 
        ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
    If DllCall("IsWindowVisible", UInt,class)
        WinHide, ahk_id %class%
    Else
        WinShow, ahk_id %class%
}
#Z::toggleDesktopFileDisplay()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + S ��õ�ǰѡ���ļ���·��������Դ������/��������Ч��
; ---------------------------------------------------------
getFilePath() {
    Send ^c
    clipboard = %clipboard%
    tooltip, %clipboard%
    sleep, 500
    tooltip
}
#S::getFilePath()
; ---------------------------------------------------------

#If ; End "#IfWinActive, ahk_exe Explorer.EXE"


; ---------------------------------------------------------
; Win + O �ر���ʾ��
; ---------------------------------------------------------
closeMonitor() {
    Sleep 2000 ; ���û��л����ͷŰ��� (�Է��ͷ�����ʱ�ٴλ���������).
    SendMessage, 0x112, 0xF170, 2,, Program Manager ; �ر���ʾ��: 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER. ; ��ʹ�� -1 ���� 2 ����ʾ����1 ���� 2 ������ʾ���Ľ���ģʽ
}
#O::closeMonitor()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + T ��ǰ�����ö�
; ---------------------------------------------------------
toggleCurrentWindowOnTop() {
    WinSet, AlwaysOnTop, TOGGLE, A ; A��AutoHotkey���ʾ��ǰ����ڵı���
    WinGet, ExStyle, ExStyle, A
    if (ExStyle & 0x8) ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
        tooltip �ö�
    else
        ToolTip ȡ���ö�
    Sleep 1000
    ToolTip
}
#T::toggleCurrentWindowOnTop()
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + J ������
; ---------------------------------------------------------
#J::Run calc
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win [+ Alt ]+ F �� userDir �ļ���
; ---------------------------------------------------------
#F::Run explore %userDir%
#!F::Run explore %userDir%
; ---------------------------------------------------------
; Win + Alt + D �̰� �� Downloads
;                 ���� �� documents
; ---------------------------------------------------------
#!D::
    KeyWait, D
    If (A_TimeSinceThisHotkey < 300) {
        Run explore "%sysUserDir%\downloads"
    } Else {
        Run explore "%userDir%\documents"
    }
    Return
; ---------------------------------------------------------
; Win + Alt + T ��Tools�ļ���
; ---------------------------------------------------------
#!T::Run explore "%userDir%\tools"
; ---------------------------------------------------------
; Win + Alt + P �� Pictures �ļ���
; ---------------------------------------------------------
#!P::Run explore "%userDir%\pictures"
; ---------------------------------------------------------
; Win + Alt + Z ��Desktop�ļ���
; ---------------------------------------------------------
#!Z::Run explore %A_Desktop%
; ---------------------------------------------------------
; Win + Alt + W �� workspace �ļ���
; ---------------------------------------------------------
#!W::Run explore "%userDir%\workspace"
; ---------------------------------------------------------
; Win + Alt + N �� ceynri.cn �ļ���
; ---------------------------------------------------------
#!N::Run explore "%userDir%\workspace\ceynri.cn"
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + C �� window terminal
; ---------------------------------------------------------
#C::Run wt.exe
; ---------------------------------------------------------
; Win + K �򿪿������
; ---------------------------------------------------------
#K::Run control.exe
; ---------------------------------------------------------
; Win + Y �򿪳����빦��
; ---------------------------------------------------------
#Y::Run control.exe /name Microsoft.ProgramsAndFeatures
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + N �½� Edge ����
; ---------------------------------------------------------
#N::Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + M ������������
; ---------------------------------------------------------
#M::
    IfWinNotExist ahk_class OrpheusBrowserHost
    {
        Run "C:\Program Files\NetEase\CloudMusic\cloudmusic.exe"
        winActivate
    }
    Else IfWinNotActive ahk_class OrpheusBrowserHost
        winActivate
    Else 
        winMinimize
    Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; �� CapsLock �滻Ϊ Alt + CapsLock
; ---------------------------------------------------------
CapsLock::Return

; ��Alt��Ctrl���μ����� Capslock ��һͬʹ�ã������û�а������� Capslock ��ϵļ�����ƹ�����Ĺ��򴥷���д�������ʽ���
<!Capslock::Return
<^Capslock::Return

; Win/Right Alt + Capslock �����д��
#Capslock::
>!Capslock::
    isCaps = % GetKeyState("CapsLock", "T")
    If (isCaps) {
        SetCapsLockState, off
        ToolTip
    } Else {
        SetCapsLockState, on
        ToolTip Caps Locking
    }
Return
; ---------------------------------------------------------
; Ϊ60%��65%���̽���F��ӳ�䣨����Fn�����߼���
; ---------------------------------------------------------
Capslock & Esc::`
Capslock & 1::F1
Capslock & 2::F2
Capslock & 3::F3
Capslock & 4::F4
Capslock & 5::F5
Capslock & 6::F6
Capslock & 7::F7
Capslock & 8::F8
Capslock & 9::F9
Capslock & 0::F10
Capslock & -::F11
Capslock & +::F12
Capslock & ,::Home
Capslock & .::End
; ---------------------------------------------------------
; �� Capslock + W/A/S/D������������
; ---------------------------------------------------------
Capslock & W::Up
Capslock & A::Left
Capslock & S::Down
Capslock & D::Right
; ---------------------------------------------------------
; �� Capslock + Q/E/T/G����λ��
; ---------------------------------------------------------
Capslock & Q::Home
Capslock & E::End
Capslock & T::PgUp
Capslock & G::PgDn
; ---------------------------------------------------------
; ����Capslock + R/F��������
; ---------------------------------------------------------
Capslock & R::Send {Volume_Up 1}
Capslock & F::Send {Volume_Down 1}
; ---------------------------------------------------------
; ����Capslock + Z/X�л�����  Capslock + Space��ͣ����
; ---------------------------------------------------------
Capslock & Z::Media_Prev
Capslock & X::Media_Next
Capslock & Space::Media_Play_Pause
; ---------------------------------------------------------
; ����Capslock + C/V�������ȣ����ã�Win + Up/Down��
; һ����ʼǱ�������Ч
; ---------------------------------------------------------
Capslock & C::
LWin & Down::
    AdjustScreenBrightness(-5)
    Return

Capslock & V::
LWin & Up::
    AdjustScreenBrightness(5)
    Return

AdjustScreenBrightness(step) {
    service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    minBrightness := 0

    for i in monitors {
        curt := i.CurrentBrightness
        break
    }
    toSet := curt + step
    If (toSet > 100) {
        Return
    }
    If (toSet < minBrightness) {
        toSet := minBrightness
    }

    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}
; ---------------------------------------------------------


; ---------------------------------------------------------
; Alt + [/] ֱ����������
; ---------------------------------------------------------

![::Send ��
!]::Send ��


; ---------------------------------------------------------
; Win + R ���� �����ýű�
; ---------------------------------------------------------
#R::
    KeyWait, R
    If (A_TimeSinceThisHotkey > 300) {
        ToolTip Reload Script
        Sleep 300
        ToolTip
        Reload
    } Else {
        Run "%A_Programs%\System Tools\Run.lnk"
    }
    Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; Win + E ���� �޸ĸýű�
; ---------------------------------------------------------
#E::
    KeyWait, E ; �ȴ� E ��̧��
    If (A_TimeSinceThisHotkey > 300) {
        Run "%sysUserDir%\AppData\Local\Programs\Microsoft VS Code\code.exe" %A_ScriptDir% ; ʹ�� vs code ��ahk��Ŀ
    } Else {
        Run explorer
    }
Return
; ---------------------------------------------------------


; ---------------------------------------------------------
; 
; ---------------------------------------------------------


; ---------------------------------------------------------
