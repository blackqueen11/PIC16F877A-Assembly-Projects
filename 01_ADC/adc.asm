       list  P=16F877A
       include <P16F877A.INC>
       __config H'3F31'

gecikme1  equ 0x20 

       ORG 0X00
       GOTO Ana_Prog
Ana_Prog
;ADIM1- BURADA ADCON1 VE TRIS KULLANARAK ANALOG PİNLERİN GİRİŞİNİ SEÇTİK
    bsf    STATUS, RP0   ;tris bank1 de
    movlw  d'255'        ;8 tane 1 demek ,yani porta giriş
    movwf  TRISA
    clrf   TRISB 
    movlw  b'00001110'    ;AN0 pini analog 
    movwf  ADCON1
    bcf    STATUS, RP0
    clrf   PORTB
;ADIM2-3 ADCON0 İLE KANAL , SAAT SEÇİMİ ve ADON=1
    movlw  0x81
    movwf  ADCON0        ;ADON=1 ve osilatör 1:32
;ADIM4 - DÖNÜŞÜMÜ BAŞLAT
Dongu
    call   GECIKME
    bsf    ADCON0,2
;ADIM5-6 - BİTMESİNİ BEKLE VE SONUCU OKU
Bekle
    btfsc  ADCON0,2
    goto   Bekle
    
    movf   ADRESH,W   ;dijitale dönen bilgiyi al b portuna ver
    BANKSEL PORTB
    movwf  PORTB
  
    goto   Dongu

GECIKME
    movlw   d'50'
    movwf   gecikme1
Loop
    decfsz  gecikme1,f
    goto    Loop
    return
  end
 

    
    
    
     
