*-----------------------------------------------------------
* Title      :  Nano Invaders
* Written by : Jamal El Chaar & Abdulrahman Makkawi
* START Date : 31/5/2025
* END Date   : 8/7/2025
* Description: -Discover it when u play it ~Makkawiiiiii
*              -Stopped for 1 month bcz of Finals
* Sessions   : 7 sessions
*-----------------------------------------------------------
    


WELCOME
   DC.B 'Welcome to Nano Invaders ',0
Press
   DC.B '"Press Enter to continue"',0
   
OVER
   DC.B 'Game Over dude ',0
PressR
   DC.B '"Press Enter to Play again"',0
   
WON
   DC.B 'Good Game, You Won!!! ',0
PressW
   DC.B '"Press Enter to Play again"',0   

LIM DC.L $127
STEP DC.L $00

DEATHSound  DC.B   'DEATH.wav',0
LAZERSound  DC.B   'LAZER.wav',0
HEALSound  DC.B   'HEAL.wav',0
StartSound DC.B   'Start.wav',0
GameOverSound DC.B 'GameOver.wav',0
WinSound DC.B 'Win.wav',0

PIX_TEST_ONE DC.L $00
PIX_TEST_TWO DC.L $00
PIX_TEST_THREE DC.L $00
PIX_TEST_FOUR DC.L $00
PIX_TEST_FIVE DC.L $00


LIM_ENEMY_R DC.L $00
LIM_ENEMY_L DC.L $2A7
STEP_ENEMY_R DC.L $00
STEP_ENEMY_L DC.L $00

WIN DC.L $00

    ORG	$1000      	; Start of program
START
    ;JSR SET_SCREEN_SIZE
    JSR CLEAR_SCREEN
    JSR INITIALIZE
        
    JSR Print_Welcome
    JSR PressEnter  *PRESS Enter TO CLEAR THE SCREEN, TO SHOW A NEW SCREEN FOR THE GAME
    
    JSR DRAW_CHAR
 
    JSR Draw_Enemy
    
CONTROL    
    
    
    
    JSR Press_Arrow_Right
    *JSR DELAY   
    	
    JSR Press_Arrow_Left
    *JSR DELAY 
    
    JSR Press_Arrow_Up
    *JSR DELAY 
    
    JSR Press_Space
    *JSR DELAY
    
    *JSR CLEAR_SCREEN    
    BRA Control
    
    
    JSR HALT
    
    BRA START
    




Print_Welcome            ;position + text of first screen
    MOVE.B #11,D0
    MOVE.W #$1B0F,D1
    TRAP #15
    MOVE #14,D0
    LEA WELCOME,A1
    TRAP	#15
    MOVE.B #11,D0
    MOVE.W #$1B10,D1
    TRAP #15
    MOVE #14,D0
    LEA Press,A1
    TRAP	#15
    RTS

PressEnter
	MOVE.L	#$0D,D1  ;Enter ASCII IS 32
	MOVE.L	#19,D0  ;RETURNS CURRENT STATE OF SPECIFIED KEY
	TRAP	#15
	CMP.L	#$FF,D1
	BEQ	Pressed_Enter
	BRA	PressEnter
	
Pressed_Enter

    JSR CLEAR_SCREEN
    RTS

POSITION_CHAR ;bottom of the sccreen

    MOVE.B #11,D0
    MOVE.W #$277F,D1
    TRAP #15
    RTS
    
    

Draw_Enemy


   

Enemy_Move_Right
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Skeleton 
    MOVE.L #$00000080,D1 ; Maroon FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #88, D0   ; ELLIPSE Position + Dimensions
    
    MOVE.W #$FFFFFFE4,D1  ; LeftX
    ADD.L STEP_ENEMY_R,D1
    MOVE.W #$140, D2 ; UpperY
    MOVE.W #$FFFFFFF4,D3 ; RighX
    ADD.L STEP_ENEMY_R,D3
  	MOVE.W #$150, D4 ; LowerY
  	TRAP #15  
    
    
    
*start of movement

    MOVE.L LIM_ENEMY_R,D7
    CMP #$29B,D7
    BEQ Print_OVER


    ;MOVE.L LIM_ENEMY_R,D3
    ;CMP #$29B,D3
    ;BEQ RESET_R   
       
    MOVE.L LIM_ENEMY_R,D3
    ADD.L #1,D3
    MOVE.L D3,LIM_ENEMY_R
    
    MOVE.L STEP_ENEMY_R,D5
    ADD.L #1 ,D5
    MOVE.L D5,STEP_ENEMY_R 
    
*** ONE ***
 *Test if the the enemy is on position ONE
 *so it kills a pixel
    JSR POS_ONE
    
 *Test if PIX_TEST_ONE  == 1
 *so it will draw a white sqaure
    JSR TEST_POS_ONE
    
*** TWO ***
 *Test if the the enemy is on position TWO
 *so it kills a pixel
    JSR POS_TWO
    
 *Test if PIX_TEST_TWO == 1
 *so it will draw a white sqaure
    JSR TEST_POS_TWO    
    
*** THREE ***
 *Test if the the enemy is on position THREE
 *so it kills a pixel
    JSR POS_THREE
    
 *Test if PIX_TEST_THREE == 1
 *so it will draw a white sqaure
    JSR TEST_POS_THREE      
    
    
    JSR DELAY
    JSR CLEAR_SCREEN
    
    JSR DRAW_CHAR
    
    JSR Enemy_Move_Left
    ;JSR Press_Arrow_Right
    
    RTS
      
RESET_R  

    LEA	DEATHSound,A1	Play the sound of the crash
	MOVE	#73,D0
	TRAP	#15
	
    MOVE.L #0,D3
    MOVE.L D3,LIM_ENEMY_R
    MOVE.L D3,STEP_ENEMY_R
    
    
    ;JSR Enemy_Move_Left
    RTS
    
    
Enemy_Move_Left
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Skeleton 
    MOVE.L #$00800080,D1 ; purple FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #88, D0   ; ellipse Position + Dimensions
    
    MOVE.W #$287,D1  ; LeftX
    ADD.L STEP_ENEMY_L,D1
    MOVE.W #$100, D2 ; UpperY
    MOVE.W #$297,D3 ; RighX
    ADD.L STEP_ENEMY_L,D3
  	MOVE.W #$110, D4 ; LowerY
  	TRAP #15
    
* start of movement
    MOVE.L LIM_ENEMY_L,D3
    CMP #$10,D3
    BEQ Print_OVER
  
    MOVE.L LIM_ENEMY_L,D3
    SUB.L #1,D3
    MOVE.L D3,LIM_ENEMY_L
    
    MOVE.L STEP_ENEMY_L,D5
    SUB.L #1,D5
    MOVE.L D5,STEP_ENEMY_L   

*** FOUR ***
 *Test if the the enemy is on position FOUR
 *so it kills a pixel
    JSR POS_FOUR
    
 *Test if PIX_TEST_FOUR  == 1
 *so it will draw a white sqaure
    JSR TEST_POS_FOUR
    
*** FIVE ***
 *Test if the the enemy is on position FIVE
 *so it kills a pixel
    JSR POS_FIVE
    
 *Test if PIX_TEST_FIVE == 1
 *so it will draw a white sqaure
    JSR TEST_POS_FIVE  


    ;JSR DELAY
    JSR DRAW_CHAR
    ;JSR CLEAR_SCREEN
    JSR Press_Arrow_Right
    
    RTS 

RESET_L   

    LEA	DEATHSound,A1	Play the sound of the crash
	MOVE	#73,D0
	TRAP	#15
    MOVE.L #0,D3
    MOVE.L #$2A7,D2
    MOVE.L D2,LIM_ENEMY_L
    MOVE.L D3,STEP_ENEMY_L
    
    
    ;JSR Enemy_Move_Left
    RTS

DRAW_CHAR
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Skeleton tank
    MOVE.L #$00C0C0C0,D1 ; LTGray FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; rectangle Position + Dimensions
    
    MOVE.W #$127,D1  ; LeftX
    ADD.L STEP,D1
    MOVE.W #$1C0, D2 ; UpperY
    MOVE.W #$157,D3 ; RighX
    ADD.L STEP,D3
  	MOVE.W #$1E0, D4 ; LowerY
  	TRAP #15
  	
  *Gun
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15
    
    MOVE.B #80, D0
    MOVE.L #$000040FF, D1 ; RED PEN
    TRAP #15
    
    MOVE.B #88, D0   ; Ellipse Position + Dimensions
    MOVE.W #$13C, D1 ; LeftX
    ADD.L STEP,D1   
    MOVE.W #$1B5, D2 ; UpperY
    MOVE.W #$142, D3 ; RighX
    ADD.L STEP,D3
  	MOVE.W #$1C0, D4 ; LowerY
  	TRAP #15
    
    RTS


Press_Arrow_Right
    MOVE.L	#$27,D1  ;Right Arrow ASCII is 27
	MOVE.L	#19,D0  ; RETURNS CURRENT STATE OF SPECIFIED KEY
	TRAP	#15
	
	CMP.L	#$FF,D1 ; #$FF means pressed , #$00 means not-pressed
	BEQ	Pressed_Arrow_Right ; if CMP true, Z flag =1  
	BRA	Press_Arrow_Left
	;BRA Press_Arrow_Up
	
Pressed_Arrow_Right
            
    MOVE.L LIM,D3
    CMP #$24E,D3
    
    BEQ MAX_RX
       
    MOVE.L LIM,D3
    ADD.L #1,D3
    MOVE.L D3,LIM
    
    MOVE.L STEP,D5
    ADD.L #1 ,D5
    MOVE.L D5,STEP
                
MAX_RX
    
    *JSR CLEAR_SCREEN
    JSR DRAW_CHAR
    RTS
    
Press_Arrow_Left
    MOVE.L	#$25,D1  ; Left Arrow ASCII is 25  
	MOVE.L	#19,D0  ; RETURNS CURRENT STATE OF SPECIFIED KEY
	TRAP	#15
	
	CMP.L	#$FF,D1 ; #$FF means pressed , #$00 means not pressed
	BEQ	Pressed_Arrow_Left ; if CMP true, Z flag =1 , 
	BRA	Press_Arrow_Up
    ;BRA	Press_Arrow_Right
	
Pressed_Arrow_Left

    MOVE.L LIM,D3
    CMP #$00,D3
    BEQ MIN_LX
    
    MOVE.L LIM,D3
    ADD.L #$FFFFFFFF,D3
    MOVE.L D3,LIM
    
    MOVE.L STEP ,D5
    ADD.L #$FFFFFFFF,D5
    MOVE.L D5,STEP
                
MIN_LX
        
    *JSR CLEAR_SCREEN
    JSR DRAW_CHAR
    RTS
      
Press_Arrow_Up

    MOVE.L #$26,D1   
    MOVE.L #19,D0
    TRAP #15
    
    CMP.L #$FF,D1 
    BEQ Pressed_Arrow_Up
    BRA Press_Space
    ;BRA Press_Arrow_Right
    ;BRA	Press_Arrow_Left
    
Pressed_Arrow_Up
    
    LEA	LAZERSound,A1	Play the sound of the Lazer
	MOVE	#73,D0
	TRAP	#15
    *JSR CLEAR_SCREEN
    JSR COLLISION_RAD_1
    JSR COLLISION_RAD_2
    JSR Radiation
    
    RTS

Radiation

    MOVE.L #$000000FF,D1 ; RED FILL
    MOVE.B #81, D0
    TRAP #15
    
    MOVE.B #80, D0
    MOVE.L #$000000FF, D1 ; RED PEN
    TRAP #15

    MOVE.B #87, D0   ; Rectangle (lazer) Position + Dimensions
    MOVE.W #$13E, D1 ; LeftX
    ADD.L STEP,D1  
    
    MOVE.W #$00, D2 ; UpperY
    MOVE.W #$140, D3 ; RighX
    ADD.L STEP,D3
    
  	MOVE.W #$1B4, D4 ; LowerY
  	TRAP #15
  	
  	  	  *Gun
    MOVE.B #80, D0
    MOVE.L #$00000080, D1 ; Gray PEN
    TRAP #15
    
    MOVE.B #88, D0   ; Ellipse Position + Dimensions
    MOVE.W #$13C, D1 ; LeftX
    ADD.L STEP,D1   
    MOVE.W #$1B5, D2 ; UpperY
    MOVE.W #$142, D3 ; RighX
    ADD.L STEP,D3
  	MOVE.W #$1C0, D4 ; LowerY
  	TRAP #15
  	
  	
  	
    JSR DELAY
    *JSR CLEAR_SCREEN
    JSR DRAW_CHAR
    JSR Enemy_Move_Right
    
    RTS

Press_Space

    MOVE.L #$20,D1   
    MOVE.L #19,D0
    TRAP #15
    
    CMP.L #$FF,D1 
    BEQ Pressed_Space
    ;BRA Press_Arrow_Right
    BRA Enemy_Move_Right
    
Pressed_Space

    *JSR CLEAR_SCREEN
    JSR COLLISION_HEAL_ONE
    JSR COLLISION_HEAL_TWO
    JSR COLLISION_HEAL_THREE
    JSR COLLISION_HEAL_FOUR
    JSR COLLISION_HEAL_FIVE

    JSR Heal
    RTS

Heal

    MOVE.B #80, D0
    MOVE.L #$0000FF00, D1 ; Lime PEN
    TRAP #15

    MOVE.L #$0000FF00,D1 ; Lime FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Rectangle (lazer) Position + Dimensions
    MOVE.W #$13E, D1 ; LeftX
    ADD.L STEP,D1  
    
    MOVE.W #$00, D2 ; UpperY
    MOVE.W #$140, D3 ; RighX
    ADD.L STEP,D3
    
  	MOVE.W #$1B4, D4 ; LowerY
  	TRAP #15
  	
  	  *Gun
    MOVE.B #80, D0
    MOVE.L #$00000080, D1 ; Gray PEN
    TRAP #15
    
    MOVE.B #88, D0   ; Ellipse Position + Dimensions
    MOVE.W #$13C, D1 ; LeftX
    ADD.L STEP,D1   
    MOVE.W #$1B5, D2 ; UpperY
    MOVE.W #$142, D3 ; RighX
    ADD.L STEP,D3
  	MOVE.W #$1C0, D4 ; LowerY
  	TRAP #15
  	
  	
    *JSR DELAY
    *JSR CLEAR_SCREEN
    JSR DRAW_CHAR
    JSR Enemy_Move_Right
    
    RTS

    
COLLISION_RAD_1
    
    *if laser collide the enemy

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
    MOVE.l #$13F, D6 ; MiddleX
    ADD.L STEP,D6
    
    

*ENEMY
    MOVE.l #$FFFFFFE4,D3  ; LeftX
    ADD.L STEP_ENEMY_R,D3
    
    MOVE.l #$FFFFFFF4,D4 ; RightX
    ADD.L STEP_ENEMY_R,D4
    
    MOVE.l #$FFFFFFEC,D5  ; MiddleX
    ADD.L STEP_ENEMY_R,D5
    
*Test left of laser with dead pixel 
    CMP.L D1,D3
    BEQ RESET_R
    CMP.L D1,D4
    BEQ RESET_R
    CMP.L D1,D5
    BEQ RESET_R
    
*Test middle of laser with dead pixel 
    CMP.L D6,D3
    BEQ RESET_R
    CMP.L D6,D4
    BEQ RESET_R
    CMP.L D6,D5
    BEQ RESET_R

*Test left of laser with dead pixel 
    CMP.L D2,D3
    BEQ RESET_R
    CMP.L D2,D4
    BEQ RESET_R
    CMP.L D2,D5
    BEQ RESET_R    
        
    RTS
    
COLLISION_RAD_2

    *if laser collide the enemy

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
    MOVE.l #$13F, D6 ; MiddleX
    ADD.L STEP,D6


*ENEMY
    MOVE.l #$287,D3  ; LeftX
    ADD.L STEP_ENEMY_L,D3
    
    MOVE.l #$297,D4 ; RightX
    ADD.L STEP_ENEMY_L,D4
    
    MOVE.l #$28F,D5  ; MiddleX
    ADD.L STEP_ENEMY_L,D5
    
*Test left of laser with dead pixel 
    CMP.L D1,D3
    BEQ RESET_L
    CMP.L D1,D4
    BEQ RESET_L
    CMP.L D1,D5
    BEQ RESET_L
    
*Test middle of laser with dead pixel 
    CMP.L D6,D3
    BEQ RESET_L
    CMP.L D6,D4
    BEQ RESET_L
    CMP.L D6,D5
    BEQ RESET_L

*Test left of laser with dead pixel 
    CMP.L D2,D3
    BEQ RESET_L
    CMP.L D2,D4
    BEQ RESET_L
    CMP.L D2,D5
    BEQ RESET_L    
        
    RTS    
    
    
************************************************ START ONE ************************************************ 
COLLISION_HEAL_ONE

    *if laser collide the dead pixel

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
        
    MOVE.l #$13F, D3 ; MiddleX
    ADD.L STEP,D3
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
*Dead pixel    
    MOVE.L #$13E,D4  ; LeftX
    MOVE.L #142,D5   ; MiddleX
    MOVE.L #$145,D6 ; RighX

*Test left of laser with dead pixel 	
    CMP.L D1,D4
    BEQ PIXEL_ONE_TO_0
    CMP.L D1,D5
    BEQ PIXEL_ONE_TO_0
    CMP.L D1,D6
    BEQ PIXEL_ONE_TO_0
    
*Test middle of laser with dead pixel 	
    CMP.L D3,D4
    BEQ PIXEL_ONE_TO_0
    CMP.L D3,D5
    BEQ PIXEL_ONE_TO_0
    CMP.L D3,D6
    BEQ PIXEL_ONE_TO_0    
    
*Test right of laser with dead pixel 	
    CMP.L D2,D4
    BEQ PIXEL_ONE_TO_0
    CMP.L D2,D5
    BEQ PIXEL_ONE_TO_0
    CMP.L D2,D6
    BEQ PIXEL_ONE_TO_0    
    
    RTS
       
POS_ONE

    MOVE.l #$FFFFFFE4,D4  ; LeftX
    ADD.L STEP_ENEMY_R,D4
    CMP.L #$13E,D4
    BEQ PIXEL_ONE
    RTS

    
PIXEL_ONE
    MOVE.L #1,PIX_TEST_ONE
    RTS
    
PIXEL_ONE_TO_0
    MOVE.L PIX_TEST_ONE,D6
    CMP.L #1,D6
    BEQ PIXEL_ONE_TO_0_SURE
    
    RTS

PIXEL_ONE_TO_0_SURE


    LEA	HEALSound,A1	;Play the sound of HEALING
	MOVE	#73,D0
	TRAP	#15
    
    JSR WINNING
    
    MOVE.L #0,PIX_TEST_ONE
    RTS
    
TEST_POS_ONE
    MOVE.L PIX_TEST_ONE,D6
    CMP.L #1,D6
    BEQ KILL_PIXEL_ONE
    RTS

KILL_PIXEL_ONE
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Square 
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Position + Dimensions
    
    MOVE.W #$13E,D1  ; LeftX
    MOVE.W #$149, D2 ; UpperY
    MOVE.W #$145,D3 ; RighX
  	MOVE.W #$150, D4 ; LowerY
  	TRAP #15
    
    RTS
************************************************ END ONE ************************************************ 

************************************************ START TWO ************************************************ 
COLLISION_HEAL_TWO

    *if laser collide the dead pixel

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
        
    MOVE.l #$13F, D3 ; MiddleX
    ADD.L STEP,D3
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
*Dead pixel    
    MOVE.L #$9F,D4  ; LeftX
    MOVE.L #$A2,D5   ; MiddleX
    MOVE.L #$A6,D6 ; RighX

*Test left of laser with dead pixel 	
    CMP.L D1,D4
    BEQ PIXEL_TWO_TO_0
    CMP.L D1,D5
    BEQ PIXEL_TWO_TO_0
    CMP.L D1,D6
    BEQ PIXEL_TWO_TO_0
    
*Test middle of laser with dead pixel 	
    CMP.L D3,D4
    BEQ PIXEL_TWO_TO_0
    CMP.L D3,D5
    BEQ PIXEL_TWO_TO_0
    CMP.L D3,D6
    BEQ PIXEL_TWO_TO_0    
    
*Test right of laser with dead pixel 	
    CMP.L D2,D4
    BEQ PIXEL_TWO_TO_0
    CMP.L D2,D5
    BEQ PIXEL_TWO_TO_0
    CMP.L D2,D6
    BEQ PIXEL_TWO_TO_0    
    
    RTS
       
POS_TWO

    MOVE.l #$FFFFFFE4,D4  ; LeftX
    ADD.L STEP_ENEMY_R,D4
    CMP.L #$9F,D4
    BEQ PIXEL_TWO
    RTS

    
PIXEL_TWO
    MOVE.L #1,PIX_TEST_TWO
    RTS
    
PIXEL_TWO_TO_0
    MOVE.L PIX_TEST_TWO,D6
    CMP.L #1,D6
    BEQ PIXEL_TWO_TO_0_SURE
    
    RTS

PIXEL_TWO_TO_0_SURE


    LEA	HEALSound,A1 ;Play the sound of HEALING
	MOVE	#73,D0
	TRAP	#15

    JSR WINNING

    MOVE.L #0,PIX_TEST_TWO
    RTS
    
TEST_POS_TWO
    MOVE.L PIX_TEST_TWO,D6
    CMP.L #1,D6
    BEQ KILL_PIXEL_TWO
    RTS

KILL_PIXEL_TWO
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Square 
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Position + Dimensions
    
    MOVE.W #$9F,D1  ; LeftX
    MOVE.W #$149, D2 ; UpperY
    MOVE.W #$A6,D3 ; RighX
  	MOVE.W #$150, D4 ; LowerY
  	TRAP #15
    
    RTS
************************************************ END TWO ************************************************ 

************************************************ START THREE ************************************************ 
COLLISION_HEAL_THREE

    *if laser collide the dead pixel

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
        
    MOVE.l #$13F, D3 ; MiddleX
    ADD.L STEP,D3
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
*Dead pixel    
    MOVE.L #$1DD,D4  ; LeftX
    MOVE.L #$1E0,D5   ; MiddleX
    MOVE.L #$1E4,D6 ; RighX

*Test left of laser with dead pixel 	
    CMP.L D1,D4
    BEQ PIXEL_THREE_TO_0
    CMP.L D1,D5
    BEQ PIXEL_THREE_TO_0
    CMP.L D1,D6
    BEQ PIXEL_THREE_TO_0
    
*Test middle of laser with dead pixel 	
    CMP.L D3,D4
    BEQ PIXEL_THREE_TO_0
    CMP.L D3,D5
    BEQ PIXEL_THREE_TO_0
    CMP.L D3,D6
    BEQ PIXEL_THREE_TO_0    
    
*Test right of laser with dead pixel 	
    CMP.L D2,D4
    BEQ PIXEL_THREE_TO_0
    CMP.L D2,D5
    BEQ PIXEL_THREE_TO_0
    CMP.L D2,D6
    BEQ PIXEL_THREE_TO_0    
    
    RTS
       
POS_THREE

    MOVE.l #$FFFFFFE4,D4  ; LeftX
    ADD.L STEP_ENEMY_R,D4
    CMP.L #$1DD,D4
    BEQ PIXEL_THREE
    RTS

    
PIXEL_THREE
    MOVE.L #1,PIX_TEST_THREE
    RTS
    
PIXEL_THREE_TO_0
    MOVE.L PIX_TEST_THREE,D6
    CMP.L #1,D6
    BEQ PIXEL_THREE_TO_0_SURE
    
    RTS

PIXEL_THREE_TO_0_SURE

    LEA	HEALSound,A1 ;Play the sound of HEALING
	MOVE	#73,D0
	TRAP	#15

    JSR WINNING

    MOVE.L #0,PIX_TEST_THREE
    RTS
    
TEST_POS_THREE
    MOVE.L PIX_TEST_THREE,D6
    CMP.L #1,D6
    BEQ KILL_PIXEL_THREE
    RTS

KILL_PIXEL_THREE
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Square 
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Position + Dimensions
    
    MOVE.W #$1DD,D1  ; LeftX
    MOVE.W #$149, D2 ; UpperY
    MOVE.W #$1E4,D3 ; RighX
  	MOVE.W #$150, D4 ; LowerY
  	TRAP #15
    
    RTS
************************************************ END THREE ************************************************ 

************************************************ START FOUR ************************************************ 
COLLISION_HEAL_FOUR 

    *if laser collide the dead pixel

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
        
    MOVE.l #$13F, D3 ; MiddleX
    ADD.L STEP,D3
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
*Dead pixel    
    MOVE.L #$EE,D4  ; LeftX
    MOVE.L #$F1,D5   ; MiddleX
    MOVE.L #$F5,D6 ; RighX

*Test left of laser with dead pixel 	
    CMP.L D1,D4
    BEQ PIXEL_FOUR_TO_0
    CMP.L D1,D5
    BEQ PIXEL_FOUR_TO_0
    CMP.L D1,D6
    BEQ PIXEL_FOUR_TO_0
    
*Test middle of laser with dead pixel 	
    CMP.L D3,D4
    BEQ PIXEL_FOUR_TO_0
    CMP.L D3,D5
    BEQ PIXEL_FOUR_TO_0
    CMP.L D3,D6
    BEQ PIXEL_FOUR_TO_0    
    
*Test right of laser with dead pixel 	
    CMP.L D2,D4
    BEQ PIXEL_FOUR_TO_0
    CMP.L D2,D5
    BEQ PIXEL_FOUR_TO_0
    CMP.L D2,D6
    BEQ PIXEL_FOUR_TO_0    
    
    RTS
       
POS_FOUR

    MOVE.l #$287,D4  ; LeftX
    ADD.L STEP_ENEMY_L,D4
    CMP.L #$F5,D4
    BEQ PIXEL_FOUR
    RTS

    
PIXEL_FOUR
    MOVE.L #1,PIX_TEST_FOUR
    RTS
    
PIXEL_FOUR_TO_0
    MOVE.L PIX_TEST_FOUR,D6
    CMP.L #1,D6
    BEQ PIXEL_FOUR_TO_0_SURE
    
    RTS

PIXEL_FOUR_TO_0_SURE

    LEA	HEALSound,A1 ;Play the sound of HEALING
	MOVE	#73,D0
	TRAP	#15

    JSR WINNING

    MOVE.L #0,PIX_TEST_FOUR
    RTS
    
TEST_POS_FOUR
    MOVE.L PIX_TEST_FOUR,D6
    CMP.L #1,D6
    BEQ KILL_PIXEL_FOUR
    RTS

KILL_PIXEL_FOUR
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Square 
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Position + Dimensions
    
    MOVE.W #$EE,D1  ; LeftX
    MOVE.W #$109, D2 ; UpperY
    MOVE.W #$F5,D3 ; RighX
  	MOVE.W #$110, D4 ; LowerY
  	TRAP #15
    
    RTS
************************************************ END FOUR ************************************************ 

************************************************ START FIVE ************************************************ 
COLLISION_HEAL_FIVE 

    *if laser collide the dead pixel

*LASER Position + Dimensions
    MOVE.l #$13E, D1 ; LeftX
    ADD.L STEP,D1
        
    MOVE.l #$13F, D3 ; MiddleX
    ADD.L STEP,D3
    
    MOVE.l #$140, D2 ; RightX
    ADD.L STEP,D2
    
*Dead pixel    
    MOVE.L #$18D,D4  ; LeftX
    MOVE.L #$190,D5   ; MiddleX
    MOVE.L #$194,D6 ; RighX

*Test left of laser with dead pixel 	
    CMP.L D1,D4
    BEQ PIXEL_FIVE_TO_0
    CMP.L D1,D5
    BEQ PIXEL_FIVE_TO_0
    CMP.L D1,D6
    BEQ PIXEL_FIVE_TO_0
    
*Test middle of laser with dead pixel 	
    CMP.L D3,D4
    BEQ PIXEL_FIVE_TO_0
    CMP.L D3,D5
    BEQ PIXEL_FIVE_TO_0
    CMP.L D3,D6
    BEQ PIXEL_FIVE_TO_0    
    
*Test right of laser with dead pixel 	
    CMP.L D2,D4
    BEQ PIXEL_FIVE_TO_0
    CMP.L D2,D5
    BEQ PIXEL_FIVE_TO_0
    CMP.L D2,D6
    BEQ PIXEL_FIVE_TO_0    
    
    RTS
       
POS_FIVE

    MOVE.l #$287,D4  ; LeftX
    ADD.L STEP_ENEMY_L,D4
    CMP.L #$194,D4
    BEQ PIXEL_FIVE
    RTS

    
PIXEL_FIVE
    MOVE.L #1,PIX_TEST_FIVE
    RTS
    
PIXEL_FIVE_TO_0
    MOVE.L PIX_TEST_FIVE,D6
    CMP.L #1,D6
    BEQ PIXEL_FIVE_TO_0_SURE
    
    RTS

PIXEL_FIVE_TO_0_SURE

    LEA	HEALSound,A1 ;Play the sound of HEALING
	MOVE	#73,D0
	TRAP	#15

    JSR WINNING
    
    MOVE.L #0,PIX_TEST_FIVE
    RTS
    
TEST_POS_FIVE
    MOVE.L PIX_TEST_FIVE,D6
    CMP.L #1,D6
    BEQ KILL_PIXEL_FIVE
    RTS

KILL_PIXEL_FIVE
    
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15

  *Square 
    MOVE.L #$00FFFFFF,D1 ; WHITE FILL
    MOVE.B #81, D0
    TRAP #15

    MOVE.B #87, D0   ; Position + Dimensions
    
    MOVE.W #$18D,D1  ; LeftX
    MOVE.W #$109, D2 ; UpperY
    MOVE.W #$194,D3 ; RighX
  	MOVE.W #$110, D4 ; LowerY
  	TRAP #15
    
    RTS
************************************************ END FIVE ************************************************ 

WINNING

    MOVE.L WIN,D6
    ADDI.L #1,D6
    MOVE.L D6,WIN
   
    CMP.L #5,D6 ; Change number of healed pixels to win
    BEQ Print_WON
    RTS

Print_WON
    JSR CLEAR_SCREEN   
    ;CLR D6
    ;MOVE.L D6,WIN
    MOVE.B #80, D0
    MOVE.L #$00008080, D1 ; White PEN
    TRAP #15
    MOVE.L #$00008080,D1 ; YELLOW FILL
    MOVE.B #81, D0
    TRAP #15 
    LEA	WinSound ,A1	Play the sound 
	MOVE	#73,D0
	TRAP	#15
Print_WONN          ;position + text of first screen

*    move.w	#0,D1
*	move.w	#0,D2
*	move.w	#640,D3
*	move.w	#480,D4
*	move.l	#87,D0
*	trap	#15

    MOVE.B #11,D0
    MOVE.W #$1B0F,D1
    TRAP #15
    MOVE #14,D0
    LEA WON,A1
    TRAP	#15
    MOVE.B #11,D0
    MOVE.W #$1B10,D1
    TRAP #15
    MOVE #14,D0
    LEA PressW,A1
    TRAP	#15
    
    
    JSR PRESS_WON
    
PRESS_WON
    
	MOVE.L	#$0D,D1  ;Enter  ASCII IS 32
	MOVE.L	#19,D0  ;RETURNS CURRENT STATE OF SPECIFIED KEY
	TRAP	#15
	CMP.L	#$FF,D1
	BEQ	PRESSED_WON
	BRA	PRINT_WONN
	
PRESSED_WON

    JSR START



Print_OVER
    JSR CLEAR_SCREEN   
    MOVE.B #80, D0
    MOVE.L #$00FFFFFF, D1 ; White PEN
    TRAP #15
    MOVE.L #$000000FF,D1 ; RED FILL
    MOVE.B #81, D0
    TRAP #15 
    
    LEA	GameOverSound ,A1	Play the sound 
	MOVE	#73,D0
	TRAP	#15
Print_OVERR          ;position + text of first screen

    
    MOVE.B #11,D0
    MOVE.W #$1B0F,D1
    TRAP #15
    MOVE #14,D0
    LEA OVER,A1
    TRAP	#15
    MOVE.B #11,D0
    MOVE.W #$1B10,D1
    TRAP #15
    MOVE #14,D0
    LEA PressR,A1
    TRAP	#15
    
    JSR PRESS_Rep
    
PRESS_Rep
    
	MOVE.L	#$0D,D1  ;Enter  ASCII IS 32
	MOVE.L	#19,D0  ;RETURNS CURRENT STATE OF SPECIFIED KEY
	TRAP	#15
	CMP.L	#$FF,D1
	BEQ	PRESSED_Rep
	BRA	PRINT_OVERR
	
PRESSED_Rep

    JSR START


HALT

    MOVE.B	#9,D0
	TRAP	#15	
    RTS


CLEAR_SCREEN ; clears the screen
    MOVE.B	#11,D0
    MOVE.W	#$FF00,D1
	trap	#15
	RTS


DELAY
    MOVE.L	#1,D1	Slow down the loop by a tenth of a second
	MOVE.L	#23,D0  ;DELAY
	TRAP	#15
    RTS
DELAY_L
    MOVE.L	#$1,D1	Slow down the loop by a tenth of a second
	MOVE.L	#23,D0  ;DELAY
	TRAP	#15
    RTS
    
    
INITIALIZE

    
    LEA	StartSound,A1	Play the sound
	MOVE	#73,D0
	TRAP	#15

    CLR D6
    MOVE.L D6,WIN
    
    MOVE.L #0,D3
    MOVE.L D3,LIM_ENEMY_R
    MOVE.L D3,STEP_ENEMY_R
    
    MOVE.L #0,D3
    MOVE.L #$2A7,D2
    MOVE.L D2,LIM_ENEMY_L
    MOVE.L D3,STEP_ENEMY_L
    
    MOVE.L #0,PIX_TEST_ONE
    MOVE.L #0,PIX_TEST_TWO
    MOVE.L #0,PIX_TEST_THREE
    MOVE.L #0,PIX_TEST_FOUR
    MOVE.L #0,PIX_TEST_FIVE
    
    RTS

*PRINT_CHAR ; til now that's the char "^"
*    MOVE #14,D0
*    LEA CHAR,A1
*    TRAP	#15
*    RTS


SET_SCREEN_SIZE ; we're not gonna use it
    MOVE.B #33,D0
    MOVE.L #1024*$10000+768,D1 ;Set screen to 1024 x 768
    TRAP   #15 
    RTS


    END	START


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
