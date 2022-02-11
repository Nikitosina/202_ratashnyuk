li a7, 5
ecall

mv s0, a0 # counter
li s1, 1 # multiplier
li s2, 0 # result
li t0, -1 # multiplier of multiplier

Cycle:
  li a7, 5
  ecall
  mv s3, a0
  mul s3, s3, s1
  
  addi s0, s0, -1
  add s2, s2, s3
  mul s1, s1, t0
  bnez s0, Cycle

mv a0, s2
li a7, 1
ecall
