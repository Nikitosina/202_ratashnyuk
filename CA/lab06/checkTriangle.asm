  .eqv a t0
  .eqv _b t1
  .eqv c t2

.text
j main

checkTriangle:
  bnez a, run
  bnez _b, run
  bnez c, run
  jalr zero, 0(ra)

  run:
    # a <= b + c
    add t3, _b, c
    bgt a, t3, printNo
  
    # b <= a + c
    add t3, a, c
    bgt _b, t3, printNo
  
    # c <= a + b
    add t3, a, _b
    bgt c, t3, printNo
  
    j printYes
  
  printNo:
    li a0, 'N'
    li a7, 11
    ecall
    jalr zero, 0(ra)
  
  printYes:
    li a0, 'Y'
    li a7, 11
    ecall
    jalr zero, 0(ra)

main:
  read:
    li a7, 5
    ecall
    mv a, a0
    ecall
    mv _b, a0
    ecall
    mv c, a0
    jal ra, checkTriangle

    bnez a, read
    bnez _b, read
    bnez c, read
  
  