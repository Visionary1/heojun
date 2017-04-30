;@Ahk2Exe-SetName 뉴 어의 로더
;@Ahk2Exe-SetDescription 뉴 어의 로더
;@Ahk2Exe-SetVersion 0.1
;@Ahk2Exe-SetCopyright 예지력
;@Ahk2Exe-SetOrigFileName 뉴 어의.exe
#SingleInstance, Force
#NoEnv
#NoTrayIcon
#KeyHistory, 0
ListLines, Off

json := JSON.Load(DownloadToStr("https://raw.githubusercontent.com/Visionary1/heojun/master/Package.json"))
Server := json.server = "ON" ? True : False
If !(Server) || (json.version > 0.1)
{
	Try Run, % json.updateurl
	ExitApp
}

main := new Package("https://github.com/Visionary1/heojun/raw/master/Package.exe", json.name)
main.dependency("https://github.com/Visionary1/heojun/raw/master/lib/3rd-party/MicroTimer.dll", "MicroTimer.dll")
main.dependency("https://github.com/Visionary1/heojun/raw/master/resource/px_green.png", "px_green.png")
main.dependency("https://github.com/Visionary1/heojun/raw/master/resource/btn_close.png", "btn_close.png")
pid := main.Load()
WinWaitClose, % "ahk_pid " . pid
main := ""
ExitApp

Class Package
{
	__New(url, name)
	{
		this.app := []
		this.app.url := url
		If (name = "RANDOM")
			this.app.filename := A_Temp . "\" . this._RandomStr() ".exe"
		Else
			this.app.filename := A_Temp . "\" . name . ".exe"

		UrlDownloadToFile, % this.app.url, % this.app.filename
		this.app.dependency := []
	}

	dependency(url, name)
	{
		this.app.dependency.Push(name)
		Try UrlDownloadToFile, % url, % A_Temp . "\" . name
	}

	__Delete()
	{
		Try FileDelete, % this.app.filename
		Catch, E
		{
			WinKill, % "ahk_pid " this.app.pid
			FileDelete, % this.app.filename
		}

		For Key, Value in this.app.dependency
			Try FileDelete, % A_Temp . "\" . Value

		this.Delete("app")
	}

	Load()
	{
		Try RunWait, % this.app.filename,,, OutputVarPID
		Catch, E
			this.__Delete()

		this.app.pid := OutputVarPID

		Return this.app.pid
	}

	_RandomStr() 
	{
		Loop, 4
		{
			Random, digits, 48, 57
			Random, uppercases, 65, 90
			Random, lowercases, 97, 122

			Random, Mix, 1, 3
			If (Mix = 1)
				s .= Chr(digits) . Chr(uppercases) . Chr(lowercases)
			Else If (Mix = 2)
				s .= Chr(digits) . Chr(lowercases) . Chr(uppercases)
			Else If (Mix = 3)
				s .= Chr(lowercases) . Chr(digits) . Chr(uppercases)
		}

		Return s
	}
}

#Include lib\3rd-party\Class JSON.ahk
#Include lib\3rd-party\Func DownloadToString.ahk