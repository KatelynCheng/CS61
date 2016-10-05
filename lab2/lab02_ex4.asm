;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 2
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================

.orig x3000

;-----------instructions-------------
	LD	R0,HEX_61
	LD	R1,HEX_1A
	
	THIS_LOOP
		OUT
		ADD	R0,R0,#1
		ADD	R1,R1,#-1
		BRp	THIS_LOOP	

	HALT


;----------data stores---------------
	
	HEX_61	.FILL	x61
	HEX_1A	.FILL	x1A

.end	
