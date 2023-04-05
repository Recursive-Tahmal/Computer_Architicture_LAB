.data
Num: .asciiz "Please Enter a Number: "
is: .asciiz "\nIs "
andd: .asciiz " divisible by 5 and 6? "
orr: .asciiz " divisible by 5 or 6? "
xorr: .asciiz " divisible by 5 or 6, but not both?? "
true: .asciiz "True "
false: .asciiz "False "


.text 
# Asking for input
li $v0, 4
la $a0, Num
syscall
li $v0, 5
syscall
move $s0, $v0

# Dividing by 5
div $t0, $s0, 5
mfhi $s1

# Checking if reminder is bigger than zero
bnez $s1, True1
move $t1, $zero # zero for false
j Skip1

True1:
addi $s1, $s1, 1 # 1 for true

Skip1:
# Dividing by 6
li $v0, 1
div $t0, $s0, 6
mfhi $s2


# Checking if reminder is bigger than zero
bnez $s2, True2
move $t2, $zero # zero for false
j End

True2:
addi $s2, $s2, 1 # 1 for true
j End # Habbit

# LOGIC Check if both $s1, $s2 are 1 print true for AND
End:
or $t0, $s1, $s2

# Prints out "Is Num divisible by 5 and 6?"
li $v0, 4
la $t3, is
move $a0, $t3
syscall
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, andd
syscall

# Checking if 5 and 6 are divisible
beqz $t0, andZero
j andOne

andZero: # Prints "True"
li $v0, 4
la $a0, true
syscall
j orCheck


andOne: # Prints "False"
li $v0, 4
la $a0, false
syscall
j orCheck # Habbit



orCheck:
# Prints out "Is Num divisible by 5 and 6?"
li $v0, 4
la $t3, is
move $a0, $t3
syscall
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, orr
syscall

# LOGIC Check if both $s1, $s2 are 1 print true for OR
beqz $s1, orZero
beqz $s2, orZero
j orOne

orZero:
li $v0, 4
la $a0, true
syscall
j xorCheck

orOne:
li $v0, 4
la $a0, false
syscall
j xorCheck # Habbit

xorCheck:
# Prints out "Is Num divisible by 5 and 6 but not both??"
li $v0, 4
la $t3, is
move $a0, $t3
syscall
li $v0, 1
move $a0, $s0
syscall
li $v0, 4
la $a0, xorr
syscall

# LOGIC Check if both $s1, $s2 are 1 print true for XOR
beqz $s1, xorZero
beqz $s2, xorZero
j xorFalse

xorZero:
beqz $t0, xorFalse
li $v0, 4
la $a0, true
syscall
li $v0, 10
syscall

xorFalse:
li $v0, 4
la $a0, false
syscall
# Awesome homework!
