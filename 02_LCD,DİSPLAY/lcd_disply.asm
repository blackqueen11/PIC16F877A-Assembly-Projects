      list P=16F877A
      include <P16F877A.INC>
      __config H'3F31'
CBLOCK 0x20
   COUNTER1
   COUNTER2
ENDC 
      ORG 0x00 
      GOTO START

START 
	 bsf  STATUS,RP0
	 clrf TRISB    ;for display
     clrf TRISD    ;for lcd
     clrf TRISC    ;for pin rs and e
     bcf  STATUS,RP0
	 clrf PORTD
     clrf PORTC
     clrf PORTB
     call LCD_START   ; first start the lcd
     call LCD_WRT      ; show the number on lcd
     call DSPLAY       ; show the number on display
     
LAST_LOOP
     goto LAST_LOOP    ; Ýts for lcd to stay here


LOOK_UP
     addwf PCL,F
     retlw 0x40
     retlw 0x79
     retlw 0x24
     retlw 0x30
     retlw 0x26
     retlw 0x12
     retlw 0x02
     retlw 0x38
     retlw 0x00
     retlw 0x10

DSPLAY  
     movlw .2
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG ; need more time to see the number on display
     movlw .3
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .8
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .8
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .2
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .0
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .0
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .2
     call LOOK_UP
     movwf PORTB
     call WAÝT_LONG
     movlw .1
     call LOOK_UP
     movwf PORTB
     return

SEND_COMMND
     bcf  PORTC,0  ; command mode
     movwf PORTD
     bsf  PORTC,1  ; enable is open
     call DELAY
     bcf  PORTC,1
     return
LCD_START
     movlw 0x30    ; 8 bit 1 line
     call SEND_COMMND
  
     movlw 0x0C    ;open the screen
     call SEND_COMMND

     movlw 0x01    ; clean the screen
     call SEND_COMMND
     call WAÝT_LONG ; need more time for cleaning
     return
SEND_DATA
     bsf  PORTC,0     ; RS on data mode
     movwf PORTD
     bsf  PORTC,1
     call DELAY
     bcf  PORTC,1
     return
LCD_WRT ;number
     movlw 0x32
     call SEND_DATA
     movlw 0x33
     call SEND_DATA
     movlw 0x38
     call SEND_DATA
     movlw 0x38
     call SEND_DATA
     movlw 0x32
     call SEND_DATA  
     movlw 0x30
     call SEND_DATA
     movlw 0x30                                         
     call SEND_DATA
     movlw 0x32
     call SEND_DATA
     movlw 0x31
     call SEND_DATA
     return

DELAY
     movlw 0xFF
     movwf COUNTER1
L1   decfsz COUNTER1,F
     goto L1
     return

WAÝT_LONG
     movlw d'200'
     movwf COUNTER1
INTERNAL_LOOP
     movlw 0xFF
     movwf COUNTER2
OUTERLOOP
     decfsz COUNTER2
     goto OUTERLOOP

     decfsz COUNTER1
     goto INTERNAL_LOOP
     return
  end


    
     
