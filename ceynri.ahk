; @encode: gbk
; @Author: ceynri
; @document: https://wyagd001.github.io/zh-cn/docs/AutoHotkey.htm

; Notes:  # == win    ! == Alt    ^ == Ctrl    + == Shift

#SingleInstance Force ; �ظ������ýű�ʱ���Զ����Ǿɽű�����

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
    If (ExStyle & 0x8) {  ; 0x8 Ϊ WS_EX_TOPMOST.��WinGet�İ�����
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
CapsLock::Return ; ���ô�д��
#Capslock::
RAlt & Capslock::
Capslock & RAlt::
    isCaps = % GetKeyState("CapsLock", "T")
    If (isCaps) {
        SetCapsLockState, off
        ToolTip ��д����
    } Else {
        SetCapsLockState, on
        ToolTip ȡ����д����
    }
    Sleep 300
    ToolTip
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


; ---------------------------------------------------------
; Win + R ���� �����ýű�
; ---------------------------------------------------------
#~R::
	KeyWait, R
	If (A_TimeSinceThisHotkey > 300) {
        ; �رա����С�����
        WinClose ahk_class #32770
        ; ���нű�
	    Run "D:\ceynri\tools\ahk\ceynri.ahk"
    }
    Return
; ---------------------------------------------------------
; Win + E ���� �޸ĸýű�
; ---------------------------------------------------------
#~E::
    ; �̰� Win + E ��򿪿��ٷ��ʴ���
    KeyWait, E
    If (A_TimeSinceThisHotkey > 300) {
        ; �رտ��ٷ��ʴ���
        WinClose ahk_class CabinetWClass
        ; ʹ�� vs code �򿪽ű�
        Run cmd /K code "D:\ceynri\tools\ahk\ceynri.ahk"
        ; �ӳ�2s��ȡ���ڵ��������ٶȣ��󣬹رյ�����������
        Sleep 2000
        Send !{Tab}
        Sleep 100
        Send {AltDown}{F4}{AltUp}
    }
    Return
; ---------------------------------------------------------
