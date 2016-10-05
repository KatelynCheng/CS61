;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 2
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================

;sometimes have data stored located in remote region of memory without memory
;aliases. 

.orig x3000

;-----------instructions-------------
; having LD R3,NEW_DEC_65 and LD R4, NEW_HEX_41 causes an overflow 
; this is because the DIRECT MEMORY ADDRESSING MODE (LD and ST isns) 
; only work with labels within +/-256 memory locations of the isns
	LD	R5,DEC_65_PTR	;values at DEC_65_PTR (which are memory addrs)
	LD	R6,HEX_41_PTR	; are loaded into the R5 register
	LDR	R3,R5,#0	;take the values in R5 and R6. use them as mem 
	LDR	R4,R6,#0	;addrs. go to those addrs and take the vals in
				;them and put them in R3 and R4
	ADD 	R3,R3,#1	;values in R3,R4 are incremented
	ADD	R4,R4,#1
	STR	R3,R5,#0	; value 
	STR	R4,R6,#0
	HALT


;----------data stores---------------
	
	DEC_65_PTR	.FILL	x4000
	HEX_41_PTR	.FILL	x4001

;you can load the data into the new locations via this code
	; remote data
	.orig x4000
	NEW_DEC_65	.FILL	#65
	NEW_HEX_41	.FILL	x41


.end	
