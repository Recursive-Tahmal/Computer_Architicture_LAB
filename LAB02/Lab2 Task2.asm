.data
Msg0: .asciiz "Lab2 Task2 by Amin Selhabi 2140632"
Msg1: .asciiz "\n The result is: "
Msg2: .asciiz "\n The Quotient is: "
Msg3: .asciiz "\n The Remainder is: "

.text
#printing Msg0
li $v0, 4
la $a0, Msg0
syscall


#Calculating the division
addi $t1, $zero, 9
addi $t2, $zero, 4
div $s0, $t1, $t2
#Quotient
mflo $s3 
#Remainder
mfhi $s4 

# The result is: 
li $v0, 4
la $a0, Msg1
syscall
li $v0, 1
add $a0, $zero, $s0
syscall


#Quotient
li $v0, 4
la $a0, Msg2
syscall
li $v0, 1
add $a0, $zero, $s3
syscall


#Remainder
li $v0, 4
la $a0, Msg3
syscall
li $v0, 1
add $a0, $zero, $s4
syscall
li $v0, 10
syscall