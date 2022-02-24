main:
  li a7, 5
  ecall
  mv t0, a0 # saving n
  li a7, 7
  ecall
  fmv.d ft0, fa0 # ft0 - precision
  li t1, 0
  li t4, 2
  fcvt.d.w ft4, t4
  fdiv.d ft0, ft0, ft4
  fcvt.d.w ft1, t1 # counter
  fcvt.d.w ft5, t0
  fsub.d ft5, ft5, ft0
  loop:	
    fmul.d ft2, ft1, ft1
    fmul.d ft2, ft2, ft1
    fge.d t1, ft2, ft5
    fadd.d ft1, ft1, ft0 
    beqz t1, loop

  li t1, 0
  fcvt.d.w ft3, t1
  fadd.d fa0, ft1, ft3
  li a7, 3
  ecall
  li a7, 10
  ecall