.data
	inputMessage: 		.asciiz "Nhap so phan tu cua mang: "
	outputMessage: 		.asciiz "Mang da duoc sap xep la: \n"
	chooseTypeMassage:	.asciiz "1.Interchangesort\n2.BubbleSort\n3.InterchangeSort\nNhap loai sort:"
	printSpace:		.asciiz " "
	reInputMessage:		.asciiz "Nhap lai\n"
	endl:			.asciiz "\n"
	.align 2	
	myArray: .space 400
.text
.globl main
main:
	input:
		li $v0, 4
		la $a0,inputMessage				#Xuat ra inputMessage	
		syscall
		
		li $v0, 5
		syscall						#Nhap so phan tu cua mang
		
		move  $t0, $v0
		bgt $t0, 100,reInput	                	#Neu so nhap vao >100 || <0 thi reInput   	
		ble $t0, 0,reInput
		
		li $t1, 0					#t1 dung de luu bien dem
		li $t2, 0 					#t2 dung de luu bien index
    		j inputLoop
	reInput:
		li $v0, 4
		la $a0,reInputMessage				#Nhap lai
		syscall
		j input
	inputLoop:
        	beq $t1, $t0, choseType		   		#Dieu kien dung
        	li $v0, 5
        	syscall
        	
        	ble $v0, 0,inputElement
        	sw $v0, myArray($t2)                            #Luu du lieu vao mang
        	
        	addi $t1, $t1, 1				#Tang bien dem len 1
        	addi $t2, $t2, 4				#Tang bien index len 4
        	j inputLoop
        choseType:
        	li $v0, 4
        	la $a0, chooseTypeMassage
        	syscall
        	
        	li $v0, 5
        	syscall
        	move $t9, $v0
        	beq $t9, 1,interchangeSort
        	beq $t9, 2,bubbleSort
        	beq $t9, 3,gnomeSort
        	j exit
#####################################################################  	  	
        interchangeSort:
        	li $t1, 0
        	li $t2, 0
        	subi $t5, $t0, 1 
        	j interchangeLoop1
        interchangeLoop1:
        	beq $t1, $t5, output
        	move $t3, $t1
        	move $t4, $t2
        	addi $t3, $t3, 1
        	addi $t4, $t4, 4
        	j interchangeLoop2
        	interchangeLoop2:
        		beq $t3, $t0 ,endInterchangeLoop2
        		lw $t6, myArray($t2)
        		lw $t7, myArray($t4)
        		bge $t7, $t6, interchangeElse
        		interchangeSwap:
        			sw $t6, myArray($t4)
        			sw $t7, myArray($t2)
        			j interchangeElse
        		interchangeElse:
        			addi $t3, $t3, 1
        			addi $t4, $t4, 4
        			j interchangeLoop2
        	endInterchangeLoop2:
        		addi $t1, $t1, 1
        		addi $t2, $t2, 4
        	j interchangeLoop1
#####################################################################
	bubbleSort:
		subi $t1, $t0, 1 
		sll $t2,$t1,2
		j bubbleLoop1
	bubbleLoop1:
		bltz $t1, output
		li $t3, 0
		li $t4, 0
		j bubbleLoop2
		bubbleLoop2:
			beq $t3, $t1, endBubbleLoop2
			addi $t5, $t4, 4
			lw $t6, myArray($t4)
			lw $t7, myArray($t5)
			ble $t6, $t7, bubbleElse
			j swap
			swap:
				sw $t6, myArray($t5)
				sw $t7, myArray($t4)
				j bubbleElse
			bubbleElse:
				addi $t3, $t3, 1
				addi $t4, $t4, 4
				j bubbleLoop2
		endBubbleLoop2:
			addi $t1, $t1, -1
			addi $t2, $t2, -4
			j bubbleLoop1
#####################################################################
	gnomeSort:
		li $t1, 0
		li $t2, 0
		j loop1
		loop1:
			beq $t1, $t0, output
			bne $t1, $zero, endIf1
			addi $t1, $t1, 1
			addi $t2, $t2, 4
			j endIf1
			endIf1:
				subi $t3, $t2, 4
				lw $t4, myArray($t2)
				lw $t5, myArray($t3)
				blt $t4, $t5, else2
				addi $t1, $t1, 1
				addi $t2, $t2, 4
				j loop1
			else2:
				sw $t4, myArray($t3)
				sw $t5, myArray($t2)
				addi $t1, $t1, 1
				addi $t2, $t2, 4
				j loop1
#####################################################################
        inputElement:
		li $v0, 4
		la $a0,reInputMessage
		syscall
		j inputLoop
	output:
		li $v0, 4
		la $a0, outputMessage
		syscall
		li $t1, 0
		li $t2, 0
		j outputLoop
	outputLoop:
		beq $t1, $t0, exit
		li $v0, 1
		lw $t7, myArray($t2)
		move $a0, $t7
		syscall
		
		li $v0, 4
		la $a0, printSpace
		syscall
		
        	addi $t1, $t1, 1				#Tang bien dem len 1
        	addi $t2, $t2, 4				#Tang bien index len 4
        	j outputLoop
        exit:
		
		
