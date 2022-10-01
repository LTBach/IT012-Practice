.data
	inputMessage: .asciiz "Nhap so phan tu cua mang: "
	outputMessage: .asciiz "Mang da nhap la: \n"
	printSpace:	.asciiz " "
	reInputMessage:	.asciiz "Nhap lai\n"
	endl:		.asciiz "\n"
	maxMessage:	.asciiz "So lon nhat trong mang la: "
	minMessage:	.asciiz "So be nhat trong mang la: "
	sumMessage:	.asciiz "Tong cac so trong mang la: "
	oddMessage:	.asciiz "So phan tu le trong mang la: "
	evenMessage:	.asciiz "So phan tu chan trong mang la: "
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
		bgt $t0, 100,reInput	                	#Neu so nhap vao >100 || <0 thi reInput   	
		ble $t0, 0,reInput
		
		li $t7, 0					#t7 dung de luu bien dem
		li $t6, 0 					#t6 dung de luu bien index
    		j inputLoop
	reInput:
		li $v0, 4
		la $a0,reInputMessage
		syscall
		j input
	inputLoop:
        	beq $t7, $t0, next				#Dieu kien dung
        	li $v0, 5
        	syscall
        	sw $v0, myArray($t6)                            #Luu du lieu vao mang
        	ble $v0, 0,inputElement
        	
        	addi $t6, $t6, 4				#Tang bien index len 4
        	addi $t7, $t7, 1				#Tang bien dem len 1
        	j inputLoop
        inputElement:
		li $v0, 4
		la $a0,reInputMessage
		syscall
		j inputLoop
	next:
		li $t7, 0					#reset bien dem
		li $t6, 0					#reset bien index
		li $t5, 0                   			#tong
		li $t4, 0                   			#chan
		li $t3, 0                   			#le
		li $t7, 0		    			#check dieu kien dung
		li $t6, 0		    			#index
		lw $s0, myArray($zero)      			#max
		lw $s1, myArray($zero)	    			#min
		j get
	get:
        	beq $t7, $t0, Output	    			#diuu kien dung
        	lw $t2, myArray($t6)        			#load t2=phan tu trong mang
        	andi $t1, $t2, 1	    			#t1 chua gia tri cua bit cuoi t2
        	checkEvenOrOdd:
       			beq $t1, $zero, countEven   		#neu bit cuoi t1 ==0 thì countEven
        		countOdd:
        			addi $t3, $t3, 1
        			j checkMax
      	  		countEven:
        			addi $t4, $t4, 1
        	checkMax:
        		bgt $t2, $s0, changeMax			#Neu co phan tu lon hon max update max
        		j checkMin
        		changeMax:
        			move $s0, $t2
        	checkMin:
        		blt $t2, $s1, changeMin			#Neu co phan tu be hon min update min
        		j tmp
        		changeMin:
        			move $s1, $t2
        tmp:
        	add $t5, $t5, $t2	    			#sum=sum+ phan tu
        	addi $t6, $t6, 4				#Thêm 4 vao bien index t6
        	addi $t7, $t7, 1				#Thêm 1 vào bien dem t7
        	j  get
        Output:
        	li $v0, 4
        	la $a0, endl
        	syscall
        	
        	li $v0, 4
        	la $a0, maxMessage
        	syscall
        	
        	li $v0, 1
        	move $a0, $s0					#Xuat max
        	syscall
        	
        	li $v0, 4
        	la $a0, endl
        	syscall
        	
        	li $v0, 4
        	la $a0, minMessage
        	syscall
        	
        	li $v0, 1
        	move $a0, $s1					#Xuat min
        	syscall
        	
        	li $v0, 4
        	la $a0, endl
        	syscall
        	
        	li $v0, 4
        	la $a0, sumMessage
        	syscall
        	
        	li $v0, 1
        	move $a0, $t5					#Xuat sum
        	syscall
        	
        	li $v0, 4
        	la $a0, endl
        	syscall
        	
        	li $v0, 4
        	la $a0, evenMessage				#Xuat so chan
        	syscall
        	
        	li $v0, 1
        	move $a0, $t4
        	syscall
        	
        	li $v0, 4
        	la $a0, endl
        	syscall
        	
        	li $v0, 4
        	la $a0, oddMessage
        	syscall
        	
        	li $v0, 1
        	move $a0, $t3					#Xuat so le
        	syscall
        	
        	
        	
        	
		
		
		
	
