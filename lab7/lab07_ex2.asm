;=================================================
; Name: Theodore Nguyen	
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 7
; Lab section: 1
; TA: Gaurav Jhaveri 
; 
;=================================================

.orig x3000
;main instructions
	LD	R0,DATA_PTR	;load the address to start storing str in R0
	LD	R7,subrout	;load mem location of subroutine
	JSRR	R7		;jump to subroutine
	
	;LD	R0,DATA_PTR
	;PUTS

	LD	R0,DATA_PTR	;load the address of the inputted str to R0
	;R5 already contains number of chars in string. do nothing
	LD	R7,subrout2	;load memory addr of SUB_IS_A_PALINDROME
	JSRR	R7		;jump to subroutine 2

	HALT
;main data
	DATA_PTR	.fill		x6000
	subrout		.fill		x4000
	subrout2	.FILL		x5000

.orig x4000
	ST	R7,R7_storage
;----------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING
; Parameter (R0): The address of where to start storing the string
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, and has stored it in an array
; that starts at (R0) and is NULL-terminated.
; Return Value: R5 The number of non-sentinel characters read from the user
;-----------------------------------------------------------------------------
	ADD	R6,R0,#0		;put addr where to store string into R6
	AND	R5,R5,#0		;clear R5 so we can store sentinel vals
	LEA	R0,user_prompt		;prompt user to enter a string
	PUTS				
LOOP	
	GETC				;take in a char and out it
	OUT
	ADD	R1,R0,#0		;copy inputted char to R1
	LD	R2,isNEWLINE		;load -10 into R2
	ADD	R1,R1,R2		;add inputted char in R1 with -10
	BRz	END_STRING		;if 0, then inputted char is enter
	STR	R0,R6,#0		;store char in R0 at mem addr in R6
	ADD	R5,R5,#1		;increment # of non-sentinel values
	ADD	R6,R6,#1		;increment data pointer
	BRnzp	LOOP			;jump to next iteration of loop

END_STRING	;ENTER was entered; R1 <- input; R1 <- R1 - 10 = 0; R1 = 0.
	AND	R1,R1,#0		;set R1 to 0, which is nullbyte	
	STR	R1,R6,#0		;store nullbyte at mem addr in R6
	;ADD	R6,R6,#1		;point to after the nullbyte
	;STR	R1,R6,#10		;store newlin after tthe nullbyte
	
	AND	R0,R0,#0
	AND	R1,R1,#0
	AND	R2,R2,#0
	AND	R3,R3,#0
	AND	R4,R4,#0
	AND	R6,R6,#0
	LD	R7,R7_storage
	RET

;subroutine data
	R7_storage	.FILL		x0
	user_prompt	.STRINGZ	"Enter any string followed by ENTER:\n"
	isNEWLINE	.FILL		#-10


.orig x5000
	ST	R7,R7_storage2
;-----------------------------------------------------------------------------
; Subroutine: SUB_IS_A_PALINDROME
; Parameter (R0): The address of a string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R0) is
; a palindrome or not returned a flag indicating such.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;----------------------------------------------------------------------------
	AND	R4,R4,#0	;R4 <- 0	
	ADD	R4,R4,#1	;R4 <-1. Default say is palindrome.	

	ADD	R6,R0,#0	;copy starting address of string into R6 
	ADD	R6,R6,R5	;have R6 point to the nullbyte after the string
	ADD	R6,R6,#-1	;have R6 point to the last char in string
LOOP2	
	NOT	R7,R0		;invert addr of left side array char
	ADD	R7,R7,#1	;add 1 to get 1's comp of left side arr char
	ADD	R7,R6,R7	;R7<-right addr - left addr
	BRn	DONE		;if negative then right < left. 0 if same addr	

	LDR	R1,R0,#0	;load the left side of the array char to R1
	LDR	R2,R6,#0	;load the right side of the array char to R2
	NOT	R2,R2		;invert bits of right side of array char
	ADD	R2,R2,#1	;add 1 to right-side array char to get 2's comp
	ADD	R3,R1,R2	;R3<- left side array char - rightside arr char
	BRnp	NOTPALINDROME	;if result nonzero, the corres chars not same
	
	ADD	R0,R0,#1	;increment left addr
	ADD	R6,R6,#-1	;increment right addr
	BRnzp	LOOP2		;continue

DONE				;if is palendrome its already 1 so we good
	LD	R7,R7_storage2	
	RET

NOTPALINDROME
	ADD	R4,R4,#-1	;set R4 to 0 if palindrome
	BRnzp	DONE
;subroutine data
	R7_storage2	.FILL	x0
.end
