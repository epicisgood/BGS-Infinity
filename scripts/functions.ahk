HyperSleep(ms) {
    static freq := (DllCall("QueryPerformanceFrequency", "Int64*", &f := 0), f)
    DllCall("QueryPerformanceCounter", "Int64*", &begin := 0)
    current := 0, finish := begin + ms * freq / 1000
    while (current < finish) {
        if ((finish - current) > 30000) {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
        }
        DllCall("QueryPerformanceCounter", "Int64*", &current)
    }
}


nm_KeyVars(){
    return
	(
	'
    Wkey := "' Wkey '" ; a
    Akey := "' Akey '" ; s
    Dkey := "' Dkey '" ; w
    Skey := "' Skey '" ; d
    RotLeft := "' RotLeft '" ; ,
    RotRight := "' RotRight '" ; .
    RotUp := "' RotUp '" ; PgUp
    RotDown := "' RotDown '" ; PgDn
    ZoomIn := "' ZoomIn '" ; i
    ZoomOut := "' ZoomOut '" ; o
    Ekey := "' Ekey '" ; e
    Rkey := "' Rkey '" ; r
    Lkey := "' Lkey '" ; l
    EscKey := "' EscKey '" ; Esc
    EnterKey := "' EnterKey '" ; Enter
    SpaceKey := "' SpaceKey '" ; Space
    SlashKey := "' SlashKey '" ; /
    SC_LShift:="' SlashKey '" ; LShift
    '
	)
}

nm_Walk(Milliseconds, MoveKey1, MoveKey2:=0){ ; string form of the function which holds MoveKey1 (and optionally MoveKey2) down for 'tiles' tiles, not to be confused with the pure form in nm_createWalk below
	return
	(
	'Send "{' MoveKey1 ' down}' (MoveKey2 ? '{' MoveKey2 ' down}"' : '"') '
	HyperSleep(' Milliseconds ')
	Send "{' MoveKey1 ' up}' (MoveKey2 ? '{' MoveKey2 ' up}"' : '"')
	)
}
nm_createWalk(movement, name:="", vars:="") ; this function generates the 'walk' code and runs it for a given 'movement' (AHK code string), using movespeed correction if 'NewWalk' is enabled and legacy movement otherwise
{
	; F13 is used by 'natro_macro.ahk' to tell 'walk' to complete a cycle
	; F14 is held down by 'walk' to indicate that the cycle is in progress, then released when the cycle is finished
	; F16 can be used by any script to pause / unpause the walk script, when unpaused it will resume from where it left off

	DetectHiddenWindows 1 ; allow communication with walk script
    
	script :=
	(
	'
    #SingleInstance Off
    #NoTrayIcon
    ProcessSetPriority("AboveNormal")
    Setkeydelay ' KeyDelay '
    KeyHistory 0
    ListLines 0
    OnExit(ExitFunc)

    #Include "%A_ScriptDir%\lib"
    #Include "Gdip_All.ahk"
    #Include "Gdip_ImageSearch.ahk"
    #Include "Roblox.ahk"



	; #Include Walk.ahk performs most of the initialisation, i.e. creating bitmaps and storing the necessary functions
	; MoveSpeedNum must contain the exact in-game movespeed without buffs so the script can calculate the true base movespeed
	
    pToken := Gdip_Startup()
    bitmaps := Map()
    bitmaps.CaseSense := 0
	
	bitmaps["Bubble"] := Gdip_BitmapFromBase64("iVBORw0KGgoAAAANSUhEUgAAABIAAAASCAYAAABWzo5XAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsEAAA7BAbiRa+0AAAGHaVRYdFhNTDpjb20uYWRvYmUueG1wAAAAAAA8P3hwYWNrZXQgYmVnaW49J++7vycgaWQ9J1c1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCc/Pg0KPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyI+PHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj48cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0idXVpZDpmYWY1YmRkNS1iYTNkLTExZGEtYWQzMS1kMzNkNzUxODJmMWIiIHhtbG5zOnRpZmY9Imh0dHA6Ly9ucy5hZG9iZS5jb20vdGlmZi8xLjAvIj48dGlmZjpPcmllbnRhdGlvbj4xPC90aWZmOk9yaWVudGF0aW9uPjwvcmRmOkRlc2NyaXB0aW9uPjwvcmRmOlJERj48L3g6eG1wbWV0YT4NCjw/eHBhY2tldCBlbmQ9J3cnPz4slJgLAAAAJUlEQVQ4T2P8n3bkPwMVABO6ALlg1CDCYNQgwmDUIMJg1CDCAACNswNM6BfKFgAAAABJRU5ErkJggg==")

    
	'

	'

	' nm_KeyVars() '
	' vars '

	start()
	return

	nm_Walk(tiles, MoveKey1, MoveKey2:=0)
	{
		Send "{" MoveKey1 " down}" (MoveKey2 ? "{" MoveKey2 " down}" : "")
		' ('HyperSleep(tiles)') '
		Send "{" MoveKey1 " up}" (MoveKey2 ? "{" MoveKey2 " up}" : "")
	}

    HyperSleep(ms) {
    static freq := (DllCall("QueryPerformanceFrequency", "Int64*", &f := 0), f)
    DllCall("QueryPerformanceCounter", "Int64*", &begin := 0)
    current := 0, finish := begin + ms * freq / 1000
    while (current < finish) {
        if ((finish - current) > 30000) {
            DllCall("Winmm.dll\timeBeginPeriod", "UInt", 1)
            DllCall("Sleep", "UInt", 1)
            DllCall("Winmm.dll\timeEndPeriod", "UInt", 1)
        }
        DllCall("QueryPerformanceCounter", "Int64*", &current)
        }
    }

	DetectBubble(){
		Sleep(1000)
		loop 20 {
			ActivateRoblox()
			hwnd := GetRobloxHWND()
			GetRobloxClientPos(hwnd)
			pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
			if (Gdip_ImageSearch(pBMScreen, bitmaps["Bubble"], &OutputList,,, , , , 5) = 1) {
				Gdip_DisposeImage(pBMScreen)
				Sleep(500)
				return
			} else {
				Gdip_DisposeImage(pBMScreen)
				Sleep(500)
			}
			
		}

	}
	F13::
		start(hk?)
		{
			Send "{F14 down}"
			' movement '
			Send "{F14 up}"
		}

	F16::
	{
		static key_states := Map(Skey,0, Wkey,0, Dkey,0, Akey,0, SpaceKey,0)
		if A_IsPaused
		{
			for k,v in key_states
				if (v = 1)
					Send "{" k " down}"
		}
		else
		{
			for k,v in key_states
			{
				key_states[k] := GetKeyState(k)
				Send "{" k " up}"
			}
		}
		Pause -1
	}

	ExitFunc(*)
	{
		Send "{' Skey ' up}{' Wkey ' up}{' Dkey ' up}{' Akey ' up}{' SpaceKey ' up}{F14 up}"
		try Gdip_Shutdown(pToken)
	}
	'
	) ; this is just ahk code, it will be executed as a new script

    shell := ComObject("WScript.Shell")
    exec := shell.Exec('"' A_AhkPath '" /script /force *')
    exec.StdIn.Write(script)
    exec.StdIn.Close()

	if WinWait("ahk_class AutoHotkey ahk_pid " exec.ProcessID, , 2) {
		DetectHiddenWindows 0
		currentWalk.pid := exec.ProcessID, currentWalk.name := name
		return 1
	}
	else {
		DetectHiddenWindows 0
		return 0
	}
}


nm_endWalk() ; this function ends the walk script
{
	global currentWalk
	DetectHiddenWindows 1
	try WinClose "ahk_class AutoHotkey ahk_pid " currentWalk.pid
	DetectHiddenWindows 0
	currentWalk.pid := currentWalk.name := ""
	; if issues, we can check if closed, else kill and force keys up
}

GetpBMScreen(pX := 0, pY := 0, pWidth := 0, pHeight := 0) {
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)

    global windowX, windowY, windowWidth, windowHeight
    x := (pX != 0) ? pX : windowX
    y := (pY != 0) ? pY : windowY
    width := (pWidth != 0) ? pWidth : windowWidth
    height := (pHeight != 0) ? pHeight : windowHeight

    return Gdip_BitmapFromScreen(x "|" y "|" width "|" height)
}




/**
 * @param {Integer} direction - 1|left, 0|right
 * @param {Integer} amount - 4-degree - [1,2,3,4]
*/
RotateCamera(direction:=0, amount:=0) {
    ActivateRoblox()
    hwnd:=GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    MouseMove(windowX+(windowWidth/2), windowY+(windowHeight/2))
    Click "Down R"
    sleep 100
    loop round(36*amount) {
        if !(direction=1)
            DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", 5, "Int", 0)
    else
        DllCall("user32.dll\mouse_event", "UInt", 0x0001, "Int", -5, "Int", 0)
    }
    sleep 100
    Click "Up R"
    MouseMove(windowX+(windowWidth/2), windowY+(windowHeight/2))
}




MacroSetting(a){
    if (IniRead(settingsFile, "Settings", "Macro") == a){
        return true
    }
    return false
}



HBitmapToRandomAccessStream(hBitmap) {
	static IID_IRandomAccessStream := "{905A0FE1-BC53-11DF-8C49-001E4FC686DA}"
			, IID_IPicture            := "{7BF80980-BF32-101A-8BBB-00AA00300CAB}"
			, PICTYPE_BITMAP := 1
			, BSOS_DEFAULT   := 0
			, sz := 8 + A_PtrSize * 2

	DllCall("Ole32\CreateStreamOnHGlobal", "Ptr", 0, "UInt", true, "PtrP", &pIStream:=0, "UInt")

	PICTDESC := Buffer(sz, 0)
	NumPut("uint", sz
		, "uint", PICTYPE_BITMAP
		, "ptr", hBitmap, PICTDESC)

	riid := CLSIDFromString(IID_IPicture)
	DllCall("OleAut32\OleCreatePictureIndirect", "Ptr", PICTDESC, "Ptr", riid, "UInt", false, "PtrP", &pIPicture:=0, "UInt")
	; IPicture::SaveAsFile
	ComCall(15, pIPicture, "Ptr", pIStream, "UInt", true, "UIntP", &size:=0, "UInt")
	riid := CLSIDFromString(IID_IRandomAccessStream)
	DllCall("ShCore\CreateRandomAccessStreamOverStream", "Ptr", pIStream, "UInt", BSOS_DEFAULT, "Ptr", riid, "PtrP", &pIRandomAccessStream:=0, "UInt")
	ObjRelease(pIPicture)
	ObjRelease(pIStream)
	Return pIRandomAccessStream
}

CLSIDFromString(IID, &CLSID?) {
	CLSID := Buffer(16)
	if res := DllCall("ole32\CLSIDFromString", "WStr", IID, "Ptr", CLSID, "UInt")
	throw Error("CLSIDFromString failed. Error: " . Format("{:#x}", res))
	Return CLSID
}

ocr(file, lang := "FirstFromAvailableLanguages")
{
	static OcrEngineStatics, OcrEngine, MaxDimension, LanguageFactory, Language, CurrentLanguage:="", BitmapDecoderStatics, GlobalizationPreferencesStatics
	if !IsSet(OcrEngineStatics)
	{
		CreateClass("Windows.Globalization.Language", ILanguageFactory := "{9B0252AC-0C27-44F8-B792-9793FB66C63E}", &LanguageFactory)
		CreateClass("Windows.Graphics.Imaging.BitmapDecoder", IBitmapDecoderStatics := "{438CCB26-BCEF-4E95-BAD6-23A822E58D01}", &BitmapDecoderStatics)
		CreateClass("Windows.Media.Ocr.OcrEngine", IOcrEngineStatics := "{5BFFA85A-3384-3540-9940-699120D428A8}", &OcrEngineStatics)
		ComCall(6, OcrEngineStatics, "uint*", &MaxDimension:=0)
	}
	text := ""
	if (file = "ShowAvailableLanguages")
	{
		if !IsSet(GlobalizationPreferencesStatics)
			CreateClass("Windows.System.UserProfile.GlobalizationPreferences", IGlobalizationPreferencesStatics := "{01BF4326-ED37-4E96-B0E9-C1340D1EA158}", &GlobalizationPreferencesStatics)
		ComCall(9, GlobalizationPreferencesStatics, "ptr*", &LanguageList:=0)   ; get_Languages
		ComCall(7, LanguageList, "int*", &count:=0)   ; count
		loop count
		{
			ComCall(6, LanguageList, "int", A_Index-1, "ptr*", &hString:=0)   ; get_Item
			ComCall(6, LanguageFactory, "ptr", hString, "ptr*", &LanguageTest:=0)   ; CreateLanguage
			ComCall(8, OcrEngineStatics, "ptr", LanguageTest, "int*", &bool:=0)   ; IsLanguageSupported
			if (bool = 1)
			{
				ComCall(6, LanguageTest, "ptr*", &hText:=0)
				b := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", &length:=0, "ptr")
				text .= StrGet(b, "UTF-16") "`n"
			}
			ObjRelease(LanguageTest)
		}
		ObjRelease(LanguageList)
		return text
	}
	if (lang != CurrentLanguage) or (lang = "FirstFromAvailableLanguages")
	{
		if IsSet(OcrEngine)
		{
			ObjRelease(OcrEngine)
			if (CurrentLanguage != "FirstFromAvailableLanguages")
				ObjRelease(Language)
		}
		if (lang = "FirstFromAvailableLanguages")
			ComCall(10, OcrEngineStatics, "ptr*", &OcrEngine:=0)   ; TryCreateFromUserProfileLanguages
		else
		{
			CreateHString(lang, &hString)
			ComCall(6, LanguageFactory, "ptr", hString, "ptr*", &Language:=0)   ; CreateLanguage
			DeleteHString(hString)
			ComCall(9, OcrEngineStatics, "ptr", Language, "ptr*", &OcrEngine:=0)   ; TryCreateFromLanguage
		}
		if (OcrEngine = 0)
		{
			msgbox 'Can not use language "' lang '" for OCR, please install language pack.'
			ExitApp
		}
		CurrentLanguage := lang
	}
	IRandomAccessStream := file
	ComCall(14, BitmapDecoderStatics, "ptr", IRandomAccessStream, "ptr*", &BitmapDecoder:=0)   ; CreateAsync
	WaitForAsync(&BitmapDecoder)
	BitmapFrame := ComObjQuery(BitmapDecoder, IBitmapFrame := "{72A49A1C-8081-438D-91BC-94ECFC8185C6}")
	ComCall(12, BitmapFrame, "uint*", &width:=0)   ; get_PixelWidth
	ComCall(13, BitmapFrame, "uint*", &height:=0)   ; get_PixelHeight
	if (width > MaxDimension) or (height > MaxDimension)
	{
		msgbox "Image is to big - " width "x" height ".`nIt should be maximum - " MaxDimension " pixels"
		ExitApp
	}
	BitmapFrameWithSoftwareBitmap := ComObjQuery(BitmapDecoder, IBitmapFrameWithSoftwareBitmap := "{FE287C9A-420C-4963-87AD-691436E08383}")
	ComCall(6, BitmapFrameWithSoftwareBitmap, "ptr*", &SoftwareBitmap:=0)   ; GetSoftwareBitmapAsync
	WaitForAsync(&SoftwareBitmap)
	ComCall(6, OcrEngine, "ptr", SoftwareBitmap, "ptr*", &OcrResult:=0)   ; RecognizeAsync
	WaitForAsync(&OcrResult)
	ComCall(6, OcrResult, "ptr*", &LinesList:=0)   ; get_Lines
	ComCall(7, LinesList, "int*", &count:=0)   ; count
	loop count
	{
		ComCall(6, LinesList, "int", A_Index-1, "ptr*", &OcrLine:=0)
		ComCall(7, OcrLine, "ptr*", &hText:=0)
		buf := DllCall("Combase.dll\WindowsGetStringRawBuffer", "ptr", hText, "uint*", &length:=0, "ptr")
		text .= StrGet(buf, "UTF-16") "`n"
		ObjRelease(OcrLine)
	}
	Close := ComObjQuery(IRandomAccessStream, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
	ComCall(6, Close)   ; Close
	Close := ComObjQuery(SoftwareBitmap, IClosable := "{30D5A829-7FA4-4026-83BB-D75BAE4EA99E}")
	ComCall(6, Close)   ; Close
	ObjRelease(IRandomAccessStream)
	ObjRelease(BitmapDecoder)
	ObjRelease(SoftwareBitmap)
	ObjRelease(OcrResult)
	ObjRelease(LinesList)
	return text
}

CreateClass(str, interface, &Class)
{
	CreateHString(str, &hString)
	GUID := CLSIDFromString(interface)
	result := DllCall("Combase.dll\RoGetActivationFactory", "ptr", hString, "ptr", GUID, "ptr*", &Class:=0)
	if (result != 0)
	{
		if (result = 0x80004002)
			msgbox "No such interface supported"
		else if (result = 0x80040154)
			msgbox "Class not registered"
		else
			msgbox "error: " result
	}
	DeleteHString(hString)
}

CreateHString(str, &hString)
{
	DllCall("Combase.dll\WindowsCreateString", "wstr", str, "uint", StrLen(str), "ptr*", &hString:=0)
}

DeleteHString(hString)
{
	DllCall("Combase.dll\WindowsDeleteString", "ptr", hString)
}

WaitForAsync(&Object)
{
	AsyncInfo := ComObjQuery(Object, IAsyncInfo := "{00000036-0000-0000-C000-000000000046}")
	loop
	{
		ComCall(7, AsyncInfo, "uint*", &status:=0)   ; IAsyncInfo.Status
		if (status != 0)
		{
			if (status != 1)
			{
				ComCall(8, AsyncInfo, "uint*", &ErrorCode:=0)   ; IAsyncInfo.ErrorCode
				msgbox "AsyncInfo status error: " ErrorCode
				ExitApp
			}
			break
		}
		sleep 10
	}
	ComCall(8, Object, "ptr*", &ObjectResult:=0)   ; GetResults
	ObjRelease(Object)
	Object := ObjectResult
}