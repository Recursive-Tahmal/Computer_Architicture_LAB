.data
Num1: .asciiz "\nEnter first number: "
Num2: .asciiz "\nEnter second number: "
Num3: .asciiz "\nEnter third number: "
MsgG: .asciiz " is the greatest\n"
MsgS: .asciiz " is the smallest\n"

.text
#First number prompt
li $v0, 4
la $a0, Num1
syscall

#first number input
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

#Third number prompt
li $v0,4
la $a0, Num3
syscall

#input for the second number
li $v0, 5
syscall
move $s2, $v0



#Bigger than compare
bgt $s0, $s1, num0B
bgt $s1, $s2, num1B
j num2B

num0B:
blt $s0, $s2, num2B
li $v0, 1
move $a0, $s0
syscall
j small

num1B:
li $v0, 1
move $a0, $s1
syscall
j small

num2B:
li $v0, 1
move $a0, $s2
syscall
j small



# finding the smallest number
small:
li $v0, 4
la $a0, MsgG
syscall #printing the big number here to reduce redunduncy
blt $s0, $s1, num0S
blt $s1, $s2, num1S
j num2S

num0S:
bgt $s0, $s2, num2S
li $v0, 1
move $a0, $s0
syscall
j End

num1S:
li $v0, 1
move $a0, $s1
syscall
j End

num2S:
li $v0, 1
move $a0, $s2
syscall
j End


End:
li $v0, 4
la $a0, MsgS #printing the big number here to reduce redunduncy
syscall
li $v0, 10
syscall



