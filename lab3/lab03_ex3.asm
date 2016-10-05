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
	LD	R1,DATAPTR	;entire first part up to before LOOP2 is same
	LD	R2,COUNTER	;as in lab03_ex1.asm
LOOP
	GETC
	OUT
	STR	R0,R1,#0
	ADD	R1,R1,#1
	ADD	R2,R2,#-1
	BRp	LOOP

	LD	R1,DATAPTR	; load memory address of beginning of arr in R1
	LD	R2,COUNTER	; load arr size/counter into R2
LOOP2
	LDR	R0,R1,#0	;load val at mem addr from R1 to R0
	OUT			;print loaded value
	LD	R0,NEWLINE	;load newline into R0
	OUT			;print newline
	ADD	R1,R1,#1	;go to next position in arr
	ADD	R2,R2,#-1	;dec # leftover entries to print
	BRp	LOOP2		;load the next arr value if any leftover

HALT

;---------------
;Data/psuedo-ops
;---------------
	DATAPTR	.FILL	ARRAY	;put in mem location of beignning of arr
	ARRAY	.BLKW	#10	;allocation 10 consec entries for an arr
	COUNTER	.FILL	#10	;put in array size for traverseing counter
	NEWLINE	.FILL	x0A	; newline for printing
.end
