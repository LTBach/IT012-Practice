.data
	inputMessage: .asciiz "Nhap so phan tu cua mang: "
	outputMessage: .asciiz "Mang da nhap la: \n"
	printSpace:	.asciiz " "
	reInputMessage:	.asciiz "Nhap lai\n"
	.align 2	
	myArray: .space 400
.text
.globl main
main:
	input:
		#Xuat ra inputMessage
		li $v0, 4
		la $a0,inputMessage
		syscall
		#Lay so phan tu cua mang
		li $v0, 5
		syscall
		move  $t0, $v0
		bgt $t0, 100,reInput	
		#Luu so phan tu cua mang vao v0
		li $t7, 0
		li $t6, 0 
    		#t7 bien dem,t6 dung de chi index
    		j inputLoop
	reInput:
		li $v0, 4
		la $a0,reInputMessage
		syscall
		j input
	inputLoop:
          	#cDieu kien dung
        	beq $t7, $t0, next
            	#Nhap lieu
        	li $v0, 5
        	syscall
            	#Luu du lieu
        	sw $v0, myArray($t6)
        	ble $v0, 0,inputElement
            	#Them 4 vao bien index t6
        	addi $t6, $t6, 4
            	#Them 1 vao bien dem
        	addi $t7, $t7, 1
        	j inputLoop
        inputElement:
		li $v0, 4
		la $a0,reInputMessage
		syscall
		j inputLoop
	next:
		#Xuat ra ouputMessage
		li $v0, 4
		la $a0, outputMessage
		syscall
		#t5 la bien dem,t4 la bien chi index,t3 la bien de luu gia tri
		li $t5, 0
		li $t4, 0
		li $t3, 0
		j outputLoop
	outputLoop:
		#Dieu kien dung
        	beq $t5, $t0, exit
            	#Luu gia tri cua vao t3
            	lw $t3, myArray($t4)
            	#In ra t3
        	li $v0, 1
        	move $a0, $t3
        	syscall
        	#In khoang trang(space)
        	li $v0, 4
        	la $a0, printSpace
        	syscall
            	#Them 4 vao bien chi index t4
        	addi $t4, $t4, 4
            	#Them 1 vao bien dem t5
        	addi $t5, $t5, 1
        	j outputLoop
        exit:
       
  