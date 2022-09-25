.data
	inputMessage: 	.asciiz "Nhap so phan tu cua mang: "
	outputMessage: 	.asciiz "Mang da nhap la: \n"
	printSpace:	.asciiz " "
	reInputMessage:	.asciiz "Nhap lai\n"
	endl:		.asciiz "\n"
	output1:	.asciiz "Khong co so le trong mang."
	output2:	.asciiz "Gia tri le nho nhat trong mang la: "
	Test:		.asciiz "Test"
	.align 2	
	myArray: .space 400
.text
.globl main
main:
	input:
		li $v0, 4
		la $a0,inputMessage				#Xu?t ra inputMessage	
		syscall
		
		li $v0, 5
		syscall						#Nhap so phan tu cua mang
		move  $t0, $v0
		
		bgt $t0, 100, reInput	                	#Neu so nhap vao >100 || <0 thi reInput   	
		ble $t0, 0, reInput
			
		li $t1, 0					#t1 dung de luu bien dem
		li $t2, 0 					#t2 dung de luu bien index
		li $t3, 101
		li $t4, 101
    		j inputLoop
	reInput:
		li $v0, 4
		la $a0, reInputMessage
		syscall
		
		j input
	inputLoop:
        	beq $t1, $t0, output   				#Dieu kien dung
		
        	li $v0, 5
        	syscall
        	sw $v0, myArray($t2)                            #Luu du lieu vao mang
        	
        	ble $v0, 0, inputElement
        	bgt $v0, 100, inputElement
        	
        	andi $t7, $v0, 1
        	beq $t7, $zero, nextInputLoop
        	bge $v0, $t3,  nextInputLoop
        	
        	j change
        change:
        	addi $t3, $v0, 0
        	
        	j nextInputLoop
        nextInputLoop:
        	addi $t1, $t1, 1				#Tang bien index len 4
        	addi $t2, $t2, 4				#Tang bien dem len 1
 
        	j inputLoop
        inputElement:
		li $v0, 4
		la $a0,reInputMessage
		syscall

		j inputLoop
	output:
		
		beq $t3, $t4, outputSmall
		
		li $v0, 4
		la $a0, output2
		syscall
		
		li $v0, 1
		move $a0, $t3
		syscall
		
		j exit
	outputSmall:
	
		li $v0, 4
		la $a0, output1
		syscall
		
		j exit
	exit:
		
        	
        	
        	
        	
		
		
		
