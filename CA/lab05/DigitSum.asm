li a7, 5
ecall

add t1, zero, a0
li a7, 1
li t2, 10
bltz t1, positive
j loop

positive:
addi t3, zero, -1
mul t1, t1, t3

loop:
rem t3, t1, t2
add t4, t4, t3
div t1, t1, t2
bnez t1, loop

add a0, t4, zero
ecall

addi a7, zero, 5
ecall
add t0, zero, a0
addi t2, zero, -1
addi t5, zero, -1

loop1:
addi t0, t0, -1
ecall
mul t2, t2, t5
mul t4, a0, t2
add t3, t3, t4
blt zero, t0, loop1

li a7, 1
add a0, t3, zero
ecall
