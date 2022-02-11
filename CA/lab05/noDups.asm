.text
main:
li a7, 5
ecall

mv t0, a0 # number of ints
addi t6, zero, -4
mul t6, t6, t0 # space for all ints
addi t5, zero, 1 # iterator i
add s0, s0, t6 # array

ecall # put first element manually
sw a0, 0(s0)
addi t0, t0, -1
addi s0, s0, 4

loop:
add s0, zero, t6 # move to the beginning of array
beqz t0, skip
addi t0, t0, -1
addi t4, zero, 0 # iterator j
ecall # a0 = new int

loop2:
addi t4, t4, 1
lw t3, 0(s0)
addi s0, s0, 4

beq t3, a0, loop # if found existing element
blt t4, t5, loop2 # iterate j till j = i

addi s0, s0, -4
addi t5, t5, 1
sw a0, 0(s0) # store element if not present in array
blt zero, t0, loop

skip:
add s0, zero, t6
addi t5, t5, -1

output:        
addi t5, t5, -1
lw t3, 0(s0)
addi s0, s0, 4
beqz t3, output

li a7, 11
li a0, '\n'
ecall
li a7, 1
add a0, t3, zero
ecall

blt zero, t5, output




