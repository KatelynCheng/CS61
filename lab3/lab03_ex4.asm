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
	LD	R1,DATAPTR	;load what dataptr has - location of beg of arr
LOOP
	GETC			;read in a char into R0
	OUT
	STR	R0,R1,#0	; store the char in R0 to mem loc spec. by R1
	ADD	R1,R1,#1	;incrememnt arr ptr by 1 to next loc
	ADD	R0,R0,#-10	;look @ inputted char, check if carriage return
	BRnp	LOOP		;if it is NOT \cr, DONT enter a new char

	LD	R1,DATAPTR	; load mem location of beginning of array
LOOP2
	LDR	R0,R1,#0	;load element at memory loc spec by R1 into R0
	OUT			;print it 
	ADD	R2,R0,#0	; move that loaded element to R2
	LD	R0,NEWLINE	; load newline into R0
	OUT			;print a newline
	ADD	R1,R1,#1	; increment the array ptr to next element
	ADD	R2,R2,#-10	;check if printed char is newline
	BRnp	LOOP2		;if it is not, print next char

HALT

;---------------
;Data/psuedo-ops
;---------------
	NEWLINE	.FILL	x0A	;store newline char
	DATAPTR	.FILL	x4000	;store mem location of beginning of arr

.end
