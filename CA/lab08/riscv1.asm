.macro exit
    li      a7, 10
    ecall
.end_macro

.macro print_hex(%x)
    mv      a0, %x
    li      a7, 34
    ecall
.end_macro

.macro newline
    li      a0, '\n'
    li      a7, 11
    ecall
.end_macro

.data
array:
  .word 0x00000011, 0x00000021, 0x00000041, 0xffffff81, 0x00000012, 0x00000022, 0x00000042, 0xffffff82, 0x00000014, 0x00000024, 0x00000044, 0xffffff84, 0x00000018, 0x00000028, 0x00000048, 0xffffff88
array_end:

.data
indicatorArr:
  .word 0x3f, 0x6, 0x5b, 0x4f, 0x66, 0x6d, 0x7d, 0x7, 0x7f, 0x6f
indicatorArrEnd:

    .text
main:
    lui     s0, 0xffff0   # MMIO base
    mv      s1, zero      # counter
    mv      s2, zero      # previous value
    li      s3, 20        # counter limit
loop:
    li      t0, 1         # check first row
    sb      t0, 0x12(s0)  # scan
    lb      t1, 0x14(s0)  # get result
    bnez    t1, pressed   # process key pressed

    li      t0, 2         # check second row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 4         # check third row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    li      t0, 8         # check fourth row
    sb      t0, 0x12(s0)
    lb      t1, 0x14(s0)
    bnez    t1, pressed

    mv      s2, zero  # reset previous value
    j       loop  # nothing is pressed (t1 == 0) - repeat
pressed:
    beq     t1, s2, loop # repeat if the same key value
    mv      s2, t1 # save current value

    # Prints the pressed key in format 0xXY, where X is column, Y is row.
    # Both X and Y are specified as bit flags (0x1, 0x2, 0x4, 0x8).
    # Bit position means the number of row/column (0x1 -> 1, 0x2 -> 2, 0x4 -> 3, x8 -> 4).
    print_hex(t1)
    newline
    
  li t3, 0 # counter
  li t4, 16 # max
  la s3, array
  li a1, 4
  
  loop1:
    # mul t4, t3, a1
    lw t2, 0(s3)
    li a7, 1
    mv a0, t2
    ecall
    newline

    addi s3, s3, 4
    addi t3, t3, 1
    beq  t2, t1, saveCounter
    blt  t3, t4, loop1
  
  saveCounter:
    addi t3, t3, -1
    mv a2, t3 # int to show
    j showInt
  
  showInt:
    li  a3, 10
    rem a4, a2, a3
    
    la  s4, indicatorArr
    mul t5, a4, a1
    add s4, s4, t5
    lw  t6, 0(s4)
    
    lui   t3, 0xffff0    # MMIO address high half
    mv    t1, t6
    sb    t1, 0x10(t3)   # (0xffff0000+0x10)
    
    bge   a2, a3, showOne

  continue:
    addi    s1, s1, 1    # counter increment
    ble     s1, s3, loop # repeat if s1 <= s3

  showOne:
    li    t2, 0x6
    sb    t2, 0x11(t3)   # (0xffff0001+0x10)
    j continue
    

end:
    exit