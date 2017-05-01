;@Ahk2Exe-SetName new 어의
;@Ahk2Exe-SetDescription new 어의
;@Ahk2Exe-SetVersion 0.1.1
;@Ahk2Exe-SetCopyright 예지력
#SingleInstance, Force
#NoEnv
#NoTrayIcon
#KeyHistory, 0
ListLines, Off
OnExit("Destruct")

FileInstall, resource\btn_close.png, % A_Temp "\btn_close.png", 1
FileInstall, resource\px_green.png, % A_Temp "\px_green.png", 1
FileInstall, lib\3rd-party\MicroTimer.dll, % A_Temp "\MicroTimer.dll", 1

Package := new HeoJun()
Package.RegisterCloseCallback := Func("Destruct")
Return

Destruct(self)
{
	Try self.Destruct()
	self := ""
	ExitApp
}

#Include, lib\Class HeoJun.ahk