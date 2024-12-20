.text
main:
    # Read year from input
    li $v0, 5
    syscall
    move $t0, $v0   # Save year in $t0

    # Check if it's a leap year
    li $t1, 4       # Divisor for leap year check
    li $t2, 100     # Divisor for century check
    li $t3, 400     # Divisor for quadricentennial check

    div $t0, $t1    # Check if year is divisible by 4
    mfhi $t4        # Remainder in $t4
    beqz $t4, check_100
    
    # not divisible by 4,exit
    li $v0,1
    li $a0,0
    syscall
    li $v0,10
    syscall
    
check_100:
    div $t0,$t2
    mfhi $t4
    beqz $t4,check_400
    # not divisible by 100,true
    li $v0,1
    li $a0,1
    syscall
    li $v0,10
    syscall
check_400:
    div $t0,$t3
    mfhi $t4
    beqz $t4,output_1
    li $v0,1
    li $a0,0
    syscall
    li $v0,10
    syscall
    
output_1:
    li $v0,1
    li $a0,1
    syscall
    li $v0,10
    syscall