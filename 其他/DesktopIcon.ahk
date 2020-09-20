; ˫���������Ͻ���ʾ��������ͼ��

#Persistent             ; �������иýű�
#NoTrayIcon             ; ����ʾͼ��
#SingleInstance Force   ; �ظ�������ʱ���Զ�����

CoordMode, Pixel, Screen
CoordMode, Mouse, Screen

; ����Progman|WorkerW
GroupAdd, Desktop, ahk_class ExploreWClass
GroupAdd, Desktop, ahk_class WorkerW

; ���ϵͳ��Ĭ��˫�����ʱ��
WaitTime := DllCall("GetDoubleClickTime")/1000

edge := 10

; ���ƽ����������������´���
#IfWinActive, ahk_group Desktop

; ���˫������
~LButton::
    KeyWait, LButton
    KeyWait, LButton, D, T %WaitTime%
    If Errorlevel = 0
    {
        MouseGetPos, x, y
        if (x > A_ScreenWidth - edge and y < edge)  ; ��Ļ���Ͻ�10*10px
        {
            HideOrShowDesktopIcons()
        }
    }
    Return

; ��ʾ/��������ͼ��ĺ���
HideOrShowDesktopIcons()
{
	ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
	If class =
		ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
	If DllCall("IsWindowVisible", UInt,class)
	{
		WinHide, ahk_id %class%
		ToolTip HideDesktopIcons
		Sleep,500
		ToolTip
	}
	Else
	{
		WinShow, ahk_id %class%
		ToolTip ShowDesktopIcons
		Sleep,500
		ToolTip
	}
}
