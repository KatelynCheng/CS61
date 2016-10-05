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
	;--------------
	; Instructions
	;--------------
	; load values from the DEC_0,12,6 addresses into registers 1,2,3
	LD R1, DEC_0	; starts at zero ~ will be incremented in each loop
	LD R2, DEC_12	; this is the preloaded value we want to add each time/multiply by
	LD R3, DEC_6	; this is the fixed number we multiply by - aka number of iterations

	
	LOOP
		ADD R1,R1,R2	; adds the value of R1 and R2 and stores it inside R1
		ADD R3,R3,#-1	; decrements R3 by 1 and stores it in R3
		BRp LOOP	; checks latter value (R3) is positive. if so, jump to LOOP
				; otherwise, keep going and run into HALT
	HALT

	;------------
	; Local Data
	;------------
	; define these memory locations with these values
	DEC_0 	.FILL	#0
	DEC_12	.FILL	#12
	DEC_6	.FILL	#6


.end
