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

main:
   # Recommended to run these tasks one by one, commenting others.
   # (x + 5) - (y - 7)
   read_int (x)
   read_int (y)
    
   li a0, 5
   li a1, 7
   add s0, x, a0
   sub s1, y, a1
   sub s0, s0, s1

   print_int (s0)
   newline

   # x >> 2 + (y - 1) << 3
   read_int (x)
   read_int (y)

   li a0, 1
   srli s0, x, 2
   sub s1, y, a0
   slli s1, s1, 3
   add s0, s0, s1

   print_int (s0)
   newline

   # x << y - 10
   read_int (x)
   read_int (y)

   li a0, 10
   sll s0, x, y
   sub s0, s0, a0

   print_int (s0)
   newline

   # x >> y + 10
   read_int (x)
   read_int (y)

   li a0, 10
   srl s0, x, y
   add s0, s0, a0

   print_int (s0)
   newline

   # (x << 2 - y + 5) >> 1
   read_int (x)
   read_int (y)

   slli s0, x, 2
   sub s0, s0, y
   addi s0, s0, 5
   srli s0, s0, 1

   print_int (s0)
   newline

   # x * 6 - y * 3
   # 6 = 110, 3 = 11
   read_int (x)
   read_int (y)

   slli a0, x, 1
   slli a1, x, 2
   slli a2, y, 1

   add s0, a0, a1
   add s1, y, a2
   sub s0, s0, s1

   print_int (s0)
   newline

   # 2 * x * x - 3 * y + 4
   read_int (x)
   read_int (y)

   li a0, 3
   li a1, 2
   mul s0, x, x
   mul s0, s0, a1

   mul s1, y, a0
   sub s0, s0, s1
   addi s0, s0, 4

   print_int (s0)
   newline

   # (x + 5) / y + 10 / (y - 1)
   read_int (x)
   read_int (y)

   li a0, 1
   li a1, 10
   addi s0, x, 5
   div s0, s0, y
   sub s1, y, a0
   div s1, a1, s1
   add s0, s0, s1

   print_int (s0)
   newline

   # (x / y) * y + x % y
   read_int (x)
   read_int (y)

   div s0, x, y
   mul s0, s0, y
   rem s1, x, y
   add s0, s0, s1

   print_int (s0)
   newline

   # x & (-1 << 5)
   read_int (x)

   li a0, -1
   slli s0, a0, 5
   and s0, s0, x

   print_int (s0)
   newline

   # x | (-1 >> 27)
   read_int (x)

   li a0, -1
   srli s0, a0, 27
   or s0, s0, x

   print_int (s0)
   newline

   # set the y-th bit of x to 1
   read_int (x)
   read_int (y)

   li a0, 1
   sll s0, a0, y
   or s0, x, s0

   print_int (s0)
   newline

   # reset the y-th bit of x to 0
   read_int (x)
   read_int (y)

   li a0, 2147483646
   li a1, 1
   sll s0, a0, y
   sub a2, y, a1
   sll a2, a1, a2
   or s0, s0, a2
   and s1, x, s0

   print_int (s1)
   newline

   # x > y ? 0 : 1
   # I will use default branch which is declared in the end for last tasks
   read_int (x)
   read_int (y)

   bgt x, y, if_x_greater_y
   j else

if_x_greater_y:
   print_imm_int (0)
   j default
else:
   print_imm_int (1)
   j default

   # (x == (y + 3)) ? 0 : 1
   read_int (x)
   read_int (y)

   addi s0, y, 3
   sub s0, x, s0

   beqz s0, is_equal
   j else1

if_equal:
   print_imm_int (0)
   j default
else1:
   print_imm_int (1)
   j default

   # x < -5 & y > 10     
   # x < -5; x + 5 < 0
   read_int (x)
   read_int (y)

   addi s0, x, 5
   li s1, 10
   bltz s0, if_x_less_minus_five
   j else2

if_x_less_minus_five:
   bgt y, s1, if_x_less_minus_five_and_y_greater_ten
   j else2
if_x_less_minus_five_and_y_greater_ten:
   print_imm_int (1)
   j default
else2:
   print_imm_int (0)
   j default


default:
