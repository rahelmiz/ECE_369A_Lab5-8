pos1D:
 # &a0: address of the array containing the dimension information
 # a0[1] = width = number of cols in frame
 # a1 = row = row number in 2D array
 # a2 = col = col number in 2D array

    lw $s0, 4($a0) # s0 = asize_[1]
    mul $s1, $a1, $s0  # s1 = row * width
    add $v0, $s1, $a2 # v0 = (row * width) + col
    jr $ra

pos2D:
# pos2D functionality:
# given position in 1D array, and width of orig 2D array, map the
# 1D location back to row, col in the 2D array.

# &a0: address of the array containing the dimension information
# $a0[1] : width (i.e number of cols) of 2d array
# $a1: pos1D , the location of elem in 1D array
# $v0: row idx of elem in 2-D array$
# $v1: col idx of elem in 2-D array$

addi $s0, $zero, $zero # s0 = count = 0
addi $s1, $a1, $zero #s1 = pos1D = res
lw $s2, 4($a0) # s2 = width
    loop:
    sub $s1, $s1, $s2 # res = res - width
    addi $s0, $s0, 1 # count = count + 1
    slt $t0, $s1, $s2 # t1 = 1 if res < width
    bneq $t0, $zero, loop # loop until res < width
addi $v0, $s0, $zero #v0 = count; gives the row number
addi $v1, $s1, $zero #v1 = res; gives the col number
jr $ra
