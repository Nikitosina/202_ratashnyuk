   .macro print_int (%x)
   li a7, 1
   mv a0, %x
   ecall
   .end_macro

   .macro print_imm_int (%x)
   li a7, 1
   li a0, %x
   ecall
   .end_macro

   .macro newline
   li a7, 11
   li a0, '\n'
   ecall
   .end_macro
   
   .macro read_int(%x)
   li a7, 5
   ecall
   mv %x, a0
   .end_macro

   .eqv x t0
   .eqv y t1


    .data
hello:
    .string "Hello, ACOS"

    .text
main:
  lui t1, 444102
  addi t1, t1, 1352
  lui t2, 266755
  addi t2, t2, -913
  lui t3, 1333
  addi t3, t3, -189
  lui s0, 65552
  addi s0, s0, 0
  sw t1, 0(s0)
  sw t2, 4(s0)
  sw t3, 8(s0)
  addi a7, zero, 4
  add a0, zero, s0
  ecall
# Output: Hello, ACOS
# simplifying
  newline

  li a7, 4
  la a0, hello
  ecall
 