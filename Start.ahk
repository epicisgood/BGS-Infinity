#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn VarUnset, Off
SetWorkingDir A_ScriptDir
KeyDelay := 40

Setkeydelay KeyDelay


GetRobloxClientPos()
pToken := Gdip_Startup()
bitmaps := Map()
bitmaps.CaseSense := 0
currentWalk := {pid:"", name:""} ; stores "pid" (script process ID) and "name" (pattern/movement name)
CoordMode "Mouse", "Screen"
CoordMode "Pixel", "Screen"
SendMode "Event"

; WKey := "sc020" ; w
; AKey := "sc011" ; a
; SKey := "sc01e" ; s
; Dkey := "sc01f" ; d

WKey:="sc011" ; w
AKey:="sc01e" ; a
SKey:="sc01f" ; s
Dkey:="sc020" ; d


RotLeft := "vkBC" ; ,
RotRight := "vkBE" ; .
RotUp := "sc149" ; PgUp
RotDown := "sc151" ; PgDn
ZoomIn := "sc017" ; i
ZoomOut := "sc018" ; o
Ekey := "sc012" ; e
Rkey := "sc013" ; r
Lkey := "sc026" ; l
EscKey := "sc001" ; Esc
EnterKey := "sc01c" ; Enter
SpaceKey := "sc039" ; Space
SlashKey := "vk6F" ; /
SC_LShift:="sc02a" ; LShift


#include %A_ScriptDir%\lib\

#Include FormData.ahk
#Include Gdip_All.ahk
#include Gdip_ImageSearch.ahk
#include json.ahk
#Include roblox.ahk
#Include ComVar.ahk
#Include Promise.ahk
#Include WebView2.ahk
#Include WebViewToo.ahk

#Include %A_ScriptDir%\images\
#include bitmaps.ahk
#include %A_ScriptDir%\scripts\

#Include functions.ahk
#Include gui.ahk
#Include webhook.ahk
#Include timers.ahk
#Include paths.ahk


#Include comp.ahk ; for competitve event paid only or ya



/**
 * @param {Integer} amount How much to scroll from the bottom
*/
Teleport(amount){
    Send "{m}"
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    MouseMove windowX + windowWidth//4, windowY + windowHeight//4
    loop {
        ActivateRoblox()
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Teleport"], &OutputList,,, , , 2, , 3) = 1) {
            ; scroll to bottom
            Loop 10 {
                Send("{WheelDown}")
                Sleep 50
            }
            ;  to world!
            MouseMove(WindowX + WindowWidth * (958 / 1366),WindowY + WindowHeight * (170 / 736))
            Sleep(300)
            loop amount {
                Click
                Sleep(200)
            }
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep 500
            Click
            Click
            DetectBubble()
            Gdip_DisposeImage(pBMScreen)
            return 1
        } else if (A_index = 15){
            Gdip_DisposeImage(pBMScreen)
            CheckDisconnnect()
            PlayerStatus("WARNING!! MACRO NO WORK!!! ⚠️⚠️⚠️⚠️⚠️","0xe3e622",,true)
            return 1
        }

        if (A_Index == 7){
            MouseMove(WindowX + WindowWidth * (749 / 1366),WindowY + WindowHeight * (687 / 736))
            Sleep(300)
            MouseMove windowX + windowWidth//4, windowY + windowHeight//4
        }


        Gdip_DisposeImage(pBMScreen)
        Sleep 500
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
            return true
        } else {
            Gdip_DisposeImage(pBMScreen)
            Sleep(500)
        }
    }

}

EggBubbleDetect(){
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["Bubble"], &OutputList,,, , , , 5) = 1) {
        Gdip_DisposeImage(pBMScreen)
        Send("e")
        Sleep(300)
        return true
    } else {
        Gdip_DisposeImage(pBMScreen)
        return false
    }
}

CheckDisconnnect(){
    global VipLink
    GetRobloxClientPos()
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["disconnected"], , , , , , 2) = 1 || GetRobloxHWND() == 0)  {
        PlayerStatus("Starting BGSI", "0x00a838", ,false, ,false)    
        Gdip_DisposeImage(pBMScreen)
        CloseRoblox()
        PlaceID := 85896571713843

        linkCode := ""
        shareCode := ""

        if RegExMatch(VipLink, "privateServerLinkCode=(\d+)", &match)
            linkCode := match[1]
        else if RegExMatch(VipLink, "code=([a-f0-9]+)&type=Server", &match)
            shareCode := match[1]

        if linkCode {
            DeepLink := "roblox://placeID=" PlaceID "&linkCode=" linkCode
        } else if shareCode {
            DeepLink := "roblox://navigation/share_links?code=" shareCode "&type=Server"
        } else {
            DeepLink := "roblox://placeID=" PlaceID
        }
        try Run DeepLink
        loop 20 {
            if GetRobloxHWND() {
                ActivateRoblox()
                GetRobloxClientPos(GetRobloxHWND())
                ResizeRoblox()
                Sleep(20000)
                pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
                if (Gdip_ImageSearch(pBMScreen, bitmaps["Play"], , , , , , 15) = 1)  {
                    Gdip_DisposeImage(pBMScreen)
                    MouseMove(WindowX + WindowWidth * (623 / 1366), WindowY + WindowHeight * (375 / 736))
                    Click
                    MouseMove(WindowX + WindowWidth * (785 / 1366), WindowY + WindowHeight * (375 / 736))
                    Click
                    Sleep(1000)
                    Click
                    Sleep(14000)
                    ClaimDaily()
                    CameraCorrection()
                    PlayerStatus("Loaded BGSI", "0x0081a8", ,false)    
                    global LastPresents := nowUnix()
                    return 1
                } else {
                    Gdip_DisposeImage(pBMScreen)
                    CloseRoblox()
                    return 0
                }
            }
            if (A_Index = 20) {
                return 0
            }
            Sleep 1000
        }
    }
    Gdip_DisposeImage(pBMScreen)
    return 0

}


ClaimDaily(){
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["ClaimDaily"], &OutputList,,, , , 25, ,2) = 1) {
        coords := StrSplit(OutputList, ",")
        MouseMove coords[1], coords[2]+60
        Sleep 1000
        Click
        Click
        CloseAllPpopups()
    }
}


CameraCorrection(){
    send "{" EscKey "}"
    Sleep(300)
    send "{" Rkey "}"
    Sleep(300)
    send "{" EnterKey "}"
    Sleep(300)
    send "{" EnterKey "}"
    Sleep(300)
    send "{" EnterKey "}"

    global Wkey, Akey, Skey, Dkey
    
    WKey:="sc011" ; w
    AKey:="sc01e" ; a
    SKey:="sc01f" ; s
    Dkey:="sc020" ; d
    
    loop {
        Teleport(1)
        CloseAllPpopups()

        movement := 
        (
            '
            nm_walk(50,Wkey)
            nm_walk(1000,Akey)
            '
        )   
        nm_createWalk(movement)
        KeyWait "F14", "D T5 L"
        KeyWait "F14", "T120 L"
        nm_endWalk()

        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["WheelSpin"], , , , , , 20) = 1)  {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
        Gdip_DisposeImage(pBMScreen)

        WKey := "sc01e" ; w
        AKey := "sc01f" ; a
        SKey := "sc020" ; s
        Dkey := "sc011" ; d


        
        if (A_Index = 3){
            CloseRoblox()
            CheckDisconnnect()
        }
    }

}





CheckFonudE(){
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    loop {
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["E"], , , , , , 35) = 1) {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
        Sleep(500)
        Gdip_DisposeImage(pBMScreen)
        if (A_Index == 1500){
            return 0
        }
    }
}


CheckEgg(){
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["E"], , , , , , 35) = 1) {
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    Gdip_DisposeImage(pBMScreen)
    return 0
}



CloseAllPpopups(){
    if (Disconnect()){
        return
    }
    ActivateRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["Sell"], &OutputList, , , , , 35) = 1) {
        PlayerStatus("Error Found!","0xff0062",,false)
        coords := StrSplit(OutputList, ",")
        MouseMove coords[1] + 30, coords[2]+60
        Sleep 200
        Click
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    if (Gdip_ImageSearch(pBMScreen, bitmaps["X"], &OutputList, , , , , 35) = 1) {
        PlayerStatus("Error Found!","0xff0062",,false)
        coords := StrSplit(OutputList, ",")
        MouseMove coords[1] + 30, coords[2]+60
        Sleep 200
        Click
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    if (Gdip_ImageSearch(pBMScreen, bitmaps["Robux"], &OutputList, , , , , 35) = 1) {
        PlayerStatus("Error Found!","0xff0062",,false)
        coords := StrSplit(OutputList, ",")
        MouseMove coords[1] + 30, coords[2]+60
        Sleep 200
        Click
        Gdip_DisposeImage(pBMScreen)
        return 1
    }
    return 0


}


SmartTeams(value){
    ; Assuming 1st pet is currency, 2nd pet is high roller

    if !(RewardChecked("Teams")){
        return
    }

    Send("{f}")
    MouseMove(WindowX + WindowWidth * (250 / 1366), WindowY + WindowHeight * (290 / 736))
    Sleep(500)
    Click
    Sleep(1000)
    
    loop 5 {
        captureWidth := 50
        captureHeight := 50
        offsetY := 75
        offsetRight := -175  ; shifted more to the right

        centerX := windowX + (windowWidth - captureWidth) // 2 + offsetRight
        centerY := windowY + (windowHeight - captureHeight) // 2 - offsetY

        pBMScreen := Gdip_BitmapFromScreen(centerX "|" centerY "|" captureWidth "|" captureHeight)

        if (Gdip_ImageSearch(pBMScreen, bitmaps["ArrowColor"], &OutputList,,, , , 20, ,5, 1) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove centerX + coords[1] + 15, centerY + coords[2] 
            Sleep 200
            Click
            Sleep(1000)
        }
        MouseMove windowX + windowWidth//4, windowY + windowHeight//4
        Gdip_DisposeImage(pBMScreen)
    }

    captureWidth := 50
    captureHeight := 50
    offsetY := 75
    offsetRight := 340 

    centerX := windowX + (windowWidth - captureWidth) // 2 + offsetRight
    centerY := windowY + (windowHeight - captureHeight) // 2 - offsetY

    pBMScreen := Gdip_BitmapFromScreen(centerX "|" centerY "|" captureWidth "|" captureHeight)

    
    if (value == "Currency"){
        MouseMove(WindowX + WindowWidth * (563 / 1366), WindowY + WindowHeight * (626 / 736))
        Sleep(200)
        Click
        Sleep(200)
        PlayerStatus("Set Team to Currnecy!", "0x22aee6",,false)
    }

    if (value == "HighRoller"){
        if (Gdip_ImageSearch(pBMScreen, bitmaps["ArrowColor"], &OutputList,,, , ,20, , 8) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove centerX + coords[1] , centerY + coords[2] 

            Sleep 200
            Click
            MouseMove windowX + windowWidth//4, windowY + windowHeight//4
            PlayerStatus("Set Team to HighRollers!", "0x22aee6",,false)
        }
    }
    Send("{f}")
    Gdip_DisposeImage(pBMScreen)




}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; GEM GENIE Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


FindElixerQuest(){
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    QuestXCords := [
        WindowX + WindowWidth * (429 / 1366),
        WindowX + WindowWidth * (689 / 1366),
        WindowX + WindowWidth * (937 / 1366),
    ]

    loop {
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["GenieElixer"], &OutputList , , , , , , 35) = 1) {
            parts := StrSplit(OutputList, ",")
            relX := parts[1]
            relY := parts[2]
    
            closestIndex := 0
            smallestDiff := 9999
            for index, coord in QuestXCords {
                diff := Abs(coord - relX)
                if diff < smallestDiff {
                    smallestDiff := diff
                    closestIndex := index
                }
            }

            PlayerStatus("Elixer found!","0xe100ff",,false)
            SelectQuest(closestIndex)
            MouseMove(WindowX + WindowWidth * (1226 / 1366), WindowY + WindowHeight * (99 / 736))
            Click
            
            Gdip_DisposeImage(pBMScreen)
            return
        } else {
            if (CloseAllPpopups()){
                PlayerStatus("Ran out of reroll orbs!","0x5900ff",,false,,false)
                IniWrite(0, settingsFile, "Settings", "RerollGemGenie")
                SelectQuest(2)
                MouseMove(WindowX + WindowWidth * (1226 / 1366), WindowY + WindowHeight * (99 / 736))
                Click
                Gdip_DisposeImage(pBMScreen)
                return
            }
            MouseMove(WindowX + WindowWidth * (687 / 1366), WindowY + WindowHeight * (640 / 736))
            Click
            Sleep(1000)
        }

        Gdip_DisposeImage(pBMScreen)
        Sleep(500)
        
    }
}


SelectQuest(select){
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)


    switch select {
        case 1:
            ; pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth // 3 "|" windowHeight - 30)
            MouseMove(WindowX + WindowWidth * (429 / 1366), WindowY + WindowHeight * (580 / 736))
        case 2:
            ; pBMScreen := Gdip_BitmapFromScreen((windowX + windowWidth // 3) "|" windowY + 30 "|" windowWidth // 3 "|" windowHeight - 30)
            MouseMove(WindowX + WindowWidth * (689 / 1366), WindowY + WindowHeight * (580 / 736))
        case 3:
            ; pBMScreen := Gdip_BitmapFromScreen((windowX + 2 * windowWidth // 3) "|" windowY + 30 "|" windowWidth // 3 "|" windowHeight - 30)
            MouseMove(WindowX + WindowWidth * (937 / 1366), WindowY + WindowHeight * (580 / 736))
    }

    Click
    Sleep(300)
    Click
    Sleep(1000)
    CloseAllPpopups()
    
}


ProccesGenieQuest(){
    CurrentQuest := ""
    GenieQuestList := [
        
        "Common", "Spotted", "Iceshard", "Spikey", 
        "Magma", "Crystal", "Lunar", "Void", "Hell", "Nightmare", 
        "Rainbow", "Showman", "Mining", "Cyber", "Neon",

        "LegendaryPets", "EpicPets", "RarePets", "UniquePets", "CommonPets", 
        "2250 Eggs","1500 Eggs", "Bubbles", "Coins",
    
        "End"
    ]

    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen((windowX + windowWidth // 3) "|" windowY + 30 "|" windowWidth // 3 "|" (windowHeight - 30) // 8) ; Genie Quests.

        for i, v in GenieQuestList {
            if (v = "End"){
                Gdip_DisposeImage(pBMScreen)
                return 1
            }

            if (Gdip_ImageSearch(pBMScreen, bitmaps["GenieQuests"][v], , , , , , 20)) {
                CurrentQuest := v
                Gdip_DisposeImage(pBMScreen)
                break
            }
        }
        
        if (A_Index == 10){
            PlayerStatus("Forgot to equip coin pets hehe imagine loser.", "0x000000")
            IniWrite(0, settingsFile, "Settings", "GemGenie")
            return
        }
        ; Do quests...
        if (CurrentQuest == "LegendaryPets" || CurrentQuest == "EpicPets" || CurrentQuest == "RarePets" || CurrentQuest == "UniquePets" || CurrentQuest == "CommonPets" || CurrentQuest == "1500 Eggs" || CurrentQuest == "2250 Eggs"){
            PlayerStatus("Detected quest: Hatch" CurrentQuest,"0x0066ff",,false,,pBMScreen)
            Infinity()
            waitforcompletion()
        } else if (CurrentQuest == "Bubbles"){
            PlayerStatus("Detected quest: Blow " CurrentQuest,"0x0066ff",,false,,pBMScreen)
            Twilight()
            SmartTeams("Currency")
            Click("Down")
            Sleep(7000)
            Click("Up")
            SmartTeams("HighRoller")
        } else if (CurrentQuest == "Coins"){
            SmartTeams("Currency")
            PlayerStatus("Detected quest: Grind " CurrentQuest,"0x0066ff",,false,,pBMScreen)
            ZenWorld()
            SmartTeams("HighRoller")
        } else {
            PlayerStatus("Detected quest: Hatch the " CurrentQuest " Egg","0x0066ff",,false,,pBMScreen)
            GoToEgg(CurrentQuest)
            waitforcompletion()
        }
    }
}

waitforcompletion(){
    loop 60 {
        Send("e")
        Sleep(500)
    }
    Sleep(6000)
}


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Season Quests
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


ProcessSeasonQuests(){

    CurrentQuest := ""
    QuestList := [
        "Common", "Spotted", "Iceshard", 
        "Spikey", "Magma", "Crystal", 
        "Lunar",  "Void", "Hell",  
        "Nightmare", "Rainbow", "Showman", 
        "Mining", "Cyber", "Neon",

        "Bubbles", "Coins",

        "CommonPets", "UniquePets", "RarePets", "EpicPets", "LegendaryPets", "500 Eggs", "750 Eggs",
        "End",

    ]

    loop {
        MouseMove(WindowX + WindowWidth * (1305 / 1366),WindowY + WindowHeight * (514 / 736))
        Click
        Sleep(800)
        MouseMove(WindowX + WindowWidth * (512 / 1366), WindowY + WindowHeight * (180 / 736))
        Click
        Sleep(500)
        pBMScreen := Gdip_BitmapFromScreen(windowX + (windowWidth // 3) "|" windowY + (windowHeight // 3) "|" windowWidth // 3 "|" windowHeight // 2) ; Season Quests
        for i, v in QuestList {
            if (v = "End"){
                Gdip_DisposeImage(pBMScreen)
                return 1
            }

            if (Gdip_ImageSearch(pBMScreen, bitmaps["SeasonQuests"][v], , , , , , 15)) {
                CurrentQuest := v
                Gdip_DisposeImage(pBMScreen)
                break
            }
        }

        if (CurrentQuest == "LegendaryPets" || CurrentQuest == "EpicPets" || CurrentQuest == "RarePets" || CurrentQuest == "UniquePets" || CurrentQuest == "CommonPets" || CurrentQuest == "500 Eggs" || CurrentQuest == "750 Eggs"){
            PlayerStatus("Detected quest: Hatch " CurrentQuest,"0x0066ff",,false)
            Infinity()
            waitforcompletion()
        } else if (CurrentQuest == "Bubbles"){
            PlayerStatus("Detected quest: Blow " CurrentQuest,"0x0066ff",,false)
            Twilight()
            SmartTeams("Currency")
            Click("Down")
            Sleep(7000)
            Click("Up")
            SmartTeams("HighRoller")
        } else if (CurrentQuest == "Coins"){
            PlayerStatus("Detected quest: Grind " CurrentQuest,"0x0066ff",,false)
            SmartTeams("Currency")
            ZenWorld()
            SmartTeams("HighRoller")
        } else {
            PlayerStatus("Detected quest: Hatch the " CurrentQuest " Egg","0x0066ff",,false)
            GoToEgg(CurrentQuest)
            waitforcompletion()
        }
        
        Gdip_DisposeImage(pBMScreen)
    }
}



StartBlowingBubbles(){
    if (RewardChecked("BlowBubbles")){
        Click("Down")
    }
}

StopBlowingBubbles(){
    if (RewardChecked("BlowBubbles")){
        Click("Up")
    }
}



GoToEgg(Egg) {
    switch Egg {
        case "RealInfinity":
            Infinity() 
        case "Infinity":
            Infinity() 
        case "Common":
            Common()
        case "Spotted":
            Spotted()
        case "Iceshard":
            Iceshard()
        case "Spikey":
            Spikey()
        case "Magma":
            Magma()
        case "Crystal":
            Crystal()
        case "Lunar":
            Lunar()
        case "Void":
            Void()
        case "Hell":
            Hell()
        case "Nightmare":
            Nightmare()
        case "Rainbow":
            Rainbow()
        case "Showman":
            Showman()
        case "Mining":
            Mining()
        case "Cyber":
            Cyber()
        case "Neon":
            Neon()
        case "Chance":
            GamerEgg() 
        case "Event":
            EventEgg() 
        case "Voidcrystal":
            Voidcrystal()
    }
}





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; HyperDarts Game Functions.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


HyperDartPath(){
    Teleport(10)
    Sleep(1000)
    movement := 
    (
        '
        nm_walk(1300,Wkey,Akey)
        
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}

BackIntoGame(){
    movement := 
    (
        '
        nm_walk(600,Wkey)      
        Sleep(1000)  
        nm_walk(600,Skey)        
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}


Insane(){
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    MouseMove windowX + windowWidth//4, windowY + windowHeight//4
    loop 10 {
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["SuperTicket"], &OutputList , , , , , 35) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            Sleep(1000)
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Insane"], &OutputList , , , , , 20) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Sell"], &OutputList, , , , , , 35) = 1) {
            if (Gdip_ImageSearch(pBMScreen, bitmaps["X"], &OutputList, , , , , , 35) = 1) {
                PlayerStatus("Bag full detected!","0xff0062",,false,,false)
                coords := StrSplit(OutputList, ",")
                MouseMove coords[1] + 30, coords[2]+60
                Sleep 200
                Click
            }
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(500)
    }
    PlayerStatus("Did not detect HyperDart Gui", "0xb700ff",,false)
    CloseAllPpopups()
    CameraCorrection()
    Gdip_DisposeImage(pBMScreen)
    return 0


}


Dartloop(){
    Sleep(1000)
    loop 300 {
        Click("Down")
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Dart"], &OutputList , , , , , 20) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Bomb"], &OutputList , , , , , 20) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Spike"], &OutputList , , , , , 20) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["ClaimRewards"], &OutputList , , , , , 20) = 1) {
            PlayerStatus("Claimed Hyperdarts reward.","0xd400ff",,false)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Click
            Sleep(500)
            MouseMove(300,300)
            Gdip_DisposeImage(pBMScreen)
            break 
        }

        if (Gdip_ImageSearch(pBMScreen, bitmaps["Sell"], &OutputList, , , , , , 35) = 1) {
            if (Gdip_ImageSearch(pBMScreen, bitmaps["X"], &OutputList, , , , , , 35) = 1) {
                PlayerStatus("Bag full detected!","0xff0062",,false,,false)
                coords := StrSplit(OutputList, ",")
                MouseMove coords[1] + 30, coords[2]+60
                Sleep 200
                Click
            }
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["SuperTicket"], , , , , , 35) = 1) {
            Gdip_DisposeImage(pBMScreen)
            break
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Insane"], , , , , , 20) = 1) {
            Gdip_DisposeImage(pBMScreen)
            break
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(500)
        Click("Up")
    }
    Click("Up")
    BackIntoGame()
    Sleep(2000)
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Board Game Functions.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


EnterBoardGame(){
    Teleport(6)
    Sleep(2000)
    movement :=
    (
        "
        nm_walk(2000,Wkey)
        nm_walk(650,Akey)
        nm_walk(1600,Wkey)
        nm_walk(800,Wkey,Akey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    Sleep(500)
    MouseMove(WindowX + WindowWidth * (672 / 1366),WindowY + WindowHeight * (144 / 736))
    Sleep(300)
    Click
    Click
    Click
    Sleep(300)
    ; go to egg
    GoToEgg("Chance")
    ; Finshed going to egg
    MouseMove(WindowX + WindowWidth * (683 / 1366),WindowY + WindowHeight * (309 / 736))
    Sleep(300)
    Click
    Click
    Sleep(500)

}


CheckInfinity(){
    if (SearchElixer2()) {
        ChangeDice()
        Sleep(1000)
        Dice()
    } else {
        return
    }
    loop 3 {
        if (SearchElixer()){
            ChangeDice()
            MouseMove(WindowX + WindowWidth * 0.5,WindowY + WindowHeight * 0.5)
            GoldenDice()
            loop 3 {
                if (SearchElixer2()){
                    PlayerStatus("Claimed Infinity Elixer!", "0x0016e0", , false)
                    UseDice()
                    Sleep(1000)
                    ChangeDice()
                    GaintDice()
                    return
                }

                if (A_Index == 3){
                    ChangeDice()
                    GaintDice()
                }

                UseDice()
            }
        }

        if !(SearchElixer2()){
            ChangeDice()
            GaintDice()
            return
        }
        UseDice()

    }
}

;
; Function: SearchElixer
; Loops 10 times (~3 seconds total with 250ms intervals) to image-search for the Infinity Elixer.
; Returns true if found, false otherwise.
;
SearchElixer() {
    loop 4 {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)

        ; grab the top-left section where the Elixer appears
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY+30 "|" 600 "|" 100)
        ; search for the Elixer bitmap
        if ( Gdip_ImageSearch(pBMScreen, bitmaps["Elixer"], , , , , , 35) = 1 ) {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
        ; clean up and wait before next scan
        Gdip_DisposeImage(pBMScreen)
        Sleep 200
    }

    return 0
}


SearchElixer2() {
    loop 4 {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)

        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY+30 "|" windowWidth "|" 100)
        if ( Gdip_ImageSearch(pBMScreen, bitmaps["Elixer"], , , , , , 35) = 1 ) {
            Gdip_DisposeImage(pBMScreen)
            return 1
        }
        ; clean up and wait before next scan
        Gdip_DisposeImage(pBMScreen)
        Sleep 200
    }

    return 0
}


GoldenDice(){
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["GoldenDice"], &OutputList , , , , , 20) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            Gdip_DisposeImage(pBMScreen)
            break
        }
        if (A_Index == 4 * 10){
            Gdip_DisposeImage(pBMScreen)
            return
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(250)
    }
}

GaintDice(){
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["GaintDice"], &OutputList, , , , , 20) = 1) {
            Gdip_DisposeImage(pBMScreen)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            break
        }
        if (A_Index == 4 * 10){
            Gdip_DisposeImage(pBMScreen)
            return
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(250)

    }
}

Dice(){
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Dice"], &OutputList, , , , , 20) = 1) {
            Gdip_DisposeImage(pBMScreen)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            break
        }
        if (A_Index == 4 * 10){
            Gdip_DisposeImage(pBMScreen)
            return
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(250)
    }
}


ChangeDice(){
    ; Goes to dice selection screen
    MouseMove(WindowX + WindowWidth * (400 / 1366),WindowY + WindowHeight * (400 / 736))
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["DiceBag"], &OutputList, , , , , 20) = 1) {
            Gdip_DisposeImage(pBMScreen)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep(300)
            Click
            break
        }
        if (A_Index == 4 * 10){
            Gdip_DisposeImage(pBMScreen)
            return
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(250)
    }

}


UseDice(){
    MouseMove(WindowX + WindowWidth * (400 / 1366),WindowY + WindowHeight * (400 / 736))
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["RedDice"],&OutputList,,,,,, 35) = 1) {
            Gdip_DisposeImage(pBMScreen)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            loop 5 {
                Sleep(200)
                Click
                Click
                Click
            }
            break
        }
        if (A_Index == 4 * 10){
            ChangeDice()
            GaintDice()
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(250)

    }
    ; We clicked dice now we are searching for it to appear again
    
    MouseMove(WindowX + WindowWidth * (400 / 1366),WindowY + WindowHeight * (400 / 736))
    loop {
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
        if (Gdip_ImageSearch(pBMScreen, bitmaps["RedDice"],,,,,, 35) = 1) {
            Gdip_DisposeImage(pBMScreen)
            break
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Skip"],&OutputList,,, , , 10) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep 200
            Click
        }
        if (Gdip_ImageSearch(pBMScreen, bitmaps["Skip2"],&OutputList,,, , , 10) = 1) {
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1], coords[2]+60
            Sleep 200
            Click
        }
        if (A_Index == 20){
            ChangeDice()
            GaintDice()
            Gdip_DisposeImage(pBMScreen)
            return
        }
        Gdip_DisposeImage(pBMScreen)
        Sleep(500)
    }
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Macro Functions.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Disconnect(){
    loop {
        if !(CheckDisconnnect()){
            return 0
        } else {
            return 1
        }
        if (A_Index == 3) {
            IniWrite("", settingsFile, "Settings", "url")
            PlayerStatus("Changing to public server....", "0x5745ff")
            return 1
        }
    }
}

MainLoop() {
    MyWindow.Destroy()

    if (GetRobloxHWND()){
        ResizeRoblox()
        CameraCorrection()
    }
    
    if (Disconnect()){
        return
    }




    if (MacroSetting("CoinCurrency") || MacroSetting("TicketCurrency")){
        loop {
            ActivateRoblox()
            if (Disconnect()){
                return
            }

            if (MacroSetting("CoinCurrency")){
                ZenWorld()
                PlayerStatus("Current coin/gems","0x00e1ff",,false,)
            } else if (MacroSetting("TicketCurrency")){
                HyperWaveWorld()
                PlayerStatus("Current Tickets","0x00e1ff",,false,)
            }

            RewardInterupt() ; should end off the M screen
        }
    }

    if (MacroSetting("Twilight") || MacroSetting("RobotFactory")){
        if (MacroSetting("Twilight")){
            Twilight()
        } else if (MacroSetting("RobotFactory")){
            RobotFactory()
        }

        loop {
            Click("Down")
            Sleep(10000)
            Click("Up")
            if (Disconnect()){
                return
            }
            if (RewardInterupt() == 1){

                if (MacroSetting("Twilight")){
                    Twilight()
                } else if (MacroSetting("RobotFactory")){
                    RobotFactory()
                }

            }
        }

    }



    if (MacroSetting("HyperDart")){
        if (Disconnect()){
            return
        }
        ActivateRoblox()
        ResizeRoblox()
        HyperDartPath()
        loop {
            if (Insane() == 0){
                HyperDartPath()
                Insane()
            }
            Dartloop()
            if (RewardInterupt() == 1){
                HyperDartPath()
            }

            if (Disconnect()){
                return
            }
        }
    }


    ; Egg Loops
    ; Any other egg loops does this
    HatchCounter := 0
    ActivateRoblox()
    GoToEgg(Macro)

    PlayerStatus("Egg Status!", "0xe07f00",,false)
    SmartTeams("HighRoller")
    Send("e")
    loop {
        Send("e")
        HatchCounter += 1

        if (Mod(HatchCounter, 10) == 0){
            if (EggBubbleDetect() && EggBubbleDetect()){
                PlayerStatus("Egg Hatching bugged, thanks rumble!", "0xe07f00",,false)
                DetectBubble()
                GoToEgg(Macro)
            }

            NoCurrency()

            if (RewardInterupt() == 1){
                GoToEgg(Macro)
                CloseAllPpopups()
                if !(CheckEgg()){
                    CameraCorrection()
                    GoToEgg(Macro)
                }
            }

            if (Disconnect()){
                return
            }

        }
        if (HatchCounter == 100 * 6){ ; 1 minute = 200
            send "{" SlashKey "}"
            Sleep(100)
            loop 10 {
                send "{" EnterKey "}"
                Sleep(50)
            }
            if (MacroSetting("RealInfinity")){
                SwitchEgg()
                PlayerStatus("Switching Infinity Egg!", "0x4300e0",,false)
            }
            PlayerStatus("Egg Status!", "0xe07f00",,false)
            HatchCounter := 0
        } 
        Sleep(300)
    }


}


NoCurrency(){
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)

    if (Gdip_ImageSearch(pBMScreen, bitmaps["UhOh"], , , , , , 15)) {    
        CloseAllPpopups()
        SmartTeams("Currency")
        OpenMysteryBoxes(100)
    }
    Gdip_DisposeImage(pBMScreen)
}


PauseToggle := true

F3::
{


    ActivateRoblox()
    ResizeRoblox()
    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    ; PauseMacro()

}
