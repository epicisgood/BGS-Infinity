
#Requires AutoHotkey v2.0

version := "v1.0.1"
settingsFile := "settings.ini"





if (A_IsCompiled) {
	; WebViewCtrl.CreateFileFromResource((A_PtrSize * 4) "bit\WebView2Loader.dll", WebViewCtrl.TempDir)
    ; WebViewSettings := {DllPath: WebViewCtrl.TempDir "\" (A_PtrSize * 4) "bit\WebView2Loader.dll"}

	WebViewCtrl.CreateFileFromResource((A_PtrSize * 8) "bit\WebView2Loader.dll", WebViewCtrl.TempDir)
    WebViewSettings := {DllPath: WebViewCtrl.TempDir "\" (A_PtrSize * 8) "bit\WebView2Loader.dll"}
} else {
    WebViewSettings := {}
    TraySetIcon("images\\GameIcon.ico")
}




MyWindow := WebViewGui("-Resize -Caption ",,,WebViewSettings) ; ignore error it somehow works with it.....
MyWindow.OnEvent("Close", (*) => StopMacro())
MyWindow.Navigate("Pages/index.html")
; MyWindow.Debug()
MyWindow.AddHostObjectToScript("ButtonClick", { func: WebButtonClickEvent })
MyWindow.AddHostObjectToScript("Save", { func: SaveSettings })
MyWindow.AddHostObjectToScript("ReadSettings", { func: SendSettings })
MyWindow.AddHostObjectToScript("Dragger", { func: BeginDrag })
MyWindow.Show("w650 h500")




BeginDrag(*) {
    DllCall("ReleaseCapture")
    DllCall("SendMessage", "Ptr", MyWindow.Hwnd, "UInt", 0xA1, "UPtr", 2, "UPtr", 0)
}



F1::{
    Start
}

F2::{
    ResetMacro
}

Start(*) {
    PlayerStatus("Starting " version " BGSI Macro by epic", "0xFFFF00", , false, , false)
    OnError (e, mode) => (mode = "return") * (-1)
    Loop {
        MainLoop() 
    }
}

ResetMacro(*) { 
    ; PlayerStatus("Stopped BGSI Macro", "0xff8800", , false, , false)
    Send "{" Dkey " up}{" Wkey " up}{" Akey " up}{" Skey " up}{F14 up}"
    Try Gdip_Shutdown(pToken)
    nm_endWalk()
    Reload 
}
StopMacro(*) {
    PlayerStatus("Closed BGSI Macro", "0xff5e00", , false, , false)
    Send "{" Dkey " up}{" Wkey " up}{" Akey " up}{" Skey " up}{F14 up}"
    Try Gdip_Shutdown(pToken)
    nm_endWalk()
    ExitApp()
}

PauseMacro(*){
    global PauseToggle
    PauseToggle := !PauseToggle
    if PauseToggle {
        Pause(false) ; Unpause
        ToolTip "Macro Unpaused"
        PlayerStatus("Unpaused BGSI Macro", "0x91ff00", , false, , false)
    } else {
        Pause(true)  ; Pause
        ToolTip "Macro Paused"
        PlayerStatus("Paused BGSI Macro", "0x003cff", , false, , false)
    }
    SetTimer () => ToolTip(), -1000
}
toggle := false

FastHatch(*){
    global toggle
    toggle := !toggle
    if toggle {
        SetTimer(() => Send("e"), 500)
    } else {
        Reload
    }
}

BubbleHatch(*) {
    PlayerStatus("Starting " version " BubbleHatch Macro by epic", "0xFFFF00", , false, , false)

    ResizeRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    Loop {
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if !(Gdip_ImageSearch(pBMScreen, bitmaps["Bubble"], &OutputList , , , , , 15)) {
            Click("down")
            Send "{" SC_LShift " down}"
            Send "{" Lkey "}"
            Send "{" SC_LShift " up}"
        }
        Sleep 100
    }
}

MysteryBoxes(*) {
    ActivateRoblox()
    GetRobloxClientPos(GetRobloxHWND())
    global windowX, windowY, windowWidth, windowHeight
    PlayerStatus("Starting " version " MysteryBoxes Macro by epic", "0xFFFF00", , false, , false)

    loop {
        MouseMove(windowX + windowWidth * 0.2927, windowY + windowHeight * 0.75)
        Click
        Sleep(250) ; (562, 782)
        MouseMove(windowX + windowWidth * 0.2927, windowY + windowHeight * 0.78)
        Click
        Sleep(250) ; (562, 782)
        MouseMove(windowX + windowWidth * 0.6156, windowY + windowHeight * 0.5648), 
        Click 
        Sleep(250) ; (1182, 610)
        Loop 20{
            MouseMove(windowX + windowWidth * 0.6156, windowY + windowHeight * 0.5648), 
            Click 
            Sleep(20)
        }
        Sleep(50)
        Send("{f}")
    }
}




BoardGame(){
    ResizeRoblox()
    MsgBox("Make sure your inside of the minigame and have the dice selection screen open. Macro will try to detect GaintDice!")
    SetTimer(() => Send("r"), 500)
    PlayerStatus("Starting " version " Board Game Macro by epic", "0xFFFF00", , false, , false)
    GaintDice()
    loop {
        if (Disconnect()){
            EnterBoardGame()
            GaintDice()
        }
        UseDice()
        CheckInfinity()
    }
}


Enchant(){
    ResizeRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    MsgBox("Be inside of the enchanter on the select pet screen! Close the chat aswell!")
    PlayerStatus("Starting " version " Auto High Roller Enchanter Macro by epic", "0xFFFF00", , false, , false)

    ; Click pet, 
    ; find high roller and select auto reroll.
    ; Change pet
    ; select next pet
    coords := [
        [WindowX + WindowWidth * (486 / 1366), WindowY + WindowHeight * (265 / 736)],
        [WindowX + WindowWidth * (566 / 1366), WindowY + WindowHeight * (265 / 736)],
        [WindowX + WindowWidth * (641 / 1366), WindowY + WindowHeight * (265 / 736)],
        [WindowX + WindowWidth * (726 / 1366), WindowY + WindowHeight * (265 / 736)],
        [WindowX + WindowWidth * (800 / 1366), WindowY + WindowHeight * (265 / 736)],
        [WindowX + WindowWidth * (875 / 1366), WindowY + WindowHeight * (265 / 736)],

        ; Bottom row

        [WindowX + WindowWidth * (506 / 1366), WindowY + WindowHeight * (325 / 736)],
        [WindowX + WindowWidth * (586 / 1366), WindowY + WindowHeight * (325 / 736)],
        [WindowX + WindowWidth * (661 / 1366), WindowY + WindowHeight * (325 / 736)],
        [WindowX + WindowWidth * (746 / 1366), WindowY + WindowHeight * (325 / 736)],
        [WindowX + WindowWidth * (820 / 1366), WindowY + WindowHeight * (325 / 736)],

    ]

    for _, coord in coords {
        MouseMove(WindowX + WindowWidth * (793 / 1366), WindowY + WindowHeight * (332 / 736))
        Loop 6 {
            Send("{WheelUp}")
            Sleep 50
        }
        MouseMove coord[1], coord[2]
        Sleep(300)
        Click
        Sleep(500)
        MouseMove(WindowX + WindowWidth * (793 / 1366), WindowY + WindowHeight * (332 / 736))
        Loop 6 {
            Send("{WheelUp}")
            Sleep 50
        }
        Loop 2 {
            Send("{WheelDown}")
            Sleep 50
        }
        Sleep(500)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["HighRoller"], &OutputList , , , , , 15)) {
            Gdip_DisposeImage(pBMScreen)
            MouseMove(WindowX + WindowWidth * (401 / 1366), WindowY + WindowHeight * (598 / 736))
            Click
            Sleep(300) ; Manualy rerolling

            MouseMove(WindowX + WindowWidth * (618 / 1366), WindowY + WindowHeight * (442 / 736))
            Sleep(300)
            Click
            Sleep(500)
            
            ; High roller
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1] + 130, coords[2]+110
            Sleep(300)
            Click
            Sleep(700)
            MouseMove(WindowX + WindowWidth * (618 / 1366), WindowY + WindowHeight * (442 / 736))
            Sleep(300)
            Click
            Sleep(500)
        } else {
            Gdip_DisposeImage(pBMScreen)
            continue
        }


        loop {
            pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
            if (Gdip_ImageSearch(pBMScreen, bitmaps["HighRoller"], &OutputList , , , , , 15)) {
                Gdip_DisposeImage(pBMScreen)
                PlayerStatus("Switching Pets! ✅","0x22e6bc",,false)
                MouseMove(WindowX + WindowWidth * (444 / 1366), WindowY + WindowHeight * (190 / 736))
                Sleep(300)
                Click
                break
            }
            Sleep(1000)
            if (Gdip_ImageSearch(pBMScreen, bitmaps["disconnected"], , , , , , 2) = 1 || GetRobloxHWND() == 0)  {
                PlayerStatus("Disconnected. Please restart macro! ❌","0xe62222",,true)
                break 2
            }
            if (Gdip_ImageSearch(pBMScreen, bitmaps["UhOh"], , , , , , 15)) {
                PlayerStatus("Ran out of gems. Restart macro! ❌","0xe62222",,true)
                break 2
            }
            Gdip_DisposeImage(pBMScreen)
        }

    }

    PlayerStatus("Auto Enchant finished! 🎉✅💵","0x22e6bc",,true)

}


ElevateScript() {
    Try file := FileOpen("scripts\functions.ahk", "a")
    Catch {
        if (!A_IsAdmin || !(DllCall("GetCommandLine","Str") ~= " /restart(?!\S)"))
            Try RunWait '*RunAs "' A_AhkPath '" /script /restart "' A_ScriptFullPath '"'
        if !A_IsAdmin {
            MsgBox "You must run BGSI Macro as administrator in this folder!`nOr move the macro to a different folder.", "Error", 0x40010
            ExitApp
        }
        MsgBox "Cannot write in this folder—try a different directory.", "Error", 0x40010
    }
}
ElevateScript()

ScreenResolution() {
    if (A_ScreenDPI != 96) {
        MsgBox "
        (
        Your Display Scale seems to be ≠100%. The macro will NOT work correctly!
        Set Scale to 100% in Display Settings, then restart Roblox & this macro.
        )", "WARNING!!", 0x1030 " T60"
    }
}
ScreenResolution()




WebButtonClickEvent(button) {
	switch button {
		case "Start":
			Send("{F1}")
        case "Stop":
			Send("{F2}")
        case "Pause":
			Send("{F3}")
		case "FastHatch": 
			FastHatch()
		case "BubbleHatch": 
			BubbleHatch()
		case "MysteryBox": 
			MysteryBoxes()
		case "BoardGame": 
			BoardGame()
        case "Enchant": 
            Enchant()
	}
}



SaveSettings(settings) {
	settings := JSON.parse(settings)

    IniFile := A_ScriptDir . "\settings.ini"

    for key, val in settings {
        IniWrite(val, IniFile, "Settings", key)
    }
	Reload	
}

SendSettings(){
	settingsFile := A_ScriptDir . "\settings.ini"
	IniFile := A_ScriptDir . "\settings.ini"

    if (!FileExist(IniFile)) {
        IniWrite("", IniFile, "Settings", "url")
        IniWrite("", IniFile, "Settings", "discordID")
        IniWrite("", IniFile, "Settings", "VipLink")
        IniWrite(1, IniFile, "Settings", "GiantChest")
        IniWrite(1, IniFile, "Settings", "VoidChest")
        IniWrite(0, IniFile, "Settings", "InfinityChest")
        IniWrite(1, IniFile, "Settings", "DiceMerchant")
        IniWrite(1, IniFile, "Settings", "Presents")
        IniWrite(1, IniFile, "Settings", "AlienShop")
        IniWrite(1, IniFile, "Settings", "TicketChest")
        IniWrite(1, IniFile, "Settings", "BlackMarket")
        IniWrite(1, IniFile, "Settings", "TravelingMerchant")
        IniWrite(0, IniFile, "Settings", "GemGenie")
        IniWrite(0, IniFile, "Settings", "RerollGemGenie")
        IniWrite(1, IniFile, "Settings", "SeasonQuests")
        IniWrite(1, IniFile, "Settings", "BubbleShrine")
        IniWrite("BlackMarket", IniFile, "Settings", "Reroll")
        IniWrite(0, IniFile, "Settings", "InfinityElixer") ; comp event not working rn
        IniWrite(0, IniFile, "Settings", "Premiumperk")
        IniWrite(0, IniFile, "Settings", "Teams")
        IniWrite(0, IniFile, "Settings", "BlowBubbles")
        IniWrite("CoinCurrency", IniFile, "Settings", "Macro")
    }
	
    SettingsJson := { 
      url:                  IniRead(settingsFile, "Settings", "url")
    , discordID:            IniRead(settingsFile, "Settings", "discordID")
    , VipLink:              IniRead(settingsFile, "Settings", "VipLink")
    , VoidChest:            IniRead(settingsFile, "Settings", "VoidChest")
    , InfinityChest:        IniRead(settingsFile, "Settings", "InfinityChest")
    , GiantChest:           IniRead(settingsFile, "Settings", "GiantChest")
    , DiceMerchant:         IniRead(settingsFile, "Settings", "DiceMerchant")
    , Presents:             IniRead(settingsFile, "Settings", "Presents")
    , AlienShop:            IniRead(settingsFile, "Settings", "AlienShop")
    , TicketChest:          IniRead(settingsFile, "Settings", "TicketChest")
    , BlackMarket:          IniRead(settingsFile, "Settings", "BlackMarket")
    , TravelingMerchant:    IniRead(settingsFile, "Settings", "TravelingMerchant")
    , GemGenie:             IniRead(settingsFile, "Settings", "GemGenie")
    , RerollGemGenie:       IniRead(settingsFile, "Settings", "RerollGemGenie")
    , SeasonQuests:         IniRead(settingsFile, "Settings", "SeasonQuests")
    , BubbleShrine:         IniRead(settingsFile, "Settings", "BubbleShrine")
    , Reroll:               IniRead(settingsFile, "Settings", "Reroll")
    , InfinityElixer:       IniRead(settingsFile, "Settings", "InfinityElixer")
    , Premiumperk:          IniRead(settingsFile, "Settings", "Premiumperk")
    , Teams:                IniRead(settingsFile, "Settings", "Teams")
    , BlowBubbles:          IniRead(settingsFile, "Settings", "BlowBubbles")
    , Macro:                IniRead(settingsFile, "Settings", "Macro")
    }
	Sleep(200)
	MyWindow.PostWebMessageAsJson(JSON.stringify(SettingsJson))
}

SendSettings()

url             := IniRead(settingsFile, "Settings", "url")
discordID       := IniRead(settingsFile, "Settings", "discordID")
VipLink         := IniRead(settingsFile, "Settings", "VipLink")
Macro           := IniRead(settingsFile, "Settings", "Macro")






PlayerStatus("Connected to discord!", "0x34495E", , false, , false)










AsyncHttpRequest(method, url, func?, headers?) {
	req := ComObject("Msxml2.XMLHTTP")
	req.open(method, url, true)
	if IsSet(headers)
		for h, v in headers
			req.setRequestHeader(h, v)
	if IsSet(func)
		req.onreadystatechange := func.Bind(req)
	req.send()
}


CheckUpdate(req)
{

	if (req.readyState != 4)
		return

	if (req.status = 200)
	{
		LatestVer := Trim((latest_release := JSON.parse(req.responseText))["tag_name"], "v")
        
		if (VerCompare(version, LatestVer) < 0)
		{

            message := "
            (
            A new update is available!

            Would you like to open the GitHub release page
            to download the latest version?

            )"

            if MsgBox(message, "Update Available", 0x40004 | 0x40 | 0x4 ) = "Yes" ; 0x4 = Yes/No, 0x40 = info icon, 0x1 = OK/Cancel default button
            {
                Run "https://github.com/epicisgood/BGS-Infinity/releases/latest"
            }

        }
	}
}


AsyncHttpRequest("GET", "https://api.github.com/repos/epicisgood/BGS-Infinity/releases/latest", CheckUpdate, Map("accept", "application/vnd.github+json"))


