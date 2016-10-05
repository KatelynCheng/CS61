;=================================================
; Name: Theodore Nguyen	
; Email: tnguy223@ucr.edu
; 
; Lab: lab 6
; Lab section: 1
; TA: Gaurav Jhaveri
; 
;=================================================

.orig x3000
;MAIN CODE BLOCK INSNs
	LEA	R0,req_input
	PUTS
	GETC
	OUT
	ADD	R1,R0,#0
	LD	R0,NEWLINE
	OUT
	LD	R6,count_1s_addr
	JSRR	R6
	
	LEA	R0,num_of_ones
	PUTS
	ADD	R0,R2,#0
	LD	R3,toASCII
	ADD	R0,R0,R3
	OUT
	LD	R0,NEWLINE
	OUT
	
	HALT
;MAIN CODE BLOCK DATA
	req_input	.STRINGZ	"Please enter a character: "
	NEWLINE		.FILL		#10
	count_1s_addr	.FILL		x4000
	num_of_ones	.STRINGZ	"The number of 1's in the char is: "
	toASCII		.FILL		#48
.orig x4000
;Subroutine:count 1's. Pass the character to count 1's in the R1 register. 
; the rolling counter of 1's in the character will be in the R2 register
; the 16 bit counter will be in R3 register	
	ST	R7,R7_save	;save return register
	AND	R2,R2,#0	;set initial number of 1's as 0
	LD	R3,bits_16	;counter to do parse the 16 bits 
LOOP
	ADD	R1,R1,#0	;make sure R1 is last used
	BRn	NEGATIVE	;branch negative
POST_CHECK
	ADD	R1,R1,R1	;shift bits left
	ADD	R3,R3,#-1	;decrement number of bits to check leftover
	BRz	DONE_COUNT	;if no more bits to check, done counting 1's
	BRnp	LOOP		;if more bits to check(ORSOMEHOW NEGATIVE),loop
NEGATIVE
	ADD	R2,R2,#1	;increase number of 1's 
	BRnzp	POST_CHECK

DONE_COUNT
	
	LD	R7,R7_save
	RET
;subroutine data block
	R7_save		.FILL		x0
	bits_16		.FILL		#16
.end
