;@Ahk2Exe-SetName new 어의
;@Ahk2Exe-SetDescription new 어의
;@Ahk2Exe-SetVersion 0.1
;@Ahk2Exe-SetCopyright 예지력
#SingleInstance, Force
#NoEnv
#NoTrayIcon
#KeyHistory, 0
ListLines, Off
OnExit("Destruct")

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