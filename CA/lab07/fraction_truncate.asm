.text

j main
subroutine:
  li t0, 0
  li t5, 10
  fcvt.d.w f3, t5
  loop:
    fmul.d f2, f2, f3
    addi, t0, t0, 1
    bne a0, t0, loop
    fcvt.w.d t0, f2
    fcvt.d.w f2, t0
    li t0, 0
  loop1:
    fdiv.d f2, f2, f3
    addi t0, t0, 1
    bne a0, t0, loop1
    jalr zero, 0(ra)


main:
  li a7, 5
  ecall
  add t0, zero, a0
  ecall
  add t1, zero, a0
  ecall
  add t2, zero, a0
  
  mv a0, t2
  fcvt.d.w f0, t0
  fcvt.d.w f1, t1
  fdiv.d f2, f0, f1
  jal ra, subroutine
  li a7, 3
  fmv.d fa0, f2
  ecall
