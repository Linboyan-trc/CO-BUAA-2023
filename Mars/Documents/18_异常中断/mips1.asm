# 测试程序 5 - 助教的提示
# 发现的 bug：
# 1. 阻塞时清空了 PC，导致在空气泡处中断时 EPC 为 0。

# $s0: 测试点

#################### .text ####################
.text
  ori $t0, $0, 0x0401 # 只允许 Timer0 中断
  mtc0 $t0, $12
  nop
  nop
  nop
  sw $0, 0x7f20($0) # 关闭外部中断，便于比较输出
  
  # 1. 转发指令
  
  # 2. 阻塞指令（当 M 级为空气泡时，EPC 能否正常写入）
  ori $s0, $0, 0x0002
  ori $t0, $0, 0x0003
  ori $t1, $0, 0x7f04
  sw $t0, 0($t1)
  ori $t0, $0, 0x0001
  ori $t1, $0, 0x7f00
  sw $t0, 0($t1)
  ori $t0, $0, 0x0009
  sw $t0, 0($t1)
  nop
  nop
  nop
  lw $t1, 0($0)
  add $t1, $t1, $t1
  nop
  nop
  nop
  
  # 3. 跳转指令
  ori $s0, $0, 0x0003
  ori $t0, $0, 0x0003
  ori $t1, $0, 0x7f04
  sw $t0, 0($t1)
  ori $t0, $0, 0x0001 # 暂时禁用中断，否则会立即发出中断信号。
  ori $t1, $0, 0x7f00
  sw $t0, 0($t1)
  ori $t0, $0, 0x0009
  sw $t0, 0($t1)
  nop
  nop
  nop
  nop
  beq $0, $0, label_3
  ori $t0, $0, 0x0001
  label_3: ori $t0, $0, 0x0002
  ori $t0, $0, 0x0003
  
  # 4. 延迟槽指令
  ori $s0, $0, 0x0004
  ori $t0, $0, 0x0003
  ori $t1, $0, 0x7f04
  sw $t0, 0($t1)
  ori $t0, $0, 0x0001
  ori $t1, $0, 0x7f00
  sw $t0, 0($t1)
  ori $t0, $0, 0x0009
  sw $t0, 0($t1)
  nop
  nop
  nop
  beq $0, $0, label_4
  ori $t0, $0, 0x0001
  label_4: ori $t0, $0, 0x0002
  ori $t0, $0, 0x0003
  
  loop:
  beq $0, $0, loop
  nop


#################### .ktext ####################
.ktext 0x4180
  mfc0 $t0, $12
  mfc0 $t0, $13
  mfc0 $t0, $14
  
  switch_s0:
    ori $t0, $0, 0x0002
    beq $s0, $t0, case_2
    nop
    ori $t0, $0, 0x0003
    beq $s0, $t0, case_3
    nop
    ori $t0, $0, 0x0004
    beq $s0, $t0, case_4
    nop
    ori $t0, $0, 0xc0c0
    beq $0, $0, endswitch_s0
    nop
    
    case_2:
    case_3:
    case_4:
      ori $t1, $0, 0x7f00
      sw $0, 0($t1)
      eret
      ori $t0, $0, 0xc0c0
  endswitch_s0:
  eret
  ori $t0, $0, 0xc0c0
