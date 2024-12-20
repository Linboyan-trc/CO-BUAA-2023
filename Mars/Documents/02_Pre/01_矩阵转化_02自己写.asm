.data
matrix: .space 10000	#因为50*50=2500个元素，2500*4=10000字

						#这里默认.space n就给matrix分配n字节的空间

# $v0 预留给syscall	$v1	不用
# $a0 预留给syscall 	$a1~$a3	不用
# $t0 指定存储/读出的字地址	
# $t1 总行数 	$t3 行指针	$t5 要输出的元素 
# $t2 总列数	$t4 列指针

.text
main:	#指明程序入口
	#读入int
	li $v0,5
	syscall
	move $t1,$v0
	li $v0,5
	syscall
	move $t2,$v0
# 循环读元素
# 指明起始地址，行列指针初始化为00
	la $t0,matrix
	move $t3,$zero
input_rows:
	move $t4,$zero
input_columns: # 读取一行的元素
	li $v0,5
	syscall
	sw $v0,($t0)	# 把 v0的值 存到 t0所指的空间 中
				# $v0表示v0的值，($t0)表示t0所指的空间
	addi $t4,$t4,1	# 列指针t4++
	addi $t0,$t0,4	# 空间指向下一个字
#判断有没有超过列上限
	blt $t4,$t2,input_columns	# 没有超过上限，继续读入列元素，否则行++
							# 判断行有没有超上限，没有就列归零，否则结束输入
	addi $t3,$t3,1
	blt $t3,$t1,input_rows
# 逆行列序输出，且不能为0
# 指针回退到最后一个元素地址
	subi $t0,$t0,4
# 行列指针指向最尾部
	move $t3,$t1
read_rows:
	move $t4,$t2
# 加载元素，判断是否为0
# 为0就地址--，列--,否则输出
read_columns:
	lw $t5,($t0)
	beqz $t5,output_skip
# 不为0就输出，输出行，空格，列，空格，元素，换行符
# 输出整数是1，输出字符是11	
	li $v0,1	
	move $a0,$t3	
	syscall
	li $v0,11	
	li $a0,32	
	syscall
	li $v0,1	
	move $a0,$t4	
	syscall
	li $v0,11	
	li $a0,32	
	syscall
	li $v0,1	
	move $a0,$t5	
	syscall
	li $v0,11	
	li $a0,10	
	syscall
output_skip:
	subi $t0,$t0,4
	subi $t4,$t4,1	# 如果列数>0，就继续加载元素；否则行数--，列数重置为总列数
	bgtz $t4,read_columns
	subi $t3,$t3,1
	bgtz $t3,read_rows	# 如果行数--之后>0，就列数重置为总列数
						# 否则程序结束
	li $v0,10
	syscall
