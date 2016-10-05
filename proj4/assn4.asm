;=================================================
; Name: Theodore Nguyen
; Email: tnguy223@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 1
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team.
;
;=================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------

;-------------------------------
;INSERT CODE STARTING FROM HERE 
;--------------------------------
BEGINNING
	;Example of how to Output Intro Message
	LD R0, introMessage  ;Output Intro Message
	PUTS

	;Example of how to Output Error Message
	;LD R0, errorMessage  ;Output Error Message
	;PUTS
;R0:input;R1:working register;R3:use symbol?;R4:what sign?;R5:actual value;R6:counter;R7:work
	LD	R6,input_counter	;can input max 6 chars	PARSING COUNTER
	AND	R5,R5,#0		;clear R5.		ROLLING SUM
	AND	R4,R4,#0		;clear R4.		SIGN BIT. DEFAULT 0=pos,1=neg
	AND	R3,R3,#0		;clear R3.		SYMBOL BIT.0=no,1=yes
	
LOOP			;Main loop
	GETC			;input a char to R0 and echo it	
	ADD	R1,R0,#0
	LD	R7,NEWLINE
	ADD	R1,R1,R7
	BRnp	OUTPUT_CHAR
POST_OUT
	;if this is less than 48
	ADD	R1,R0,#0	;copy inputted char to R1
	LD	R7,MINUS_48	;load -48 to check against inputted value
	ADD	R1,R1,R7	; R1 <- inputted char - 48
	BRn	LESS_48		;if inputted char is negative, then it is less than 48 (0)
	
	;if this is greater than 57
	ADD	R1,R0,#0	;copy inputted char to R1
	LD	R7,MINUS_57	;load -57 to check against inputted value
	ADD	R1,R1,R7	;R1 <- inputted char - 57
	BRp	GREATER_57	;if inputted char is positive, then it is > than 57 (9)

;we have deduced inputted char x satisfies 48 < x < 57. 
	
	;if this is the first character
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRz	FIRST_CHAR	;react slightly differently if this 1st char is digit
	;if this is not the first char, react normally. First multiply R5 by 10
	ADD	R5,R5,R5	; 2x = x + x
	ADD	R7,R5,R5	; 4x = 2x + 2x
	ADD	R7,R7,R7	; 8x = 4x + 4x
	ADD	R5,R5,R7	; 10x = 2x + 8x
	;then add the inputted char to R5
	LD	R7,MINUS_48	;load conv to dec from ASCII for digits
	ADD	R0,R0,R7	;convert to decimal for inputted char
	ADD	R5,R5,R0	;finally, add decimal inputted char to 10*previous sum.
	;decrement counter and branch accordingly
	ADD	R6,R6,#-1	;decrement counter
	BRp	LOOP		;if we can input more, go back to beginning of loop
	BRz	END		;if no more input chars, go to end. if this counter is less
					;than zero somehow, we know we have a problem

OUTPUT_CHAR
	OUT
	BRnzp	POST_OUT

OUTPUT_ERROR_NEWLINE
	LD	R0,NEWLINE_char
	OUT
	BRnzp	GREATER

NEGATIVE
	;perform two's complement and be done with it
	NOT	R5,R5		;flip bits of R5
	ADD	R5,R5,#1	;add 1 to R5 to get the negative value
	BRnzp	REALLY_THE_END

FIRST_CHAR
	;the first char inputted was a digit! react accordingly.
		;this is the first char, so R5 is zero. just need to add inputted char to R5
			;and decrement the counter by 2 instead of 1.We don't need to multi
			;R5 because this is the first char and R5 SHOULD be 0.
	LD	R7,MINUS_48	;load conv from ASCII to DEC
	ADD	R0,R0,R7	;convert inputted char to decimal from ascii
	ADD	R5,R0,R5	;perform R5 <-- inputted dec val + R5. (R5 is 0 initially)
	ADD	R6,R6,#-2	;decrease counter by TWO since we don't use a sign bit. 
	BRnzp	LOOP

IS_NEWLINE
	;if this is a newline, check if it is the first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRz	GREATER_57	;if 0, then 1st char = newline. ERROR.
	;if this is a newline, now check if it is the second char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-5	;subtract 5 from current counter
	BRnp	END		;if the result is nonzero, then isnt second char. go to end.
;if we are here, then the newline was the second char. check if symbol flag is 1
	ADD	R1,R3,#0	;copy symbol flag to R1
	ADD	R1,R1,#-1	;subtract 1
	BRz	OUTPUT_ERROR_NEWLINE ;if the result is 0, then the symbol flag was 1. This means
					;that 1st char = sign, 2nd char = newline. ERROR.
;if we are here, then newline was 2nd char and the first char was NOT a sign symbol.
	BRnp	END		;then we go to the end. R5 should be 1 digit dec number.

IS_PLUS
	;if this is a plus, check if it the first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRnp	GREATER_57	;if result!=0, then isnt first char. error. 
	;at this point, if we are here, then symbol is a + AND it IS the first char.
	ADD	R4,R4,#0	;we are supposed to set R4 to 0 - but it should ALREADY be 0.
	ADD	R3,R3,#1	;set flag for sign symbol use = 1. 
	ADD	R6,R6,#-1	;decrease counter by 1
	BRnzp	LOOP		;go to next iteration

IS_MINUS
	;if this is a minus, check if it is first char
	ADD	R1,R6,#0	;copy current counter to R1
	ADD	R1,R1,#-6	;subtract 6 from current counter
	BRnp	GREATER_57	;if result!=0, then isnt first char. Error.
	;at this point, if we are here, then the symbol is a - AND it is the first char.
	ADD	R4,R4,#1	;set R4 to 1 as value entered is to be negative.
	ADD	R3,R3,#1	;set R3 to 1 as the sign symbol has been used
	ADD	R6,R6,#-1	;decrease counter by 1
	BRnzp	LOOP		;go to next iteration

LESS_48
	;check if this is a plus symbol first.
	LD	R7,PLUS		;load plus ascii value 
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_PLUS		;has to be zero if is plus symbol. do stuff
	
	;check if this is a minus symbol next
	LD	R7,MINUS	;load minus ascii value
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_MINUS	;has to be zero if is minus symbol. do stuff

	;check if this a newline symbol next
	LD	R7,NEWLINE	;load newline ascii value
	ADD	R1,R0,#0	;copy inputted value to R1
	ADD	R1,R1,R7	;add two values
	BRz	IS_NEWLINE	;has to be zero if is newline symbol. do stuff.
;if char is < 48, is not +, is not -, is not \n, then this is an error. 

GREATER_57	;if inputted char > 57, this is ALWAYS going to be an error.
	ADD	R1,R0,#0
	ADD	R1,R1,#-10
	BRnp	OUTPUT_ERROR_NEWLINE
GREATER	
	LD	R0,errorMessage	;print error message
	PUTS
	BRnzp	BEGINNING	;go to the beginning because f'd up

END
	;just need to check sign bit and perform two's complement (or not) now.
	ADD	R1,R4,#0	;copy current sign bit to R1
	ADD	R1,R1,#-1	;subtract -1 from sign bit
	BRz	NEGATIVE	;is negative if sign bit was 1. (aka if new value is 0).
REALLY_THE_END
	LD	R0,NEWLINE_char	;load newline
	OUT			;print newline

HALT				;finished
;---------------	
;Data
;---------------
NEWLINE		.FILL	#-10
MINUS		.FILL	#-45
PLUS		.FILL	#-43
NEWLINE_char	.FILL	#10
MINUS_57	.FILL	#-57
MINUS_48	.FILL	#-48
input_counter	.FILL	#6
introMessage 	.FILL 	x6000
errorMessage 	.FILL 	x6100

;------------
;Remote data
;------------
.ORIG x6000
;---------------
;messages
;---------------
intro .STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
;---------------
;error_messages
;---------------
.ORIG x6100	
error_mes .STRINGZ	"ERROR INVALID INPUT\n"


;---------------
;END of PROGRAM
;---------------
.END
;-------------------
;PURPOSE of PROGRAM
;-------------------
