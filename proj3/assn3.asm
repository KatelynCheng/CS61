;=================================================
; Name: Theodore Nguyen
; Email: tnguy223@ucr.edu
; 
; Assignment name: Assignment 3
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
LD R6, Convert_addr		; R6 <-- Address pointer for Convert
LDR R1, R6, #0			; R1 <-- VARIABLE Convert 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
LD	R5,ASCII		;load value we use to convert to ASCII
LD	R2,bit_counter		;load the counter to traverse bits

LOOP	
	ADD	R1,R1,#0	;verify R1 is last used register
	BRn	NEGATIVE	;if leading bit is 1, go to neg to print 1
	ADD	R1,R1,#0	;verify R1 is last used register
	BRzp	POSITIVE	;if leading bit is 0, go to pos to print 0
SPACES
	ADD	R1,R1,R1	;shift bits left
	ADD	R2,R2,#-1	;decrement bit counter

	ADD	R3,R2,#0	;copy current counter to R3
	LD	R4,space1	;load first space threshold into R4
	ADD	R3,R3,R4	;check if current counter = first space threshold
	BRz	PRINT_SPACE	;if current ctr = 1st space threshold, print a space
	
	ADD	R3,R2,#0	;recopy current ctr to R3
	LD	R4,space2	;load second space threshold into R4
	ADD	R3,R3,R4	;check if current counter = 2nd space threshold
	BRz	PRINT_SPACE	;if current ctr = 2nd space threshold, print space

	ADD	R3,R2,#0	;recopy current ctr to R3
	LD	R4,space3	;load third space threshold into R4
	ADD	R3,R3,R4	;check if current counter = 3rd space threshold
	BRz	PRINT_SPACE	;if current ctr = 3rd space threshold, print space

POST_SPACE
	ADD	R2,R2,#0	;make the current ctr be last used register
	BRp	LOOP		;if we havent finished parsing, goto next iteration
	ADD	R2,R2,#0	;make current ctr be last used again
	BRnz	END		;if finished parsing (counter is 0) jump to end
				;(also if it is SOMEHOW negative (idk how) jmp to end too

	BRnzp	END		;jump to the end... just because. 
	

NEGATIVE
	AND	R0,R0,#0	;set R0 to 0 
	ADD	R0,R0,#1	;set R0 to 1
	ADD	R0,R0,R5	;convert 1 to '1'
	OUT			;print 1
	BRnzp	SPACES		;jump back to section our bit-parsing loop

POSITIVE
	AND	R0,R0,#0	;set R0 to 0
	ADD	R0,R0,R5	;convert 0 to '0'
	OUT			;print 0
	BRnzp	SPACES		;jump back to section our bit-parsing loop

PRINT_SPACE
	LD	R0,space_char	;load space char into R0
	OUT			;print space char
	BRnzp	POST_SPACE	;jump back to loop after space determination

END
	LD	R0,NEWLINE	;load newline to R0
	OUT			;print newline
	HALT
;---------------	
;Data
;---------------
Convert_addr .FILL xB000	; The address of where to find the data
bit_counter  .FILL #16
ASCII	     .FILL #48
NEWLINE	     .FILL #10
space1	     .FILL #-12
space2	     .FILL #-8
space3	     .FILL #-4
space_char   .FILL #32

.ORIG xB000			; Remote data
Convert .FILL xABCD		; <----!!!NUMBER TO BE CONVERTED TO BINARY!!!
;---------------	
;END of PROGRAM
;---------------	
.END
