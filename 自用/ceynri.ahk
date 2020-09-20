/**
 * @encode: gbk
 * @Author: ceynri
 * @document: https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm
 */

; Notes:  # == win    ! == Alt    ^ == Ctrl    + == Shift

; �ظ������ýű�ʱ���Զ����Ǿɽű�����
#SingleInstance Force

; ---------------------------------------------------------
; ����Chrome������´���
; ---------------------------------------------------------
#N::Run "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome"
; ---------------------------------------------------------

; ---------------------------------------------------------
; �����ļ��еĿ�ݴ򿪷�ʽ
; ---------------------------------------------------------
#+C::Run "C:\"
#+D::
    KeyWait, D
    If (A_TimeSinceThisHotkey < 300) {
        ; ����С��300ms����Downloads�ļ���
        Run "C:\Users\yangruichen\Downloads"
    } Else {
        ; ���³���300ms����docs�ļ���
        Run "D:\ceynri\docs"
    }
Return
#+E::Run "D:\ceynri"
#+N::Run "D:\ceynri\docs\notes"
#+T::Run "D:\ceynri\tools"
#+W::Run "D:\workspace"
#+Z::Run "C:\Users\yangruichen\Desktop"
; ---------------------------------------------------------

; ---------------------------------------------------------
; Win + T ��ǰ�����ö�
; ---------------------------------------------------------
#T::
    ; �л������ö�״̬
    WinSet, AlwaysOnTop, TOGGLE, A	; A��AutoHotkey���ʾ��ǰ����ڵı���
    ; ��ȡ�����ö�״̬
    WinGet, ExStyle, ExStyle, A
    If (ExStyle & 0x8) { ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
        ToolTip �ö�
    } Else {
        ToolTip ȡ���ö�
    }
    Sleep 1000
    ; �ر� ToolTip ��ʾ
    ToolTip
Return
; ---------------------------------------------------------

; ---------------------------------------------------------
; �� CapsLock �滻Ϊ RAlt + CapsLock
; ---------------------------------------------------------
; ���ô�д��
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
; ��60%~65%���̽���F����������
; ---------------------------------------------------------
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
Capslock & `::Esc
Capslock & Esc::`
; ---------------------------------------------------------
; ��������
; ---------------------------------------------------------
Capslock & W::Up
Capslock & A::Left
Capslock & S::Down
Capslock & D::Right
; ---------------------------------------------------------
; ��λ
; ---------------------------------------------------------
Capslock & Q::Home
Capslock & E::End
Capslock & T::PgUp
Capslock & G::PgDn
; ---------------------------------------------------------
; ��������
; ---------------------------------------------------------
Capslock & R::Send {Volume_Up 1}
Capslock & F::Send {Volume_Down 1}
; ---------------------------------------------------------
; �л�����/��ͣ����
; ---------------------------------------------------------
Capslock & Z::Media_Prev
Capslock & X::Media_Next
Capslock & Space::Media_Play_Pause
; ---------------------------------------------------------

#IfWinActive, ahk_exe Explorer.EXE ; ����Դ������/��������Ч
; ---------------------------------------------------------
; Win + S ��õ�ǰѡ���ļ���·��
; ---------------------------------------------------------
#S::
    Send ^c
    clipboard = %clipboard%
    tooltip, %clipboard%
    sleep, 500
    tooltip
    Return
; ---------------------------------------------------------
#If ; End #IfWinActive, ahk_exe Explorer.EXE

; ---------------------------------------------------------
; Win + O �ر���ʾ��
; ---------------------------------------------------------
#O:: 
Sleep 2000  ; ���û��л����ͷŰ��� (�Է��ͷ�����ʱ�ٴλ���������).
SendMessage, 0x112, 0xF170, 2,, Program Manager   ; �ر���ʾ��: 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER. ; ��ʹ�� -1 ���� 2 ����ʾ����1 ���� 2 ������ʾ���Ľ���ģʽ
return
; ---------------------------------------------------------

; ---------------------------------------------------------
; Win + T ��ǰ�����ö�
; ---------------------------------------------------------
#T::
    winset, AlwaysOnTop, TOGGLE, A	;A��AutoHotkey���ʾ��ǰ����ڵı���
    WinGet, ExStyle, ExStyle, A
    if (ExStyle & 0x8)  ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
        tooltip �ö�
    else
        ToolTip ȡ���ö�
    Sleep 1000
    ToolTip
    Return
; ---------------------------------------------------------

; ---------------------------------------------------------
; Win + R ���� �����ýű�
; ---------------------------------------------------------
#R::
	KeyWait, R ; �ȴ� R ��̧��
	If (A_TimeSinceThisHotkey > 300) {
        ToolTip Reload Script
        Sleep 300
        ToolTip
	    Reload
    } Else {
        Run "C:\Users\yangruichen\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\System Tools\Run.lnk"
    }
    Return
; ---------------------------------------------------------
; Win + E ���� �޸ĸýű� ������뱣��ԭ��ݼ��򿪿��ٷ��ʵ�Ч����������Eǰ���~��
; ---------------------------------------------------------
#E::
    KeyWait, E ; �ȴ� E ��̧��
    If (A_TimeSinceThisHotkey > 300) {
        Run "C:\Users\Haze\AppData\Local\Programs\Microsoft VS Code\code.exe" "D:\ceynri\tools\ahk\ceynri.ahk" ; ʹ�� vs code �򿪽ű����滻����Ľű�λ�ã�
    }
Return
; ---------------------------------------------------------
