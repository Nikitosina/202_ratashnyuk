
.text
.macro newline
  li a7, 11
  li a0, '\n'
  ecall
.end_macro

.macro printline (%n, %char1, %char2)
  li a7, 11
  mv t0, %n
  li t1, 2
  _cycle:
    li a0, %char1
    ecall
    li a0, %char2
    ecall
    
    addi t0, t0, -1
    bnez t0, _cycle
    
    li a0, %char1
    ecall

.end_macro

main:
  li a7, 5
  ecall
  mv t2, a0 # m
  ecall
  mv t3, a0 # n

  while:
    printline (t2, '+', '-')
    newline
    printline (t2, '|', ' ')
    newline

    addi t3, t3, -1
    bgt t3, zero, while
  
  printline (t2, '+', '-')