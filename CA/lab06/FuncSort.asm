.macro swap (%el1, %el2)
  addi s0, s0, -4
  sw %el2, 0(s0)
  addi s0, s0, 4
  sw %el1, 0(s0)
.end_macro

.text
j main

bubbleSort:
  # a0 - size of array
  li a2, 4
  div t5, a0, a2 # number of elements
  li t3, 0 # i iterator
  li t4, 0 # j iterator
  mv s0, t6 # move to beginning of array

  mainLoop:
    li t4, 0
    innerLoop:
      mul s0, t4, a2 # j-th element position
      lw a3, 0(s0) # j-th element

      addi s0, s0, 4 # (j + 1)-th element position
      lw a4, 0(s0) # (j + 1)-th element


      
      addi t4, t4, 1
      sub t2, t5, t3 # t2 = n - i; last i elements are sorted
      addi t2, t2, -1 # we should go up to n - i - 1 
                      # because we compare j and j + 1 elements
      bne t4, t2, innerLoop
      
    addi t3, t3, 1
    bne t3, t5, mainLoop # if t3 != t5 then mainLoop
  
  
main:
  li a7, 5
  ecall

  mv t0, a0 # counter
  mv t1, a0
  li t6, -4

  mul t6, t6, t0 # number of bits

  add s0, s0, t6 # array

  readArr:
    addi t0, t0, -1
    ecall
    sw a0, 0(s0)
    addi s0, s0, 4
    bnez t0, readArr
  
  add t0, t0, t1

  # Passing parameters to func
  mv a0, t6
  li a1, 0
  jal ra, bubbleSort

  mv s0, t6 # move to beginning of array
  
  li a7, 1

  printArrElement:
    addi t0, t0, -1
    lw a0, 0(s0)
    ecall
    addi s0, s0, 4
    
    li a7, 11 # print separator
    li a0, ' '
    ecall
    li a7, 1
    
    bnez t0, printArrElement







