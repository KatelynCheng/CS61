;=================================================
; Name: Theodore Nguyen
; Email:  tnguy223@ucr.edu
; 
; Lab: lab 8
; Lab section: 1
; TA: Gaurav Jhaveri 
; 
;=================================================

.orig x3000
;main routine
	LD	R0,STR_ADDR		;load adress to store string at
	LD	R7,SUB_TO_UPPER		;load addr of subroutine
	JSRR	R7			;jump to subroutine

	HALT	

;main routine data
	STR_ADDR	.FILL	x5000	;address of string
	SUB_TO_UPPER	.FILL	x4000	;address of subroutine


.orig x4000
	ST	R7,R7_storage		;store the return address
;----------------------------------------------------------------------------
; Subroutine: SUB_TO_UPPER
; Parameter (R0): Address to store a string at
; Postcondition: The subroutine has allowed the user to input a string,
; terminated by the [ENTER] key, has converted the string
; to upper-case, and has stored it in a null-terminated array that
; starts at (R0).
; Return Value: R0 ← The address of the now upper case string.
;-------------------------------------------------------------------------
	ADD	R6,R0,#0		;move the string addr to R6
	LEA	R0,prompt		;output the prompt to user
	PUTS
	
LOOP
	GETC				;take input and out it char by car
	OUT
	;check if char is a newline
	ADD	R1,R0,#0		;copy inputted char to R1
	ADD	R1,R1,#-10		;subtract -10; if zero, then newline
	BRz	END			;if newline, end beginning
	;check if char is in range a-z lowercase
	;check if < a
	ADD	R1,R0,#0		;copy inputted char to R1
	LD	R2,NINETY_SEVEN		;load -97 into R2
	ADD	R1,R1,R2		;add loaded value with -97
	BRn	POST_CHECK_ALPHA	;if (-), ascii < 97 == < a == not lowralp
	;check if > z
	ADD	R1,R0,#0		;copy inputted char to R1
	LD	R2,ONE_TWO_TWO		;load -122 into R2
	ADD	R1,R1,R2		;add loaded value with -122
	BRp	POST_CHECK_ALPHA	;if (+), ascii > 122 == > z == not lowrap
	;if here, then value is lowercase alpha char. need to convert to upper
	LD	R2,MINUS_32		;load -32 to R2
	ADD	R0,R0,R2		;convert to upper
POST_CHECK_ALPHA
	STR	R0,R6,#0		;store value in R0 to memory loc in R6
	ADD	R6,R6,#1		;increment data pointer
	BRnzp	LOOP			;ask for next input
	
END	;at the end, put a newline in the end of string and exit
	AND	R0,R0,#0		;set R0 to 0
	STR	R0,R6,#0		;store value in R0 at mem address in R6
	LD	R7,R7_storage		;reload the return address
	RET
;subroutine data
	R7_storage	.FILL	x0
	prompt		.STRINGZ	"Enter any string, terminated by ENTER:\n"
	NINETY_SEVEN	.FILL	#-97
	ONE_TWO_TWO	.FILL	#-122	
	MINUS_32	.FILL	#-32
.end
