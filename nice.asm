ORG 0000H
JMP 2000H	;The place where program start
ORG 003CH
JMP ISR7_5

ORG 2000H
LXI SP,7FFFH
MVI A, 10010010B ; Input:Port A & B, Output: Port C
OUT 83H ; Send control word to control register.
OUT 43H
OUT 13H

MVI A, 1000000B ; Output: All port
OUT 33H
OUT 20H

MVI A, 00011000B	;Interrupt 5.5,6.5 and 7.5 can be used
SIM			;Set Interrupt Mask
EI			;Enable Interrupt

LED3:   EQU 42H		;Output: LED3
LED2: 	EQU 12H		;Output: LED2
PASS: 	EQU 11H		;Input:  Keypad
NUM5:	EQU 21H		;Output: 5th 7-segment
NUM4:	EQU 20H		;Output: 4th 7-segment
NUM3:	EQU 30H		;Output: 3rd 7-segment
NUM2:	EQU 31H		;Output: 2nd 7-segment
NUM1: 	EQU 32H   	;Output: 1st 7-segment
LED: 	EQU 82H   	;Output: LED1
BOT: 	EQU 81H   	;Input:  Button
SW: 	EQU 80H    	;Input:  Switch


LXI SP,7FFFH
MVI A,1110001B
OUT 10H

REST:  	LXI SP,7FFFH
	IN PASS
	CPI 00011110B
	JZ PASSCHK
	JMP REST

PASSCHK: MVI A,00000000B
         OUT LED2
         IN PASS
         CPI 00000000B
         JZ PASS2
         CPI 00000001B
         JZ  WRGPASS2
         CPI 00000010B
         JZ  WRGPASS2
         CPI 00000100B
         JZ  WRGPASS2
         CPI 00000101B
         JZ  WRGPASS2
         CPI 00000110B
         JZ  WRGPASS2
         JMP PASSCHK
         MVI A, 11111111B
         OUT LED2


PASSCHK1:
	 LXI	H, SEVSEG
	 MOV	A, M	;'E'
	 OUT	NUM5
	 INX	H	;POINT TO NEXT DATA(o)
	 MOV	A, M
	 OUT	NUM4
	 INX	H
	 MOV	A, M
	 OUT	NUM3
	 INX	H
	 MOV	A,M
	 OUT	NUM2
	 INX	H
	 MOV	A,M
	 OUT	NUM1
	 CALL   DELAY
	 MVI	A,0	;RESET DISPLAY TO ZERO
	 OUT	NUM5
	 OUT	NUM4
	 OUT	NUM3
	 OUT	NUM2
	 OUT    NUM1
	 MVI A,11111111B
         OUT LED2
         MVI A,00000000B
         OUT LED2
         IN PASS 
         CPI 00011110B	;Return to ready form
         JZ REST
         JMP PASSCHK1


PASS2:   MVI A,00000001B
         OUT LED2
         CALL DELAY
LOOPP2:  IN PASS
         CPI 00010001B
         JZ PASS3
         CPI 00000000B  
         JNZ WRGPASS2
         JMP LOOPP2
 
PASS3:   MVI A, 00000011B
         OUT LED2
         CALL DELAY
LOOPP3:  IN PASS
         CPI 00010010B
         JZ PASS4
         CPI 00000001B  
         JNZ WRGPASS3
         JMP LOOPP3

PASS4:   MVI A, 00000111B
         OUT LED2
         CALL DELAY
LOOPP4:  IN PASS
         CPI 00010100B
         JZ CORTPASS
         CPI 00000010B  
         JNZ WRGPASS4
         JMP LOOPP4


 
WRGPASS2: MVI A,00000001B
          OUT LED2
          NOP
          NOP
          NOP

LOOPA2:   IN PASS
          CPI 00010000B
          JZ  WRGPASS3
          CPI 00010001B
          JZ  WRGPASS3
          CPI 00010010B
          JZ  WRGPASS3
          CPI 00010100B
          JZ  WRGPASS3
          CPI 00010101B
          JZ  WRGPASS3
          CPI 00010110B
          JZ  WRGPASS3
          JMP LOOPA2 

WRGPASS3: MVI A,00000011B
          OUT LED2
          NOP
          NOP
          NOP

LOOPA3:   IN PASS
          CPI 00010000B
          JZ  WRGPASS4
          CPI 00010001B
          JZ  WRGPASS4
          CPI 00010010B
          JZ  WRGPASS4
          CPI 00010100B
          JZ  WRGPASS4
          CPI 00010101B
          JZ  WRGPASS4
          CPI 00010110B
          JZ  WRGPASS4
          JMP LOOPA3

WRGPASS4: MVI A,00000111B
          OUT LED2
          NOP
          NOP
          NOP

LOOPA4:   IN PASS
          CPI 00010000B
          JZ  PASSCHK1
          CPI 00010001B
          JZ  PASSCHK1
          CPI 00010010B
          JZ  PASSCHK1
          CPI 00010100B
          JZ  PASSCHK1
          CPI 00010101B
          JZ  PASSCHK1
          CPI 00010110B
          JZ  PASSCHK1
          JMP LOOPA4            
       

CORTPASS:MVI C,10
         MVI A, 00001111B
         OUT LED2
         MVI A,255
         OUT LED2
         NOP
         NOP
         CALL DELAY


CTRL: MVI A, 00000000B
      OUT LED
      MVI A, 00000000B
      OUT NUM1  
      IN BOT
      CPI 01H
      JZ  FL1
      JMP CTRL
     

FL1:   MVI A, 00000001B
       OUT LED
       MVI A, 00000110B
       OUT NUM1 
       CALL DELAY 
       OUT NUM1
LOOPB1:MVI A, 00000110B
       OUT NUM1
       IN  SW
       CPI 02H
       JZ  FL2
       CPI 04H
       JZ  FL2
       CPI 08H
       JZ  FL2
       JMP LOOPB1
     
 

FL2:   MVI A, 00000010B
       OUT LED
       MVI A, 01011011B
       OUT NUM1
       CALL DELAY
LOOPB2:IN SW
       CPI 04H
       JZ FL3
       CPI 08H
       JZ FL3
       IN BOT
       CPI 04H  
       JNZ LOOPB2

D2:    MVI A, 00000010B
       OUT LED
       MVI A, 01011011B
       OUT NUM1
       CALL DELAY
LOOPC2:IN SW 
       CPI 01H
       JZ FL1
       IN BOT
       CPI 02H
       JZ FL2
       JMP LOOPC2



FL3:   MVI A, 00000100B
       OUT LED
       MVI A, 01001111B
       OUT NUM1
       CALL DELAY
LOOPB3:IN SW
       CPI 08H
       JZ FL4
       IN BOT
       CPI 04H  
       JNZ LOOPB3

D3:    MVI A, 00000100B
       OUT LED
       MVI A, 01001111B
       OUT NUM1
       CALL DELAY
LOOPC3:IN SW 
       CPI 01H
       JZ D2
       CPI 02H
       JZ FL2
       IN BOT
       CPI 02H
       JZ FL3
       JMP LOOPC3   



FL4:   MVI A, 00001000B
       OUT LED
       MVI A, 01100110B
       OUT NUM1
       CALL DELAY
LOOPB4:IN BOT
       CPI 04H  
       JNZ LOOPB4

D4:    IN SW 
       CPI 01H
       JZ D3
       CPI 02H
       JZ D3
       CPI 04H
       JZ FL3
       IN BOT
       CPI 02H
       JZ FL4
       JMP D4  


DELAY: 	MVI A,25	;
LOOP1: 	DCR A
	JNZ LOOP1
	RET	

MYDATA: 
       DFS 2
       ORG 2FFFH

MYPASS:
     DFS 2

MYSAVEPASS:
     DFS 2


SEVSEGDAT:	
        DFB  00000110B, 01011011B, 01001111B, 01110111B ; 1,2,3,A
        DFB  01100110B, 01101101B, 01111101B, 01111100B ; 4,5,6,B
        DFB  00000111B, 01111111B, 01101111B, 00111001B ; 7,8,9,C
        DFB  01011100B, 00111111B, 01110110B, 01011110B ; *,0,#,D

SEVSEG:
	DFB	79H,50H,50H,5CH,50H	; E,r,r,o,r

ISR7_5:
	PUSH 	PSW
	MVI	A,0
	MVI	B,5	;Counter
R1:	CMA
	ANI	0FFH
	OUT	42H
	CALL	DELAY
	DCR	B
	JNZ	R1
	EI
	POP	PSW
	RET
	
