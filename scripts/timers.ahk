nowUnix() {
    return DateDiff(A_NowUTC, "19700101000000", "Seconds")
}

LastAlienShop := nowUnix()
LastGiantChest := nowUnix()
LastTicketChest := nowUnix()
LastVoidChest := nowUnix()
LastInfinityChest := nowUnix()
LastGemGenie := nowUnix()
LastSeasonQuests := nowUnix()
LastDiceMerchant := nowUnix()
LastPresents := nowUnix()
LastBlackMarket := nowUnix()
LastTravelingMerchant := nowUnix()


ShopCooldown := 0.75
ChestCooldown := 1

if (A_WDay == 3){
    ChestCooldown := 0.85 ; Chest reseting 15% faster
    if (RewardChecked("Premiumperk")){
        ChestCooldown := 0.75  ; Chest reseting 25% faster
    }
}

; 1 = 1s

GiantChest := 900 * ChestCooldown                       ; 15 Minutes
TicketChest := 1800 * ChestCooldown                     ; 30 Minutes
InfinityChest := 2040 * ChestCooldown                   ; 34 Minutes
VoidChest := 2400 * ChestCooldown                       ; 40 Minutes

AlienShop := 1200 * ShopCooldown                ; 20 Minutes
BlackMarket := 21600 * ShopCooldown             ; 6 Hours
DiceMerchant := 7200 * ShopCooldown             ; 2 Hours
TravelingMerchant := 28800 * ShopCooldown       ; 8 Hours


GemGenie := 3620                        ; 1 Hour
SeasonQuests := 3620                    ; 1 Hour

Presents := 5400                        ; 1H 30 Minutes



RewardChecker() {
    global LastVoidChest, LastGiantChest, LastDiceMerchant, LastPresents, LastAlienShop, LastTicketChest, LastBlackMarket, LastGemGenie, LastInfinityChest, LastSeasonQuests, LastTravelingMerchant
    global VoidChest, GiantChest, DiceMerchant, Presents, AlienShop, TicketChest, BlackMarket, GemGenie, TravelingMerchant, InfinityChest, SeasonQuests, TravelingMerchant

    Rewardlist := []

    currentTime := nowUnix()
    if (currentTime - LastAlienShop >= AlienShop && RewardChecked("AlienShop")) {
        Rewardlist.Push("AlienShop")
    }
    if (currentTime - LastGiantChest >= GiantChest && RewardChecked("GiantChest")) {
        Rewardlist.Push("GiantChest")
    }
    if (currentTime - LastTicketChest >= TicketChest && RewardChecked("TicketChest")) {
        Rewardlist.Push("TicketChest")
    }
    if (currentTime - LastVoidChest >= VoidChest && RewardChecked("VoidChest")) {
        Rewardlist.Push("VoidChest")
    }
    if (currentTime - LastInfinityChest >= InfinityChest && RewardChecked("InfinityChest")) {
        Rewardlist.Push("InfinityChest")
    }
    if (currentTime - LastSeasonQuests >= SeasonQuests && RewardChecked("SeasonQuests")) {
        Rewardlist.Push("SeasonQuests")
    }
    if (currentTime - LastGemGenie >= GemGenie && (RewardChecked("GemGenie") || RewardChecked("GemGenieReroll"))) {
        Rewardlist.Push("GemGenie")
    }
    if (currentTime - LastDiceMerchant >= DiceMerchant && RewardChecked("DiceMerchant")) {
        Rewardlist.Push("DiceMerchant")
    }
    if (currentTime - LastPresents >= Presents && RewardChecked("Presents")) {
        Rewardlist.Push("Presents")
    }
    if (currentTime - LastBlackMarket >= BlackMarket && RewardChecked("BlackMarket")) {
        Rewardlist.Push("BlackMarket")
    }

    if (currentTime - LastTravelingMerchant >= TravelingMerchant && RewardChecked("TravelingMerchant") && (A_WDay = 1 || A_WDay = 7)) {
        Rewardlist.Push("TravelingMerchant")
    }
    return Rewardlist
}

RewardChecked(value) {
    if (IniRead("settings.ini", "Settings", value) == 1) {
        return true
    }
    return false
}

; Calls RewardChecker -> RewardChecked functions to see if we are able to run those things
RewardInterupt() {
    global LastVoidChest, LastGiantChest, LastDiceMerchant, LastPresents, LastAlienShop, LastTicketChest, LastBlackMarket, LastGemGenie, LastSeasonQuests, LastInfinityChest, LastTravelingMerchant

    variable := RewardChecker()
    if !(Macro == "Twilight" || Macro == "RobotFactory" || Macro == "CoinCurrency" || Macro == "TicketCurrency" || Macro == "HyperDart"){
        if (variable.Length > 0){
            DetectBubble()
        }
    } else {
        if (variable.Length > 0){
            send "{" EscKey "}"
            Sleep(300)
            send "{" Rkey "}"
            Sleep(300)
            send "{" EnterKey "}"
            Sleep(300)
            send "{" EnterKey "}"
            Sleep(300)
            send "{" EnterKey "}"
            CameraCorrection()
        }
    }

    for (k, v in variable) {
        if (v = "Presents") {
            MouseMove(WindowX + WindowWidth * (43 / 1366), WindowY + WindowHeight * (300 / 736))
            Sleep(300)
            Click
            Sleep(1000)
            MouseMove(WindowX + WindowWidth * (500 / 1366), WindowY + WindowHeight * (170 / 736))
            Sleep(300)
            Click
            Click
            Sleep(1000)
            PlayerStatus("Finished collecting all Playtime Rewards!", "0x57F287", , false)
            Sleep(1000)
            LastPresents := nowUnix()
        }
        if (v = "GiantChest") {
            PlayerStatus("Going to Giant Chest!", "0x57F287", , false,,false)

            ClaimChests(1)
            PlayerStatus("Finished collecting Giant Chest!", "0x57F287", , false)
            Send("{m}")
            LastGiantChest := nowUnix()
        }
        if (v == "VoidChest") {
            PlayerStatus("Going to Void Chest!", "0x57F287", , false,,false)

            ClaimChests(4)
            PlayerStatus("Finished collecting Void Chest!", "0x57F287", , false)
            Send("{m}")
            LastVoidChest := nowUnix()
        }
        if (v == "InfinityChest"){
            PlayerStatus("Going to Infinity Chest!","0x57F287", , false,,false)

            ClaimChests(0)
            PlayerStatus("Finished collecting Infinity Chest!", "0x57F287", , false)
            Send("{m}") 
            LastInfinityChest := nowUnix()
        }
        if (v = "TicketChest") {
            PlayerStatus("Going to Ticket Chest!", "0x57F287", , false,,false)

            ClaimChests(7)
            PlayerStatus("Finished collecting TicketChest!", "0x57F287", , false)
            Send("{m}")
            LastTicketChest := nowUnix()
        }
        if (v = "AlienShop") {
            PlayerStatus("Going to Alien Shop!", "0x57F287", , false,,false)

            AlienShopPathing()
            BuyShop()
            PlayerStatus("Bought Items from the Alien Shop!", "0x57F287", , false)    
            RerollShop("AlienShop")    
            LastAlienShop := nowUnix()
        }
        if (v = "BlackMarket") {
            PlayerStatus("Going to Black Market!", "0x57F287", , false,,false)

            BlackMarketPathing()
            BuyShop()
            PlayerStatus("Bought Items from the Black Market!", "0x57F287", , false)           
            RerollShop("BlackMarket")    
            LastBlackMarket := nowUnix()
        }
        if (v = "DiceMerchant") {
            PlayerStatus("Going to Dice Merchant!", "0x57F287", , false,,false)

            DiceMerchantPathing()
            BuyShop()
            PlayerStatus("Finished collecting Dice Merchant!", "0x57F287", , false)
            RerollShop("DiceMerchant")    
            LastDiceMerchant := nowUnix()
        }

        ; going to convert into traveling merchant 

        
        if (v = "TravelingMerchant"){
            PlayerStatus("Going to Traveling Merchant!", "0x57F287", , false,,false)
            TravelingMerchantPathing()
            BuyShop()
            PlayerStatus("Finished collecting Traveling Merchant!", "0x57F287", , false)
            RerollShop("TravelingMerchant")   
            LastTravelingMerchant := nowUnix()
        }

        if (v = "GemGenie"){
            PlayerStatus("Going to Gem Genie!", "0x57F287", , false,,false)
            GemGeniePathing()
            Sleep(2000)
            if (RewardChecked("RerollGemGenie")){
                FindElixerQuest()
            } else {
                SelectQuest(2)
            }
            PlayerStatus("Selected this quest.","0x6757f2",,false)
            LastGemGenie := nowUnix() 
            Teleport(0)
            ProccesGenieQuest()
            PlayerStatus("Finished Gem Genie!", "0x57F287", , false)
        }
        if (v = "SeasonQuests"){
            PlayerStatus("Going to Season Quests!", "0x57F287", , false)
            ProcessSeasonQuests()
            PlayerStatus("Finished Season Challenges!", "0x57F287", , false)
            MouseMove(WindowX + WindowWidth * (853 / 1366),WindowY + WindowHeight * (169 / 736))
            Sleep(300)
            Click
            LastSeasonQuests := nowUnix()
        }

    } ; end of for loop braket

    if !(Macro == "Twilight" || Macro == "RobotFactory" || Macro == "CoinCurrency" || Macro == "TicketCurrency" || Macro == "HyperDart"){
        MovingAreas := ["GiantChest" ,"VoidChest" ,"InfinityChest" , "TicketChest"]
        for area in MovingAreas {
            for _, v in variable {
                if (v = area) {
                    if !(CheckEgg()){
                        GoToEgg(Macro)
                    }
                    return 0
                }
            }
        }
    }


    if (variable.Length > 0)
        return 1
}






ClaimChests(amount){
    Sleep(2000)
    Send "{m}"
    loop {
        ActivateRoblox()
        hwnd := GetRobloxHWND()
        GetRobloxClientPos(hwnd)
        MouseMove windowX + windowWidth // 4, windowY + windowHeight // 4
        pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)

        if (Gdip_ImageSearch(pBMScreen, bitmaps["Teleport"],,,, , , 20) = 1) {
            Gdip_DisposeImage(pBMScreen)
            ; scroll to bottom
            Loop 10 {
                Send("{WheelDown}")
                Sleep 50
            }
            ; Go to world!
            MouseMove(WindowX + WindowWidth * (958 / 1366),WindowY + WindowHeight * (170 / 736))
            loop amount {
                Click
                Sleep(100)
            }
            Sleep(2000)

            ClaimpBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
            if (Gdip_ImageSearch(ClaimpBMScreen, bitmaps["Claim"], &OutputList,,, , , , 35, 2) = 1) {
                coords := StrSplit(OutputList, ",")
                MouseMove coords[1], coords[2] + 60    ; Adjust for better click accuracy
                Sleep(200)
                Click
                Click
                Sleep(1500)
                Gdip_DisposeImage(ClaimpBMScreen)
                break
            }
            Gdip_DisposeImage(ClaimpBMScreen)
        }

        if (A_index == 15){
            Gdip_DisposeImage(pBMScreen)
            CheckDisconnnect()
            PlayerStatus("WARNING!! MACRO NO WORK!!! ⚠️⚠️⚠️","0xe3e622",,true)
            return 0
        }

        Gdip_DisposeImage(pBMScreen)
        Sleep(500)
    }
}

BuyShop(){
    Sleep(2000)
    coords := [
        [WindowX + WindowWidth * (547 / 1366), WindowY + WindowHeight * (480 / 736)],
        [WindowX + WindowWidth * (684 / 1366), WindowY + WindowHeight * (480 / 736)],
        [WindowX + WindowWidth * (815 / 1366), WindowY + WindowHeight * (480 / 736)]
    ]
    for _, coord in coords {
        MouseMove coord[1], coord[2]
        Sleep(300)
        Click
        Sleep(50)
        Click
        Sleep(1000)
    }
}


RerollShop(value){
    Reroll := IniRead(settingsFile, "Settings", "Reroll")
    if !(Reroll == value){
        return
    }

    hwnd := GetRobloxHWND()
    GetRobloxClientPos(hwnd)
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["Reroll"], &OutputList,,, , , 35, 2) = 1) {
        Gdip_DisposeImage(pBMScreen)
        loop 3 {
            if (value == "TravelingMerchant"){
                RecoupGems()
            }
            PlayerStatus("Rerolling Shop!", "0x57F287", , false)
            coords := StrSplit(OutputList, ",")
            MouseMove coords[1] , coords[2] + 60    ; Adjust for better click accuracy
            Sleep(200)
            Click
            BuyShop()
        }
    }
}



RecoupGems(){
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)

    if !(Gdip_ImageSearch(pBMScreen, bitmaps["UhOh"], , , , , , 15)) {    
        CloseAllPpopups()
        Gdip_DisposeImage(pBMScreen)
        return
    }
    Gdip_DisposeImage(pBMScreen)

    OpenMysteryBoxes(25)

    TravelingMerchantPathing()
    MouseMove(WindowX + WindowWidth * (684 / 1366), WindowY + WindowHeight * (534 / 736))
    Click
    Sleep(2000)
    MouseMove windowX + windowWidth // 4, windowY + windowHeight // 4
}



OpenMysteryBoxes(amount){
    Send("{f}")
    MouseMove(WindowX + WindowWidth * (256 / 1366), WindowY + WindowHeight * (378 / 736))
    Sleep(500)
    Click
    MouseMove(WindowX + WindowWidth * (725 / 1366), WindowY + WindowHeight * (358 / 736))
    Sleep(500)
    Loop 6 {
        Send("{WheelDown}")
        Sleep 50
    }
    Sleep(500)
    pBMScreen := Gdip_BitmapFromScreen(windowX "|" windowY + 30 "|" windowWidth "|" windowHeight - 30)
    if (Gdip_ImageSearch(pBMScreen, bitmaps["MysteryBox"], &OutputList,,, , , 100) = 1) {
        coords := StrSplit(OutputList, ",")
        MouseMove coords[1] , coords[2] + 60    ; Adjust for better click accuracy
        Sleep(400)
        Click
        Click
    }
    Gdip_DisposeImage(pBMScreen)


    loop amount {
        MouseMove(windowX + windowWidth * 0.2927, windowY + windowHeight * 0.75)
        Click
        Sleep(250) ; (562, 782)
        MouseMove(windowX + windowWidth * 0.2927, windowY + windowHeight * 0.78)
        Click
        Sleep(250) ; (562, 782)
        MouseMove(windowX + windowWidth * 0.6156, windowY + windowHeight * 0.5648), 
        Click 
        Sleep(250) ; (1182, 610)
        Loop 20 {
            MouseMove(windowX + windowWidth * 0.6156, windowY + windowHeight * 0.5648), 
            Click 
            Sleep(20)
        }
        Sleep(50)
        Send("{f}")
    }
    CloseRoblox()
    CheckDisconnnect()
    ; The reason we do this is because the popups from the items from mystery boxes get in the way

}