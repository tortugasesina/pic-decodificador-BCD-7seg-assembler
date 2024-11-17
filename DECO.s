PROCESSOR 16F628A
#include <xc.inc>
; CONFIG
  CONFIG  FOSC = INTOSCIO       ; Oscillator Selection bits (INTOSC oscillator: I/O function on RA6/OSC2/CLKOUT pin, I/O function on RA7/OSC1/CLKIN)
  CONFIG  WDTE = OFF            ; Watchdog Timer Enable bit (WDT disabled)
  CONFIG  PWRTE = OFF           ; Power-up Timer Enable bit (PWRT disabled)
  CONFIG  MCLRE = OFF           ; RA5/MCLR/VPP Pin Function Select bit (RA5/MCLR/VPP pin function is digital input, MCLR internally tied to VDD)
  CONFIG  BOREN = OFF           ; Brown-out Detect Enable bit (BOD disabled)
  CONFIG  LVP = OFF             ; Low-Voltage Programming Enable bit (RB4/PGM pin has digital I/O function, HV on MCLR must be used for programming)
  CONFIG  CPD = OFF             ; Data EE Memory Code Protection bit (Data memory code protection off)
  CONFIG  CP = OFF              ; Flash Program Memory Code Protection bit (Code protection off)

;******************************varibles***************************************** 
num_0 equ 0x20 ;indico los registros que van a ocupar las variable
num_1 equ 0x21 
num_2 equ 0x23
num_3 equ 0x24 
num_4 equ 0x25
num_5 equ 0x26 
num_6 equ 0x27 
num_7 equ 0x28
num_8 equ 0x29
num_9 equ 0x2A


cero	equ 0x2B
flag equ 0x2C 
 
;********** macro **************************************************************
resta MACRO numero  ;el argumento va ser una literal en hexadecimal
 movlw	numero  ;carga el numero a w
 subwf	PORTA, 0   ;realizar la resta para la comparacion (numero - input)
endm
 
out_put MACRO numero ; el numero hace referencia a las variables num_x
 movf	numero,0    ;carga el numero a W
 movwf	PORTB	    ;carga salida a PORTB
 incf	flag,1
endm

;************** inicio de codigo *********************************************** 
PSECT main, class=code, delta=2,abs
 
  bsf       STATUS, 5	    ; Cambia a banco 1 para configuración de registros
  bcf       STATUS, 6
  movlw     0b11111111	    ; Carga valor a w (todos entradas)
  movwf     TRISA           ; Puerto A como entradas
  movlw     0b00000000      ; Carga valor a w
  movwf     TRISB           ; Puerto B como salida solo 5 bits
  bcf       STATUS, 5       ; Cambia a banco 0 para operación normal de los port 
  movlw	    0x07	    ; 
  movwf	    CMCON	    ; habilita all pines (desabilita comparadores)
  
;************* inicializacion de variables *************************************
    movlw 0b00111111  ; Número 0
    movwf num_0

    movlw 0b00000110  ; Número 1
    movwf num_1

    movlw 0b01011011  ; Número 2
    movwf num_2

    movlw 0b01001111  ; Número 3
    movwf num_3

    movlw 0b01100110  ; Número 4
    movwf num_4

    movlw 0b01101101  ; Número 5
    movwf num_5

    movlw 0b01111101  ; Número 6
    movwf num_6

    movlw 0b00000111  ; Número 7
    movwf num_7

    movlw 0b01111111  ; Número 8
    movwf num_8

    movlw 0b01101111  ; Número 9
    movwf num_9
    
    movlw 0b00000000
    movwf cero
    
   

;************* bucle mian ******************************************************    
main:
    
    movlw 0x00
    movwf flag
    
    resta 0x00               ; Realizar la resta
    btfss   STATUS, 2         ; Si Z = 1 (resultado cero), salta a skip_0
    goto    skip_0            ; Salta todo el bloque de out_put si el resultado fue cero
    out_put num_0             ; Si no fue cero, ejecuta out_put
skip_0:                       ; Etiqueta de salto
    
    resta 0x01
    btfss   STATUS, 2
    goto    skip_1
    out_put num_1
skip_1:
    
    resta 0x02
    btfss   STATUS, 2
    goto    skip_2
    out_put num_2
skip_2:
    
    resta 0x03
    btfss   STATUS, 2
    goto    skip_3
    out_put num_3
skip_3:
    
    resta 0x04
    btfss   STATUS, 2
    goto    skip_4
    out_put num_4
skip_4:
    
    resta 0x05
    btfss   STATUS, 2
    goto    skip_5
    out_put num_5
skip_5:
    
    resta 0x06
    btfss   STATUS, 2
    goto    skip_6
    out_put num_6
skip_6:
    
    resta 0x07
    btfss   STATUS, 2
    goto    skip_7
    out_put num_7
skip_7:
    
    resta 0x08
    btfss   STATUS, 2
    goto    skip_8
    out_put num_8
skip_8:
    
    resta 0x09
    btfss   STATUS, 2
    goto    skip_9
    out_put num_9
skip_9:
    
    btfsc   flag, 0
    goto    skip
    out_put cero
skip:
    
goto main

    
END