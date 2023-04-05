.data
promptA: .asciiz "Enter coefficient a: "
promptB: .asciiz "Enter coefficient b: "
promptC: .asciiz "Enter coefficient c: "
result: .asciiz "\nThe roots are: "
ors: .asciiz "\nOr: "
complexRoot: .asciiz "Complex Roots."
four: .double 4.0
two: .double 2.0
zero: .double 0.0
negOne: .double -1.0
open: .asciiz "("
close:.asciiz ")"
imaginaryPart: .asciiz "i "
plus: .asciiz " + "
minus: .asciiz " - "
sqr: .asciiz " ?"
divid: .asciiz " / "


.text
# Print prompt message to enter coefficient a
li $v0, 4
la $a0, promptA
syscall

# Read coefficient a
li $v0, 7
syscall
mov.d $f20, $f0


# Print prompt message to enter coefficient b
li $v0, 4
la $a0, promptB
syscall

# Read coefficient b
li $v0, 7
syscall
mov.d $f14, $f0


# Print prompt message to enter coefficient c
li $v0, 4
la $a0, promptC
syscall

# Read coefficient c
li $v0, 7
syscall
mov.d $f16, $f0

# Calculate the discriminant: $f8 = $f14^2 - 4 * $f12 * $f16
mul.d $f8, $f14, $f14 # $f8 = $f14 * $f14
ldc1 $f10, four # load four into $f10
mul.d $f10, $f10, $f20 # 4 * $f20
mul.d $f10, $f10, $f16 # $f10 = $f10 * $f16
sub.d $f8, $f8, $f10 # $f8 = $f8 - $f10

# Check if the roots are complex
ldc1 $f18, zero
c.lt.d $f8, $f18
bc1t complex

# Compute the roots
sqrt.d $f8, $f8 # square root $f8 and store it in $f8
ldc1 $f10, two 
mul.d $f6, $f10, $f20
sub.d $f14, $f18, $f14
add.d $f4, $f14, $f8
div.d $f22, $f4, $f6  # $f10 = $f8 / $f6
    
    
# Print the roots
li $v0, 4
la $a0, result
syscall
li $v0, 3
mov.d $f12, $f22
syscall
li $v0, 4
la $a0, ors
syscall
li $v0, 3
sub.d $f4, $f14, $f8
div.d $f12, $f4, $f6
syscall
j end




# Handle complex roots
complex: 
ldc1 $f6 negOne
mul.d $f4, $f8 $f6
sqrt.d $f6, $f4   
sub.d $f14, $f18, $f14 # converting b to -b
ldc1 $f12, two
mul.d $f8, $f12, $f20
    
# Print the roots (part real, part imaginary)
li $v0, 4
la $a0, result
syscall
li $v0, 4
la $a0, open
syscall
li $v0, 3
mov.d $f12, $f14
syscall

li $v0, 4
la $a0, plus
syscall

li $v0, 3
mov.d $f12, $f6
syscall


li $v0, 4
la $a0, imaginaryPart
syscall

li $v0, 4
la $a0, close
syscall

li $v0, 4
la $a0, divid
syscall

li $v0, 3
mov.d $f12, $f8
syscall

# printing the minus case
li $v0, 4
la $a0, ors
syscall
li $v0, 4
la $a0, result
syscall
li $v0, 4
la $a0, open
syscall
li $v0, 3
mov.d $f12, $f14
syscall
li $v0, 4
la $a0, minus
syscall
li $v0, 3
mov.d $f12, $f6
syscall
li $v0, 4
la $a0, imaginaryPart
syscall
li $v0, 4
la $a0, close
syscall
li $v0, 4
la $a0, divid
syscall
li $v0, 3
mov.d $f12, $f8
syscall

end:
li $v0, 10
syscall

