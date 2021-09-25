
.data
# test input
# asize : dimensions of the frame [i, j] and window [k, l]
#         i: number of rows,  j: number of cols
#         k: number of rows,  l: number of cols
# frame : frame data with i*j number of pixel values
# window: search window with k*l number of pixel values
#
# $v0 is for row / $v1 is for column

# test 0 For the 4x4 frame size and 2X2 window size
# small size for validation and debugging purpose
# The result should be 0, 2

col0: .word 0
row0: .word 0
# frame0[0,0] = 0
# window0[0,0] = 1

#### Rahel's print variables
message1: .ascii "the 1d position is "
message2: .ascii "given the 2D positions"
newline: .asciiz     "\n"
comma: .ascii ", "

### end Rahel's variables
asize0:  .word    4,  4,  2, 2    #i, j, k, l
frame0:  .word    0,  0,  1,  2,
         .word    0,  0,  3,  4
         .word    0,  0,  0,  0
         .word    0,  0,  0,  0,
window0: .word    1,  2,
         .word    3,  4,


# test 1 For the 16X16 frame size and 4X4 window size
# The result should be 12, 12
col1: .word 1
row1: .word 1
# frame1[1,1] = 2
# window1[1,1] 2
asize1:  .word    16, 16, 4, 4    #i, j, k, l
frame1:  .word    0, 1, 2, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
         .word    1, 2, 3, 4, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
         .word    2, 3, 32, 1, 2, 3, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30,
         .word    3, 4, 1, 2, 3, 4, 18, 21, 24, 27, 30, 33, 36, 39, 42, 45,
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60,
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 50, 55, 60, 65, 70,  75,
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 60, 66, 72, 78, 84, 90,
         .word    0, 4, 14, 21, 28, 35, 42, 49, 56, 63, 70, 77, 84, 91, 98, 105,
         .word    0, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, 104, 112, 120,
         .word    0, 9, 18, 27, 36, 45, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135,
         .word    0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150,
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165,
         .word    0, 12, 24, 36, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3,
         .word    0, 13, 26, 39, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4,
         .word    0, 14, 28, 42, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5,
         .word    0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6
window1: .word    0, 1, 2, 3,
         .word    1, 2, 3, 4,
         .word    2, 3, 4, 5,
         .word    3, 4, 5, 6

# test 2 For the 16X16 frame size and a 4X8 window size
# The result should be 0, 4
# frame2[2,2] = 8
# window2[2,2]= 0
asize2:  .word    16, 16, 4, 8    #i, j, k, l
frame2:  .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
         .word    7, 5, 8, 8, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0,
         .word    0, 4, 2, 3, 4, 5, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60,
         .word    0, 5, 3, 4, 5, 6, 30, 35, 40, 45, 0, 0, 0, 0, 70,  75,
         .word    0, 6, 12, 18, 24, 30, 36, 42, 48, 54, 0, 0, 0, 0, 84, 90,
         .word    0, 4, 8, 8, 8, 8, 42, 49, 56, 63, 0, 0, 0, 0, 98, 105,
         .word    0, 1, 8, 8, 8, 8, 48, 56, 64, 72, 0, 0, 0, 0, 112, 120,
         .word    0, 1, 8, 8, 8, 8, 54, 63, 72, 81, 90, 99, 108, 117, 126, 135,
         .word    0, 10, 8, 8, 8, 8, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150,
         .word    0, 11, 22, 33, 44, 55, 66, 77, 88, 99, 110, 121, 132, 143, 154, 165,
         .word    9, 9, 9, 9, 48, 60, 72, 84, 96, 108, 120, 132, 0, 1, 2, 3,
         .word    9, 9, 9, 9, 52, 65, 78, 91, 104, 114, 130, 143, 1, 2, 3, 4,
         .word    9, 9, 9, 9, 56, 70, 84, 98, 112, 126, 140, 154, 2, 3, 4, 5,
         .word    9, 9, 9, 9, 60, 75, 90, 105, 120, 135, 150, 165, 3, 4, 5, 6
window2: .word    0, 0, 0, 0, 0, 0, 0, 0,
         .word    0, 0, 0, 0, 0, 0, 0, 0,
         .word    0, 0, 0, 0, 0, 0, 0, 0,
         .word    0, 0, 0, 0, 0, 0, 0, 0
######################################################################
# test 14 For the 4X4 frame and a 4X4 window size
# use this test case for validation and debugging purpose.
# The result should be 0, 0
asize14: .word    4, 4, 4, 4    #i, j, k, l
frame14: .word    9, 9, 9, 9,
         .word    9, 9, 9, 9,
         .word    9, 9, 9, 9,
         .word    9, 9, 9, 9
                  
window14:   .word    9, 9, 9, 9,
            .word    9, 9, 9, 9,
            .word    9, 9, 9, 9,
            .word    9, 9, 9, 9

############################################### main #######################################################

.text

.globl main

main:
    addi    $sp, $sp, -4    # Make space on stack
    sw      $ra, 0($sp)     # Save return address
         
    # Test0 for getFrame1Dvalue
    ############################################################
    la      $a0, asize0     # 1st parameter: address of asize1[0]
    li      $s1, 0
    li      $s2, 0
    la      $a1, frame0
    la      $a2, window0
    jal     getFrame1Dvalue           # call function
    #jal     printResult    # print results to console
    
    ############################################################
    # End Test0 for getFrame1Dvalue

    # Test0 for getWindow1Dvalue
    ############################################################
    la      $a0, asize0     # 1st parameter: address of asize1[0]
    li      $s1, 0
    li      $s2, 0
    la      $a1, frame0
    la      $a2, window0
    jal     getWindow1Dvalue           # call function
    #jal     printResult    # print results to console

    ############################################################
    # End Test0 for getWindow1Dvalue

   


################### Print Result ####################################
print_result:
    # Printing $v0
    add     $a0, $v0, $zero     # Load $v0 for printing
    li      $v0, 1              # Load the system call numbers
    syscall
   
    # Print newline.
    la      $a0, newline          # Load value for printing
    li      $v0, 4                # Load the system call numbers
    syscall
   
    # Printing $v1
    add     $a0, $v1, $zero      # Load $v1 for printing
    li      $v0, 1                # Load the system call numbers
    syscall

    # Print newline.
    la      $a0, newline          # Load value for printing
    li      $v0, 4                # Load the system call numbers
    syscall
   
    # Print newline.
    la      $a0, newline          # Load value for printing
    li      $v0, 4                # Load the system call numbers
    syscall
   
    jr      $ra                   #function return

#####################################################################
### vbsme
#####################################################################




.text
.globl  vbsme

# Your program must follow the required search pattern.

# Preconditions:
#   1st parameter (a0) address of the first element of the dimension info (address of asize[0])
#   2nd parameter (a1) address of the first element of the frame array (address of frame[0][0])
#   3rd parameter (a2) address of the first element of the window array (address of window[0][0])
# Postconditions:
#   result (v0) x coordinate of the block in the frame with the minimum SAD
#          (v1) y coordinate of the block in the frame with the minimum SAD


# Begin subroutine
vbsme:
    li      $v0, 0              # reset $v0 and $V1
    li      $v1, 0

    # insert your code here
   
getFrame1Dvalue:
# &a0: address of the array containing the dimension information
# a0[0] = number of rows in frame
# a0[1] = number of cols in frame
# a0[2] = number of rows in window
# a0[3] = number of cols in window
# s1 = row, the row pos
# s2 = col, the col pos

# a1 = frame_array
# a2 = window array
    lw $s0, 4($a0) # s0 = asize_[1] = frame_width
    mul $t0, $s1, $s0  # t0 = row * frame_width
    add $t0, $t0, $s2 # t0 = (row * frame_width) + col = idx_1d
    sll $t0, $t0, 2 # t0 = 4* idx_1d = idx_1d
    add $t0, $t0, $a1 # t0 = idx_1d + &frame_array[0] = idx_1d
    lw $t0
    lw $v0, 0($t0) #v0 = frame_array[idx]
    jr $ra
    
getWindow1Dvalue:
# &a0: address of the array containing the dimension information
# a0[0] = number of rows in frame
# a0[1] = number of cols in frame
# a0[2] = number of rows in window
# a0[3] = number of cols in window
# a1 = frame_array
# a2 = window array

# s1 = row, the row pos
# s2 = col, the col pos

    lw $s0, 12($a0) # s0 = asize_[3] = window_width
    mul $t0, $s1, $s0  # t0 = idx = row * window_width
    add $t0, $t0, $s2 # t0 = idx_1d = (row * window_width) + col
    sll $t0, $t0, 2 # t0 = 4* idx_1d
    add $t0, $t0, $a2 # t0 = idx_1d + &window_array[0]
    lw $v0, 0($t0) #v0 = window_array[idx]
    jr $ra

