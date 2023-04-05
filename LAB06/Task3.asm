# This programme will calculate the average of giving numbers
.data
num: .asciiz "Please enter a number to continue or a character to quit:  "
average: .asciiz "\nThe average is: "
remainder: .asciiz "\nThe remainder is: "
error: .word 0


# Prints "Please enter a number: "
.text
lw $t3, error # To stop the loop when an error is caught
Loop:
li $v0, 4
la $a0, num
syscall

li $v0, 5
syscall
move $s0, $v0
add $t0, $t0, $s0 # Sum of inputs
add $t1, $t1, 1 # Counting the inputs
j Loop


# Special thanks to https://courses.missouristate.edu/kenvollmar/mars/help/MarsExceptions.html for helping me figuring out how to catch an error
.ktext 0x80000180 #  Default Location of Exception Handler

# Prints "\nThe average is: "
li $v0, 4
la $a0, average
syscall
# Calculates and prints the quotient
li $v0, 1
div $t0, $t1
mflo $a0
syscall

# Prints "\nThe remainder is: "
li $v0, 4
la $a0, remainder
syscall
li $v0, 1
mfhi $a0
syscall
li $v0, 10
syscall


# Coprocessor 0 register $14 has address of trapping instruction
mfc0 $k0,$14   
# Add 4 to point to next instruction
addi $k0,$k0, 4 
# Store new address back into $14
mtc0 $k0,$14   
# Error return; set PC to value in $14
eret           
.kdata	
msg: .asciiz "Trap generated\n"
