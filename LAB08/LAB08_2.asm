# Description: 
# This MIPS assembly program is an interactive quadratic equation solver. 
# It prompts the user to enter the coefficients (a, b, and c) of a quadratic equation 
# and calculates and displays the roots using double-precision floating-point instructions. 
# It handles both real and complex roots, presenting the results in a clear and understandable format.

.data
promptA: .asciiz "Enter coefficient a: "    # Prompt message for coefficient a
promptB: .asciiz "Enter coefficient b: "    # Prompt message for coefficient b
promptC: .asciiz "Enter coefficient c: "    # Prompt message for coefficient c
result: .asciiz "\nThe roots are: "        # Message to print the roots
ors: .asciiz "\nOr: "                      # Separator for the roots
complexRoot: .asciiz "Complex Roots."      # Message for complex roots
four: .double 4.0                         # Constant value 4.0
two: .double 2.0                          # Constant value 2.0
zero: .double 0.0                         # Constant value 0.0
negOne: .double -1.0                      # Constant value -1.0
open: .asciiz "("                         # Opening parenthesis for complex roots
close:.asciiz ")"                         # Closing parenthesis for complex roots
imaginaryPart: .asciiz "i "               # "i" for imaginary part of complex roots
plus: .asciiz " + "                       # Plus sign for complex roots
minus: .asciiz " - "                      # Minus sign for complex roots
sqr: .asciiz " ?"                         # Placeholder for invalid square roots
divid: .asciiz " / "                      # Division symbol for complex roots

.text
# Print prompt message to enter coefficient a
li $v0, 4
la $a0, promptA
syscall

# Read coefficient a
li $v0, 7
syscall
mov.d $f20, $f0                            # a is stored in $f20

# Print prompt message to enter coefficient b
li $v0, 4
la $a0, promptB
syscall

# Read coefficient b
li $v0, 7
syscall
mov.d $f14, $f0                            # b is stored in $f14

# Print prompt message to enter coefficient c
li $v0, 4
la $a0, promptC
syscall

# Read coefficient c
li $v0, 7
syscall
mov.d $f16, $f0                            # c is stored in $f16

# Calculate the discriminant: $f8 = $f14^2 - 4 * $f12 * $f16
mul.d $f8, $f14, $f14                      # b^2 is stored in $f8
ldc1 $f10, four                           # Load constant 4.0 into $f10
mul.d $f10, $f10, $f20                     # 4 * a is stored in $f10
mul.d $f10, $f10, $f16                     # 4 * a * c is stored in $f10
sub.d $f8, $f8, $f10                       # b^2 - 4ac is stored in $f8

# Check if the roots are complex
ldc1 $f18, zero                           # Load constant 0.0 into $f18
c.lt.d $f8, $f18                          # Compare $f8 with 0.0 (if negative, branches to complex label)
bc1t complex                              # Branch to complex label if $f8 is less than 0

# Compute the roots
sqrt.d $f8, $f8                           # Square root of discriminant and store it in $f8
ldc1 $f10, two                            # Load constant 2.0 into $f10
mul.d $f6, $f10, $f20                     # 2 * a is stored in $f6
sub.d $f14, $f18, $f14                    # -b is stored in $f14
add.d $f4, $f14, $f8                      # -b + sqrt(discriminant) is stored in $f4
div.d $f22, $f4, $f6                      # (-b + sqrt(discriminant)) / (2 * a) is stored in $f22

# Print the roots
li $v0, 4
la $a0, result
syscall
li $v0, 3
mov.d $f12, $f22                          # First root is stored in $f22
syscall
li $v0, 4
la $a0, ors
syscall
li $v0, 3
sub.d $f4, $f14, $f8                      # -b - sqrt(discriminant) is stored in $f4
div.d $f12, $f4, $f6                      # (-b - sqrt(discriminant)) / (2 * a) is stored in $f12
syscall
j end

# Handle complex roots
complex:
ldc1 $f6 negOne                          # Load constant -1.0 into $f6
mul.d $f4, $f8, $f6                      # -discriminant is stored in $f4
sqrt.d $f6, $f4                          # Square root of -discriminant and store it in $f6
sub.d $f14, $f18, $f14                   # -b is stored in $f14
ldc1 $f12, two                           # Load constant 2.0 into $f12
mul.d $f8, $f12, $f20                    # 2 * a is stored in $f8

# Print the roots (part real, part imaginary)
li $v0, 4
la $a0, result
syscall
li $v0, 4
la $a0, open
syscall
li $v0, 3
mov.d $f12, $f14                         # Real part of complex root is stored in $f14
syscall
li $v0, 4
la $a0, plus
syscall
li $v0, 3
mov.d $f12, $f6                          # Imaginary part of complex root is stored in $f6
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
mov.d $f12, $f8                          # Division part of complex root is stored in $f8
syscall

# Printing the minus case
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
mov.d $f12, $f14                         # Real part of complex root is stored in $f14
syscall
li $v0, 4
la $a0, minus
syscall
li $v0, 3
mov.d $f12, $f6                          # Imaginary part of complex root is stored in $f6
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
mov.d $f12, $f8                          # Division part of complex root is stored in $f8
syscall

end:
li $v0, 10
syscall
