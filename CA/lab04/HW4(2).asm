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
  addi a7, zero, 5
  ecall
  add t1, zero, a0
  srli t0, a0, 31
  ecall
  add t4, zero, a0
  srli t3, a0, 31
  beq t1, zero, print_zero
  beq t4, zero, print_zero
  beq t0, zero, label1
  xori, t1, t1, -1
  addi t1, t1, 1
label1:
  beq t3, zero, label2
  xori t4, t4, -1
  addi t4, t4, 1
label2:
  bge t1, t4, label3
  xor t4, t4, t1
  xor t1, t4, t1
  xor t4, t4, t1
label3:
  add t2, zero, zero
label4:
  add t2, t2, t1
  addi t4, t4, -1
  blt zero, t4, label4

  xor t6, t0, t3
  beq t6, zero, label5
  xori t2, t2, -1 
  addi t2, t2, 1
label5:
  addi a7, zero, 1
  add a0, zero, t2
  ecall
  addi a7, zero, 10
  ecall

print_zero:
  addi a7, zero, 1
  add a0, zero, zero
  ecall
  addi a7, zero, 10
  ecall

# multip[lication of 2 numbers
# simply
read_int (x)
read_int (y)
mul t0, x, y
print_int (t0)






