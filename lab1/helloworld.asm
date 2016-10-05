;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 1
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================

.orig x3000

	;---------------------
	; Instructions
	;---------------------
	lea	R0, msg		;load memory location of the label "msg" into IO register R0
	puts			;prints string at memory address thts inside R0 until '\0' 
	halt 			;terminate program

	;--------------------
	; Local data
	;--------------------
	msg   .stringz   "Hello world!\n" 	;put valued string into memory addr labled msg

.end
