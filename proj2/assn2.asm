;=================================================
; Name: Theodore Nguyen
; Email: tnguy223@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;outputs prompt
;----------------------------------------------	
beginning	;label the start of isns: for debugging purposes
	LEA R0, intro		; loads memory address of output string to R0	
	PUTS			; Invokes BIOS routine to output string
	
	; input load and print first character
	GETC			; takes input of first character into R0 
	OUT			; takes value in R0, convert to ascii, displays
	ADD R1,R0,#0		; moves 1st inputted character to R1
	LEA R0, NEWLINE		; newline
	PUTS
	
	; input load and print second character
	GETC			; takes input of second character into R0
	OUT			; prints that second entered character
	ADD R2,R0,#0		; stores this character in R2
	LEA R0, NEWLINE		; new line
	PUTS	
	
	; prints the expression without difference "num1 - num2 = "
	ADD R0,R1,#0		; put first char in R0 and print
	OUT
	LEA R0,MINUS		; put minus sign string into R0 and print
	PUTS
	ADD R0,R2,#0		; put second char in R0 and print
	OUT
	LEA R0,EQUALS		; put equals sign string into R0 and print
	PUTS

	; convert the ascii value to the numerical one for both inputs
	ADD R1,R1,#-12		; not gunna lie, i didn't know how to do this
	ADD R1,R1,#-12		;    elegantly, and this works so i left it as
	ADD R1,R1,#-12		;    it is
	ADD R1,R1,#-12
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	ADD R2,R2,#-12
	
	; convert R2 value to its negative value via two's complement
	NOT R2,R2		;2's complement step 1: flip bits R2
	ADD R2,R2,#1		;2's complement step 2: add 1 to R2
	ADD R3,R1,R2		;add R1 with the newly negative R2 to get diff
	ADD R3,R3,#0		;make sure R3 is last used register
	BRn negative 		;if negative, branch to 'negative'
	ADD R3,R3,#0		;use R3 as condiition again
	BRzp positive		;otherwise if nonnegative, branch to 'positive'
	negative 
		NOT R3,R3	; flip R3 bits
		ADD R3,R3,#1	; then add 1
		ADD R3,R3,#12	; convert back to ASCII character
		ADD R3,R3,#12
		ADD R3,R3,#12
		ADD R3,R3,#12
		LD R0,neg	; print the negative sign
		OUT
		ADD R0,R3,#0	; print the positive magnitude
		OUT
		BRzp ending
	positive 
		ADD R3,R3,#12	; convert back to ASCi character
		ADD R3,R3,#12
		ADD R3,R3,#12
		ADD R3,R3,#12
		ADD R0,R3,#0	; print the positive magnitude (b/c its pos)
		OUT
	ending	
		LEA R0,NEWLINE  ; newline for clarity & debug clarity
		PUTS		; same reasoning as latter
		;PUTS
		;ADD R0,R0,#0	; for debugging purposes
		;BRzp beginning	; for debugging purposes
		HALT				; Stop execution of program
;------	
;Data
;------
; String to explain what to input 
intro .STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 
NEWLINE .STRINGZ "\n"	; String that holds the newline character
MINUS .STRINGZ	" - " 
EQUALS	.STRINGZ " = "
neg	.FILL	#45
;---------------	
;END of PROGRAM
;---------------	
.END

