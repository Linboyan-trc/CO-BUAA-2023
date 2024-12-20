.data
graph:          .space 10000       # Allocate space for the graph (adjust size as needed)
visited:        .space 100         # Keep track of visited vertices
n:              .word 0             # Number of vertices
m:              .word 0             # Number of edges
has_hamilton:   .word 0             # Flag to indicate if Hamiltonian cycle is found

.text
.globl main
main:
    # Read n from input
    li $v0, 5
    syscall
    sw $v0, n

    # Read m from input
    li $v0, 5
    syscall
    sw $v0, m

    # Initialize visited array
    la $t0, visited
    li $t1, 0
    li $t2, 100
init_visited:
    sb $t1, ($t0)
    addi $t0, $t0, 1
    addi $t2, $t2, -1
    bnez $t2, init_visited

    # Initialize flag
    sw $zero, has_hamilton

    # Initialize graph
    la $t3, graph
    li $t4, 0
    li $t5, 10000
init_graph:
    sb $zero, ($t3)
    addi $t3, $t3, 1
    addi $t4, $t4, 1
    bnez $t4, init_graph

    # Read edges and build graph
    la $t6, graph
read_edges:
    li $v0, 5
    syscall
    sw $v0, $t6
    addi $t6, $t6, 1
    li $v0, 5
    syscall
    sw $v0, $t6
    addi $t6, $t6, 1
    addi $t5, $t5, -2
    bnez $t5, read_edges

    # Start from each vertex and check for Hamiltonian cycle
    la $t7, visited
    la $t8, graph
    li $t9, 0
try_hamilton:
    sw $t9, ($t7)       # Mark current vertex as visited
    jal find_hamilton   # Call recursive function to find Hamiltonian cycle
    sw $zero, ($t7)     # Unmark current vertex as visited
    addi $t9, $t9, 1    # Move to the next vertex
    blt $t9, $t0, try_hamilton

    # Print the result
    lw $a0, has_hamilton
    li $v0, 1
    syscall

    # End of the program
    li $v0, 10
    syscall

# Recursive function to find Hamiltonian cycle
# Arguments: $a0 = current vertex, $a1 = current length of cycle
find_hamilton:
    move $t7, $a0        # Load address of visited array
    move $t8, $a1        # Load current length of cycle
    move $t9, $a0        # Load current vertex
    lw $t10, n           # Load number of vertices

    # Base case: If cycle is of length n, check if it's a cycle
    beq $t8, $t10, check_cycle

    # Recursive case: Try visiting unvisited neighbors
    la $t11, graph
try_neighbors:
    lb $t12, ($t7)       # Check if neighbor is visited
    beqz $t12, skip_neighbor
    lb $t12, ($t11)
    bnez $t12, skip_neighbor

    # Visit neighbor and recursively find Hamiltonian cycle
    sw $t9, ($t11)
    addi $t8, $t8, 1
    jal find_hamilton

    # Unvisit neighbor
    sw $zero, ($t11)
    subi $t8, $t8, 1

skip_neighbor:
    addi $t9, $t9, 1    # Move to the next neighbor
    addi $t11, $t11, 1  # Move to the next entry in graph
    bne $t9, $t10, try_neighbors

    jr $ra

# Function to check if the current cycle is a Hamiltonian cycle
check_cycle:
    la $t11, graph
    li $t12, 0

check_next:
    lb $t13, ($t11)
    beqz $t13, not_hamilton

    addi $t12, $t12, 1
    addi $t11, $t11, 1
    b check_next

not_hamilton:
    bnez $t12, not_hamilton
    lw $t14, has_hamilton
    li $t15, 1
    sw $t15, ($t14)

    jr $ra
