# This programme will count from 0 to the giving positive integer
.data
num: .asciiz "Please enter a number: "
count: .word -1
space: .asciiz " "

# Print "Please enter a number: "
.text
li $v0, 4
la $a0, num
syscall
# Input
li $v0, 5
syscall
move $s0, $v0

# Printing numbers from 0 to giving positive integer
lw $t0, count
la $t1, space

loop:
addi $t0, $t0, 1
li $v0, 1
move $a0, $t0
syscall
# Printing Blank " "
li $v0, 4 
move $a0, $t1
syscall
blt $t0, $s0, loop #looping

li $v0, 10
syscall
