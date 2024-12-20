.data
matrix:         .space 10000     # Allocate space for a 10x10 matrix

.text
main:
    # Read rows saved in $t1
    li $v0, 5
    syscall
    move $t1, $v0       

    # Read columns saved in $t2
    li $v0, 5
    syscall
    move $t2, $v0       

    # Input matrix elements
    la $t0, matrix       # Load base address of matrix
    move $t3, $zero      # Initialize row index

input_loop_rows:
    move $t4, $zero      # Initialize column index
input_loop_columns:
    # Read element from input
    li $v0, 5
    syscall
    sw $v0, ($t0)        # Store element in matrix

    addi $t4, $t4, 1     # Increment column index
    addi $t0, $t0, 4     # Move to the next element
    blt $t4, $t2, input_loop_columns

    addi $t3, $t3, 1     # Increment row index
    blt $t3, $t1, input_loop_rows

    # la $t0, matrix       # Load base address of matrix
    # move $t3, $zero      # Initialize row index
    subi $t0, $t0, 4
    move $t3, $t1
output_loop_rows:
    move $t4, $t2      # Initialize column index
output_loop_columns:
    lw $t5, ($t0)        # Load matrix element
    beqz $t5, skip_output

    addi $t6, $t3, 0     # Calculate row number (starting from 1)
    addi $t7, $t4, 0     # Calculate column number (starting from 1)

    move $a0, $t6        # Row number
    move $a1, $t7        # Column number
    move $a2, $t5        # Value

    # Call a function to print the triplet
    jal print_triplet

skip_output:
    subi $t4, $t4, 1     # Increment column index
    subi $t0, $t0, 4     # Move to the next element
    bgt $t4, $zero, output_loop_columns

    subi $t3, $t3, 1     # Increment row index
    bgt $t3, $zero, output_loop_rows

    # End of the program
    li $v0, 10           # Exit syscall
    syscall

# Function to print a triplet
print_triplet:
    li $v0, 1            # Print integer
    syscall

    li $a0, 32           # Print space character
    li $v0, 11
    syscall
    
    li $v0, 1
    move $a0, $a1
    syscall
    
    li $a0, 32           # Print space character
    li $v0, 11
    syscall
    
    li $v0,1
    move $a0,$a2
    syscall
    
    li $a0,10
    li $v0,11
    syscall

    jr $ra               # Return from function
