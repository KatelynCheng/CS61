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

;exercise 3: store first 10 powers of 2 into the array instead of 0 to 9, starting with; 2^0 = 1. Grab the 7th value which is 2^6 and store it into R2

.orig x3000

;-------------
;Instructions
;-------------

	LD 	R1,VALUE_TO_ENTER	;loads the counter to store to the R1 Register
	LD	R2,DATA_PTR		;loads mem location of begin array into R2 reg
	LD	R5,max			;stores maximum value for looping ending
LOOP
	STR	R1,R2,#0		; stores the n-1th value into the nth entry
	ADD	R2,R2,#1		; increments the pointer to point to the next
	ADD	R1,R1,R1		; increment the value via bit-shift 
	ADD	R3,R1,R5		; check if the next value store is 2^9=512
	BRnp	LOOP			; if it isnt, do next iteration

	LD	R4,DATA_PTR		; reload the mem location of array into R4
	ADD	R4,R4,#6		; incremen the 7th element (since it originally
						;points to the 1st element
	LDR	R2,R4,#0		; load the 7th element into the R2 register
					;should be 2^6 = 64
HALT
;------------
;data
;------------
	VALUE_TO_ENTER	.FILL	x1	;hard code 2^0 = 1 = 0000 0000 0000 0001
	DATA_PTR	.FILL	ARRAY	;label for memory location of array
	max		.FILL	#-1024	;what is 2^10? this. 
	
.orig x4000
	ARRAY	.BLKW	#10		;initialize empty array

.end
