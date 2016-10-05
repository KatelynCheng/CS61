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
	HALT
;main data
	DATA_PTR	.fill		x5000
	subrout		.fill		x4000


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

.end
