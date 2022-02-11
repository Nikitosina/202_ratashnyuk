main:
  li a7, 5
  ecall
  mv s0, a0
  
  li a7, 5
  ecall
  mv s1, a0

  li a7, 5
  ecall
  mv s2, a0

  li a7, 5
  ecall
  mv s3, a0
  
  add s0, s0, s2
  add s1, s1, s3
  
  mv a0, s0
  li a7, 1
  ecall
  
  li a7, 4
  li a7, 11
  li a0, '\n'
  ecall
  
  mv a0, s1
  li a7, 1
  ecall
  