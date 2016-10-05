;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 3
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================

.orig x3000
;-------------
;Instuctions
;-------------
	LD	R1,DATAPTR	;load the mem addr of beginning of arr to R1
	LD	R2,COUNTER	;load numerical counter to R2
LOOP
	GETC			;read character into R0
	OUT
	STR	R0,R1,#0	;store it in memory location via value of R1
	ADD	R1,R1,#1	;increment the memory location to the next 
	ADD	R2,R2,#-1	;decrease the counter/#leftover arr entries
	BRp	LOOP		;enter in another char if leftover entries exst

HALT

;---------------
;Data/psuedo-ops
;---------------
	DATAPTR	.FILL	ARRAY	;ptr to beginning of ARRAY
	ARRAY	.BLKW	#10	;allocate 10 consec memory locations for ARRAY
	COUNTER	.FILL	#10	;counter to traverse the array size

.end
