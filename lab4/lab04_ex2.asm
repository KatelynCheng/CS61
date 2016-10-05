;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223
; 
; Lab: lab 4
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================
;lab04_exercise 1: initialize a 10 element array, and then store values 0-9 into the 
; array via a hard coded initial 0 value. Grab the 7th value, which should be 6, and
; store it into R2.

;exercise 2: take ex1 and now output the characters corresponding to the numbers in
; the array.


.orig x3000

;-------------
;Instructions
;-------------

	LD 	R1,VALUE_TO_ENTER	;loads the counter to store to the R1 Register
	LD	R2,DATA_PTR		;loads mem location of begin array into R2 reg
LOOP
	STR	R1,R2,#0		; stores the n-1th value into the nth entry
	ADD	R2,R2,#1		; increments the pointer to point to the next
	ADD	R1,R1,#1		; increment the value to store for the next
	ADD	R3,R1,#-10		; check if the next value store is 10
	BRnp	LOOP			; if it isnt, do next iteration

	LD	R4,DATA_PTR		; reload the mem location of array into R4
	ADD	R4,R4,#6		; incremen the 7th element (since it originally
						;points to the 1st element
	LDR	R2,R4,#0		; load the 7th element into the R2 register
	
	;start ex2... where we just output the array? lol. trivial?-> output an array.
	LD	R1,DATA_PTR		
	LD	R4,asciiConv
OUTLOOP
	LDR	R0,R1,#0
	ADD	R3,R0,#0
	ADD	R0,R0,R4
	OUT
	ADD	R1,R1,#1
	ADD	R3,R3,#-9
	BRnp	OUTLOOP
	
	
HALT
;------------
;data
;------------
	VALUE_TO_ENTER	.FILL	#0	;hard code the 0th value to increment later
	DATA_PTR	.FILL	ARRAY	;label for memory location of array

	asciiConv	.FILL	#48	;used for quick ascii conversions

.orig x4000
	ARRAY	.BLKW	#10		;initialize empty array

.end
