; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one .ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

;�ýű��־����� (��ֱ���û��رջ����� ExitApp).
;#Persistent

;ǿ�Ƽ����µĽű�
#SingleInstance force

;���Լ���ͼ��
IfExist, icon.ico ;�����š�{�����ܺ� IfExist д��ͬһ��
{
Menu TRAY, Icon, icon.ico ;����� icon.ico ��Ϊͼ��
}

;��ʱ�� ����Ϊ������
#t::
; ����һ������򣬱��� ����
InputBox ,time,��ʱ��,������һ��ʱ�䣨��λ�Ƿ��ӣ�,,200,100 ;InputBox, time, ��ʱ��, ������һ��ʱ�䣨��λ�Ƿ��ӣ�
time := time*1000*60 ; ������ֵ����һ��ð�ţ����� 1000*60  ��timeΪ������
Sleep,%time%
MsgBox,,��ʾ��Ϣ, ����
return

/*
;��ie�����
#1::
run C:\Program Files\Internet Explorer\iexplore.exe
return
 
;��firefox�����
#2::
;run D:\Program Files\Mozilla Firefox\firefox.exe
run C:\Documents and Settings\koujincheng\Local Settings\Application Data\Google\Chrome\Application\chrome.exe
return
*/

;��everything
^!e::
Run D:\Program Files\everything\Everything.exe
return
 
;�����������
^!K::
Run taskmgr
return
 
;��Զ������
^!m::
Run mstsc
return
 
;�½��򼤻���±�����
^!n::
IfWinExist ahk_class Notepad
WinActivate
else
Run Notepad
return
 
;UltraEdit32
^!u::
Run D:\Program Files\UltraEdit\Uedit32.exe
return
 
;��ͼ���� FSCapture
^!c::
Run D:\Program Files (x86)\FScapture\FSCapture.exe
return
 
; Foxmail
^!f::
Run D:\Program Files (x86)\Foxmail7.2\Foxmail.exe
return

; P2PSearcher
^!p::
Run D:\Program Files (x86)\P2PSearchers\P2PSearcher.exe
return
 
;���¼��ؽű�
^!r::Reload  ; Assign Ctrl-Alt-R as a hotkey to restart the script.

;##################################################window script#############################################################
;###################################################���ڲ���#################################################################
 
;��󻯻�ԭ(ȡ�����)����
~LAlt::            
Keywait, LAlt, , t0.3
if errorlevel = 1
return
else
Keywait, LAlt, d, t0.3
if errorlevel = 0
{
WinGet, DAXIAO , MinMax, A
if (DAXIAO = "1")
{
PostMessage, 0x112, 0xF120,,, A  ; 0x112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE
}
else
{
PostMessage, 0x112, 0xF030,,, A  ; 0x112 = WM_SYSCOMMAND, 0xF030 = SC_MAXIMIZE
}
}
return
 
;��С������ ��¼���������С���Ĵ���
~RAlt::     
Keywait, RAlt, , t0.3
if errorlevel = 1
return
else
Keywait, RAlt, d, t0.3
if errorlevel = 0
{
If (WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW"))
{
}
else
{
Last_Max_Id=0
WinGet, Last_Min_Id, ID, A
if (MinMemo1 = "0")
MinMemo1=%Last_Min_Id%
else if(MinMemo2 = "0")
{
MinMemo2=%MinMemo1%
MinMemo1=%Last_Min_Id%
}
else
{
MinMemo3=%MinMemo2%
MinMemo2=%MinMemo1%
MinMemo1=%Last_Min_Id%
}
IfWinNotActive ahk_class TXGuiFoundation
WinMinimize, A
else  ;qq����ʹ��ctrl+alt+z ��С��
{
WinGetTitle, Temp0 , A
If Temp0 contains QQ20
{
sleep,100
Send, {CTRLDOWN}{ALTDOWN}z{ALTUP}{CTRLUP}
}
else
WinMinimize, A
}
}
} ;end if  errorlevel = 0
return
;�ָ���С���Ĵ���,�������(ֻ��ʶ��ͨ���ű���С���Ĵ���)
>!Space::      
if (MinMemo1 = "0") ;������ͨ���ű���С���Ĵ���
{
WinRestore, A
WinActivate,A
}
else if (MinMemo2 = "0") ;ֻ��һ��
{
WinRestore, ahk_id %MinMemo1%
WinActivate, ahk_id %MinMemo1%
MinMemo1=0
}
else if (MinMemo3 = "0")
{
WinRestore, ahk_id %MinMemo1%
WinActivate, ahk_id %MinMemo1%
MinMemo1=%MinMemo2%
MinMemo2=0
}
else
{
WinRestore, ahk_id %MinMemo1%
WinActivate, ahk_id %MinMemo1%
MinMemo1=%MinMemo2%
MinMemo2=%MinMemo3%
MinMemo3=0
}
return
 
;�رմ���,���������Ϊ�رձ�ǩҳ
~Esc::     
Keywait, Esc, , t0.5
if errorlevel = 1
return
else
Keywait, Esc, d, t0.2
if errorlevel = 0
{
IfWinActive ahk_class ahk_class IEFrame ;ʶ��IE�����
Send {ctrldown}w{ctrlup}
else IfWinActive ahk_class MozillaWindowClass ;ʶ��firfox �����
Send {ctrldown}w{ctrlup}
else
send !{F4}
}
return
 
;##################################################other script#############################################################
;###################################################�����ű�################################################################
 
 
;���ٰ�������Ctrl ����ճ��
/*
~LCtrl::
Keywait, LCtrl, , t0.5
if errorlevel = 1
return
else
Keywait, LCtrl, d, t0.3
if errorlevel = 0
{
Send,^v
}
return
*/
 
 
;win+shift+f �������Ͻ���һ���Ե�ǰ�����������ļ���
#+f::
Click right ;�����浱ǰ�������λ�õ������Ҽ�
Send, wf ;��ݼ��½��ļ���
Sleep, 125 ; ����ͣʱ���С
clipboard = %A_MM%-%A_DD%-%A_YYYY% ;%A_Hour%-%A_Min%-%A_Sec%-%A_MSec%;�ѵ�ǰ��ϵͳ���ڷ��͵�������
Send, ^v{Enter} ;���� Ctrl + v �ͻس�ȷ���޸��ļ�������
return
 
;ctrl+win+c �õ���ǰѡ���ļ���·��,���浽��������
^#c::
send ^c
sleep,200
clipboard=%clipboard% ;����:windows���Ƶ�ʱ��,�����屣����ǡ�·����.ֻ��·���������ַ���,ֻҪת�����ַ����Ϳ���ճ��������
tooltip,%clipboard% ;��ʾ�ı�
sleep,2000
tooltip, ;�ÿ�
return
 
; Win+O �ر���ʾ��
#o:: 
Sleep 1000  ; ���û��л����ͷŰ��� (�Է��ͷ�����ʱ�ٴλ���������).
SendMessage, 0x112, 0xF170, 2,, Program Manager   ; �ر���ʾ��: 0x112 Ϊ WM_SYSCOMMAND, 0xF170 Ϊ SC_MONITORPOWER. ; ��ʹ�� -1 ���� 2 ����ʾ����1 ���� 2 ������ʾ���Ľ���ģʽ
return

;��ȡ��ǰϵͳ����
::ddd::
;���ϵͳʱ���������ʱ�䣺2013-07-17�������Ҫ���ꡱ�Ļ����滻����ġ�-����
d = %A_YYYY%-%A_MM%-%A_DD% 
;�� d ��ֵ���͵������壬�����������������ñ�����ֵʱ�ڱ�����ǰ��ӡ�%����clipboard�� AHK �Դ��ı���:���а�
clipboard = %d% 
Send ^v
return

;��ȡ��ǰϵͳʱ��
::/time::
d = %A_Hour%:%A_Min%:%A_sec% 
clipboard = %d% 
Send ^v
return

;��ȡϵͳ���ں�ʱ��
::/all::
d = %A_YYYY%-%A_MM%-%A_DD% %A_Hour%:%A_Min%:%A_sec%
clipboard = %d% 
Send ^v
return

::/kou::
Send , koujincheng{Shift}{Tab}1234.abcdd{Enter}
return

;ѡ��·�������ٴ�
#j::
send ^c ; ����ѡ�е�����
clipwait ; �ȴ����ƶ��������
Clipboard := Trim(clipboard,A_Space) ;ȥ���ո�
Run  %clipboard%
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.
