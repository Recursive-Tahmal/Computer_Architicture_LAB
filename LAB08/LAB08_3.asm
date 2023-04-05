.data
sqnum: .asciiz "The number we are going to take the square root is: "
guessnum: .asciiz "\nThe guess number is: "
sqr: .asciiz "\nThe sqrt.d answer is: "
num: .double 5.43987564387543E14
guess: .double 1.0
half: .double 0.5
twenty: .word 20

.text
main:
	# Print message
	li $v0, 4
	la $a0, sqnum
	syscall

	# Print number
	li $v0, 3
	l.d $f12, num
	syscall

	# Print guess message
	li $v0, 4
	la $a0, guessnum
	syscall

	# Call square_root function
	j square_root


square_root:
	# Load initial guess
	l.d $f0, guess

	# Load loop counter
	lw $t0, twenty

	# Repeat 20 times
	loop:
		# Calculate new guess
		l.d $f4, num
		div.d $f6, $f4, $f0
		add.d $f6, $f6, $f0
		l.d $f2, half
		mul.d $f6, $f6, $f2

		# Store new guess in $f0
		mov.d $f0, $f6

		# Decrement loop counter
		addi $t0, $t0, -1
		bne $t0, $zero, loop

	# Print result
	li $v0, 3
	mov.d $f12, $f0
	syscall

	# Compare with sqrt.d
	li $v0, 4
	la $a0, sqr
	syscall
	li $v0, 3
	sqrt.d $f12, $f4
	syscall

	# Exit program
	li $v0, 10
	syscall
