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
;main
	LD	R7,SUB_PRINT_OPCODES
	JSRR	R7
	HALT	

;main data
	SUB_PRINT_OPCODES	.FILL	x4000

.orig x4000
	ST	R7,R7_storage
;-------------------------------------------------------------------------
; Subroutine: SUB_PRINT_OPCODES
; Parameters: None
; Postcondition: The subroutine has printed out a list of every LC3 instruction
; and corresponding opcode in the following format:
; ADD = 0001
; AND = 0101
; BR = 0000
; …
; Return Value: None
;-------------------------------------------------------------------------
	LD	R6,counter		;load counter 16 into R6
	LD	R5,stringvals		;load pointer to stringvals to R5
	LD	R4,numvals		;load pointer to numvals to R5
	AND	R3,R3,#0
LOOP
	;begin printing the string
	LDR	R0,R5,#0
	OUT		
	ADD	R5,R5,#1
	ADD	R0,R0,#0
	BRnp	LOOP
	
	LEA	R0,equals
	PUTS
	
	LDR	R1,R4,#0	
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1

	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	ADD	R1,R1,R1
	
	AND	R2,R2,#0
	ADD	R2,R2,#4
	
PRINT_BINARY
	ADD	R1,R1,#0
	BRzp	PRINT_ZERO
	ADD	R1,R1,#0
	BRn	PRINT_1
POST_PRINT_CHAR
	ADD	R1,R1,R1
	ADD	R2,R2,#-1
	BRp	PRINT_BINARY
	LD	R0,newline
	OUT
	ADD	R6,R6,#-1
	BRz	END
	ADD	R4,R4,#1
	BRnzp	LOOP
	
PRINT_ZERO
	LD	R0,ASCII_ZERO
	OUT
	BRnzp	POST_PRINT_CHAR
PRINT_1	
	LD	R0,ASCII_ZERO
	ADD	R0,R0,#1
	OUT
	BRnzp	POST_PRINT_CHAR

END
	LD	R7,R7_storage
	RET
;subroutine data
	stringvals	.FILL		x5000
	numvals		.fill		x6000
	R7_storage	.FILL		x0
	equals		.stringz	" = "
	newline		.FILL		#10
	counter		.FILL		#18
	ASCII_ZERO	.FILL		#48
.orig x5000
	;will contain string values
		PRINT_BR	.STRINGZ	"BR"
		PRINT_ADD	.STRINGZ	"ADD"
		PRINT_LD	.STRINGZ	"LD"
		PRINT_ST	.STRINGZ        "ST"
		PRINT_JSR	.STRINGZ        "JSR"
		PRINT_JSRR	.STRINGZ        "JSRR"
		PRINT_AND	.STRINGZ        "AND"
		PRINT_LDR	.STRINGZ        "LDR"
		PRINT_STR	.STRINGZ        "STR"
		PRINT_RTI	.STRINGZ        "RTI"
		PRINT_NOT	.STRINGZ        "NOT"
		PRINT_LDI	.STRINGZ        "LDI"
		PRINT_STI	.STRINGZ        "STI"
		PRINT_RET	.STRINGZ        "RET"
		PRINT_JMP	.STRINGZ        "JMP"
		PRINT_RES	.STRINGZ        "reserved"
		PRINT_LEA	.STRINGZ        "LEA"
		PRINT_TRAP	.STRINGZ        "TRAP"
	
.orig x6000
	;will contain decimal values
		BR_num  .FILL	#0
		ADD_num	.FILL   #1
		LD_num	.FILL   #2
		ST_num	.FILL   #3
		JSR_num	.FILL   #4
		JSRR_no	.FILL   #4
		AND_num	.FILL   #5
		LDR_num	.FILL   #6
		STR_num	.FILL   #7
		RTI_num .FILL   #-8
		NOT_num	.FILL   #-7
		LDI_num .FILL   #-6
		STI_num	.FILL   #-5
		RET_num .FILL   #-4
		JMP_num .FILL   #-4
		res_num	.FILL   #-3
		LEA_num .FILL   #-2
		TRA_num	.FILL   #-1
.end

