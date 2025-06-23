ExitEgg(){
    movement := 
    (
        '
        nm_walk(1000,Akey)
        DetectBubble()
        nm_walk(1000,Dkey)
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
}


; Worlds Pathings


HyperWaveWorld(){
    Teleport(10)
    StartBlowingBubbles()
    movement := 
    (
        '
        Loop 15 {
            nm_walk(500,Skey)
            nm_walk(500,Akey)
            nm_walk(1000,Wkey)
            nm_walk(500,Dkey)
            nm_walk(500,Skey)
        }
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()

}

RobotFactory(){
    Teleport(9)
    StartBlowingBubbles()
    movement := 
    (
        '
        nm_walk(500,Akey)
        nm_walk(1100,Wkey)
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}
Twilight(){
    Teleport(3)
    StartBlowingBubbles()
    movement := 
    (
        '
        nm_walk(200,Skey)
        nm_walk(900,Akey)
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()

}

ZenWorld(){
    Teleport(5)
    StartBlowingBubbles()
    movement := 
    (
        '
        nm_walk(700,Skey)
        sleep 200
        nm_walk(300,Dkey)
        sleep 200
        nm_walk(500,Wkey)
        sleep 200
        nm_walk(300,Akey)
        sleep 200
        nm_walk(200,Wkey)
        sleep 200
        nm_walk(400,Dkey)
        sleep 200
        nm_walk(400,Akey)
        nm_Walk(2300, Wkey)
        loop 4 {
            nm_Walk(250, Dkey)
            nm_Walk(250, Wkey)          
        }    

        nm_Walk(500, Dkey)          
        nm_Walk(500, Skey)          
        sleep 200
        nm_Walk(500, Akey)
        sleep 200
        nm_Walk(650, Wkey)
        nm_Walk(700, Dkey)
        nm_Walk(1100, Akey)
        nm_Walk(500 + 600, Skey)
        nm_Walk(600,Wkey)
        nm_walk(500,Akey)
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
    Teleport(5)
    StartBlowingBubbles()
    movement := 
    (
        '
        nm_walk(400,Dkey)
        nm_walk(400,Akey)

        nm_walk(400,Skey)
        nm_walk(400,Dkey)
        nm_walk(400,Akey)
        nm_walk(400,Akey)
        nm_walk(400,Dkey)
        
        nm_walk(500,Dkey,Skey)
        
        loop 3 {
            nm_walk(250,Skey)
            nm_walk(250,Dkey)
            }
        nm_walk(300,Wkey)
        nm_walk(700,Dkey)
        nm_walk(400,Wkey)
        nm_walk(600,Akey)

        nm_walk(500,Wkey,Akey)
        nm_walk(300,Akey)
        nm_walk(300,Skey)

        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()

}

; Egg pathings

UnderWorldEgg(){
    Teleport(8)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(1000,Akey)
        nm_walk(3000,Wkey)
        nm_walk(1500,Akey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    Sleep(5000)
    StopBlowingBubbles()
}



Infinity(){
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(100,Dkey)
        nm_walk(3500,Wkey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}



SwitchEgg(){
    movement := 
    (
        '
        nm_walk(1000,Skey)
        Sleep(5000)
        nm_walk(1000,Wkey)
            
        '
    )   
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    MouseMove(WindowX + WindowWidth * (840 / 1366),WindowY + WindowHeight * (180 / 736))
    Click
    Sleep(1000)
}



; Competive event


Common() {
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(200,Wkey)
        nm_walk(2000,Dkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Spotted() {
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(200,Wkey)
        nm_walk(1600,Dkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Iceshard() {
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(200,Wkey)
        nm_walk(1200,Dkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Spikey() {
    Teleport(1)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(400,Skey,Akey)
        
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Magma() {
    Teleport(2)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1400,Wkey)
        nm_walk(400,Akey)
        nm_walk(400,Wkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Crystal() {
    Teleport(2)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1400,Wkey)
        nm_walk(800,Akey)
        nm_walk(400,Wkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Lunar() {
    Teleport(3)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(500,Skey)
        nm_walk(200,Dkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Void() {
    Teleport(4)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(500,Akey)
        nm_walk(300,Wkey)
        nm_walk(500,Akey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Hell() {
    Teleport(4)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(500,Akey)
        nm_walk(700,Wkey)
        nm_walk(500,Akey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Nightmare() {
    Teleport(4)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(500,Akey)
        nm_walk(1100,Wkey)
        nm_walk(500,Akey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Rainbow() {
    Teleport(5)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(2300,Wkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Showman() {
    Teleport(6)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1300,Wkey)
        nm_walk(1100,Akey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Mining() {
    Teleport(6)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1300,Wkey)
        nm_walk(1100,Akey)
        nm_walk(400,Akey,Wkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Cyber() {
    Teleport(6)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1300,Wkey)
        nm_walk(1100,Akey)
        nm_walk(600,Akey,Wkey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Neon() {
    Teleport(10)
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1000,Akey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

GamerEgg(){
    Teleport(6)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(2000,Wkey)
        nm_walk(650,Akey)
        nm_walk(2000,Wkey)
        nm_walk(650,Dkey)
        nm_walk(700,Wkey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

EventEgg(){
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(500,Akey,Skey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

Voidcrystal(){
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(400,Akey)
        nm_walk(4000,Skey)
        DetectBubble()
        nm_walk(1700,Skey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

; Shop Pathing

AlienShopPathing(){
    Teleport(5)
    StartBlowingBubbles()
    movement := 
    (
    '
    nm_Walk(2100, Wkey)
    nm_Walk(200, Dkey)
    nm_Walk(300, Wkey)
    nm_Walk(200, Dkey)
    nm_Walk(300, Wkey)
    nm_Walk(900, Dkey)
    nm_Walk(300, Wkey)
    nm_walk(2700, Dkey)
    nm_walk(700, Skey)
        
    '
    )


    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

BlackMarketPathing(){
    Teleport(4)
    StartBlowingBubbles()
    movement := 
    (
    '
    nm_Walk(500, Akey)
    nm_Walk(1400, Skey)
        
    '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}



DiceMerchantPathing(){
    Teleport(6) 
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(2100,Wkey)
        nm_walk(1200,Akey)
        nm_walk(700,Wkey)
        nm_walk(400,Akey)
        
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

TravelingMerchantPathing(){
    Teleport(0)    
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(400,Akey)
        nm_walk(3500,Skey)
        nm_walk(400,Dkey)
        nm_walk(600,Skey)
        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}


AncientSpinnerPathing(){
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(400,Akey)
        nm_walk(4000,Skey)
        DetectBubble()
        nm_walk(7000,Dkey)
        DetectBubble()
        nm_walk(3450,Akey)
        nm_walk(700,Wkey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

AncientChestPathing(){
    Teleport(0)
    StartBlowingBubbles()
    movement :=
    (
        "
        nm_walk(400,Akey)
        nm_walk(4000,Skey)
        DetectBubble()
        nm_walk(7000,Dkey)
        DetectBubble()
        nm_walk(6000,Akey)
        "
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}

GemGeniePathing(){
    Teleport(5)    
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1000,Wkey)
        nm_walk(1300,Dkey)

        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}


BubbleShrinePathing(){
    Teleport(5)    
    StartBlowingBubbles()
    movement :=
    (
        '
        nm_walk(1000,Wkey)
        nm_walk(1300,Akey)

        '
    )
    nm_createWalk(movement)
    KeyWait "F14", "D T5 L"
    KeyWait "F14", "T120 L"
    nm_endWalk()
    StopBlowingBubbles()
}