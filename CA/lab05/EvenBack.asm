li a7, 5
ecall

mv t0, a0 # counter
mv t1, a0
li t6, -4

mul t6, t6, t0 # number of bits

add s0, s0, t6 # array
# li t0, 0 # iterator
li t2, 2 # for remainder

Pupa:
  addi t0, t0, -1
  ecall
  sw a0, 0(s0)
  addi s0, s0, 4
  bnez t0, Pupa

addi s0, s0, -4
Lupa:
  addi t1, t1, -1
  lw t5, 0(s0)
  addi s0, s0, -4
  rem t3, t5, t2

  bnez t3, skip
  
  mv a0, t5
  li a7, 1
  ecall
  li a7, 11
  li a0, '\n'
  ecall

skip:
  blt zero, t1, Lupa




