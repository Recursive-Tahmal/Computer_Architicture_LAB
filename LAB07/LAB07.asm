.data
input1: .asciiz "Please enter a number: "
input2: .asciiz "Please enter how many numbers you wish to stop printing at: "
myArray: .word 100:5
space: .asciiz " "


.text
addi $t0, $zero, 0

loop:
beq $t0, 20, print
li $v0, 4
la $a0, input1
syscall

li $v0, 5
syscall

sw $v0, myArray($t0)
addi $t0, $t0, 4
j loop


print:
li $v0, 4
la $a0, input2
syscall

li $v0, 5
syscall

mul $s1, $v0, 4
addi $t1, $zero, 0
while:
beq $t1, $s1, stop
li $v0, 1
lw $a0, myArray($t1)
addi $t1, $t1, 4
syscall

li $v0, 4
la $a0, space
syscall

j while

stop:
li $v0, 10
syscall
