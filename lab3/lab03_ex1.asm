;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 3
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
	LD	R5,DATA_PTR	;values at DEC_65_PTR (which are memory addrs)
	
	;LD	R6,DATA_PTR+1	; are loaded into the R5 register
	;note that trying to do DATA_PTR+1 does not work, it will take the 
	;location of DATA_PTR, which in this case is x3009, add 1, get x300A,
	;use this location to get a memory address, and load the value stored
	;at this memory address. this mem address is uninitialized, so we load
	; a random value.	

	ADD 	R6,R5,#1	;R5 has mem addr of arr start. then, val(R5)+1
				;is mem addr of second element of arr
	
	LDR	R3,R5,#0	;take the values in R5 and R6. use them as mem 
	LDR	R4,R6,#0	;addrs. go to those addrs and take the vals in
				;them and put them in R3 and R4
	ADD 	R3,R3,#1	;values in R3,R4 are incremented
	ADD	R4,R4,#1
	STR	R3,R5,#0	;take the values inside R5,R6, use as mem addrs
	STR	R4,R6,#0	;go to those mem addrs, store R3,R4 in them
	HALT


;----------data stores---------------
	
	DATA_PTR	.FILL	x4000	;we now use ONE ptr in local data block
					;to access both (an array) of info at 
					; memory location x4000

;you can load the data into the new locations via this code
	; remote data
	.orig x4000
	NEW_DEC_65	.FILL	#65
	NEW_HEX_41	.FILL	x41


.end	
