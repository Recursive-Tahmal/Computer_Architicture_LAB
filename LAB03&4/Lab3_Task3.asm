.data
Mymessage: .asciiz "Tom - This program will perform simple arithmetic on two integers inputted by user.\n"
Num1: .asciiz "\nEnter first number: "
Num2: .asciiz "\nEnter second number: "
Sum: .asciiz "\nSum = "
Diff: .asciiz "\nDifference = "
Product: .asciiz "\nProduct = "
Quotient: .asciiz "\nQuotient = "
Thanks: .asciiz "\n\nThank You!"

.text
#Welcoming message
li $v0, 4
la $a0, Mymessage
syscall

#First number prompt
li $v0,4
la $a0, Num1
syscall

#input for the first number
li $v0, 5
syscall
move $s0, $v0

#Second number prompt
li $v0,4
la $a0, Num2
syscall

#input for the second number
li $v0, 5
syscall
move $s1, $v0

#Sum message
li $v0,4
la $a0, Sum
syscall

#Sum calculation
li $v0, 1
add $a0, $s0, $s1
syscall

#Difference message
li $v0, 4
la $a0, Diff
syscall

#Difference calculation
li $v0, 1
sub $a0, $s0, $s1
syscall

#Product message
li $v0, 4
la $a0, Product
syscall

#Product calculation
li $v0, 1
mul $a0, $s0, $s1
syscall

#Quotient message
li $v0, 4
la $a0, Quotient
syscall

#Quotient calculation
li $v0, 1
div $a0, $s0, $s1
syscall


#Welcoming message
li $v0, 4
la $a0, Thanks
syscall