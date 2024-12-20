# store i and sum
li $t0,1	# i
li $t1,0	# sum
# while sum+=i,i++
loop:
add $t1,$t1,$t0
add $t0,$t0,1
ble $t0,100,loop
#printf
li $v0,1
move $a0,$t1
syscall