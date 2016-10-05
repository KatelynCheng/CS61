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
	LDI	R3,DEC_65_PTR		
	LDI	R4,HEX_41_PTR	;take value found at mem location DEC_65_PTR
	ADD	R3,R3,#1	;and use that value as a memory addr. Go to tht
	ADD 	R4,R4,#1	; memory addr & take the value stored there, 
				; and load that value into R3 register	
	STI	R3,DEC_65_PTR	; store the value in R3 at the memory loc speci
	STI	R4,HEX_41_PTR	; by the value in mem loc DEC_65_PTR
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
