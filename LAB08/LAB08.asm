.data
sum: .asciiz "Enter sum: "
count: .asciiz "Enter count: "
result: .asciiz "Average: "

.text
    # Print prompt for sum
    li $v0, 4
    la $a0, sum
    syscall

    # Read sum
    li $v0, 5
    syscall
    move $s0, $v0

    # Print prompt for count
    li $v0, 4
    la $a0, count
    syscall

    # Read count
    li $v0, 5
    syscall
    move $s1, $v0

    # Convert integers to float
    mtc1 $s0, $f0
    mtc1 $s1, $f2
    cvt.s.w $f0, $f0
    cvt.s.w $f2, $f2

    # Compute average
    div.s $f4, $f0, $f2

    # Print result
    li $v0, 4
    la $a0, result
    syscall
    li $v0, 2
    mov.s $f12, $f4
    syscall

    li $v0, 10
    syscall

