vbsme:
    li      $v0, 0              # reset $v0 and $V1
    li      $v1, 0

    # insert your code here
   
    
    #int SAD(int positionI, int positionJ, int arr[5][5], int rowsW, int colsW, int window[2][2]) {
    #int total = 0;
    #//take pairwise pixel differences
    #//take absolute value of each difference
    #//accumulate all
    #for (int i = 0; i < rowsW; ++i) {
    #    for (int j = 0; j < colsW; ++j) {
    #        total = total + abs(arr[i + positionI][j + positionJ] - window[i][j]);
    #    }
    #}
    #//best match is the one that is closest to zero
    #return total;
    
    #change all $a, set to an $s that is reset to $a each loop

    SAD:
        #set up arguments
        add $s0, $a3, $zero #s0 = orig i sent by Search
        lw  $s1, 0($sp) #s1 = a4 [by our convention, sp points to mem[sp-36] (from Search)]
        #set an i and total value
        add $s2, $zero, $zero #s2 = i = 0
        add $s4, $zero, $zero #total

        #set up loops for i and j
    goThruRow: #outer loop
        add $s3, $zero, $zero #j = 0
    goThruCol: #inner loop
        
        #PREPARE STACK FOR FUNC CALL: store all of the s registers in use until this point so Rahel can use all the s registers
        addi $sp, $sp, -24 #need 6 slots in stack
        sw $s3, 0($sp) # store s3 for callee to use as "j". a4 MUST be in sp[0]
        sw $s0, 4($sp) # store s4 so that calle can use s4 reg.
        sw $s1, 8($sp)
        sw $s2, 12($sp)
        sw $s4, 16($sp)
        sw $ra, 20($sp)
        #ask for 1D array position for the window
        #preparing to send i, j to getFrameValue
        add $a3, $s2, $zero #a3 = i
        #CALL GETWINDOW1DVALUE
        jal getWindow1Dvalue #v0 = res of getWindow1Dvalue
        
        #restore the stack:
        lw $s3, 0($sp) #s3 = mem[sp+0] , i.e we retrieved its value from (before we called the function)
        #from memory
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        lw $s4, 16($sp)
        lw $ra, 20($sp)
        $sp, $sp, 24 #restore stack

        add $s7, $v0, $zero #s7 = result of getWindow1DValue

        # PREPARE STACK FOR FUNC CALL: store all of the s registers in use
        # until this point so Rahel can use all the s registers
        addi $sp, $sp, -28 #need 7 slots in stack:
        #same ones from prev call + 1 more to s7, the only additional variable
        sw $s3, 0($sp) # store s3 for callee to use as "j". a4 MUST be in sp[0]
        sw $s0, 4($sp) # store s4 so that calle can use s4 reg.
        sw $s1, 8($sp)
        sw $s2, 12($sp)
        sw $s4, 16($sp)
        sw $ra, 20($sp)
        sw $s7, 20($sp)
        sw $ra, 24($sp)
        jal getFrame1Dvalue #returns value in $v0 for field

        add $a3, $s2,$s0  # a3 = i + row_sent_by_search() ; this will be sent to getValue()
        add $a2, $s3, $s1 # a2 = j + col_sent_by_search() ; this will be sent to getValue()
        
        #      restore the values stored in stack into registers        #
        lw $s3, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)
        lw $s2, 12($sp)
        lw $s4, 16($sp)
        lw $s7, 20($sp)
        lw $ra, 24($sp)
        # restore the stack pointer      #
        addi $sp, $sp, 28

        
        #subtract field from window
        sub $s5, $v0, $s7 # s5 = frame[i + row][j + column] - window[i][j]
        #take absolute value of $s5
        ori $s6, $zero, $s5     #s6 = s5
        slt $t1, $s5, $zero     #t1 = 1 if (frame[i][j] - window[i][j] < 0)
        beq $t1, $zero, skipabs    #if it is positive we skip swapping them
        sub $s6, $zero, $s5 #frame[i + row][j + column] - window[i][j] = |frame[i + row][j + column] - window[i][j]|
    skipabs:
        add $s4, $s4, $s6 #totalSum = totalSum + (frame[i + row][j + column] - window[i][j])
        addi $s3, $s3, 1 #j = j+1
        #need to know what rowsW and colsW are for register values, temp using rowsW = $s0, colsW = $s1
        slt $t0, $s3, $s1 #t0 = 1 if j < colW
        bne $t0, $zero, goThruCol #loop thru j until all the cols are checked
        addi $s2, $s2, 1 # i = i +1
        slt $t0, $s2, $s0 #t0 = 1 if i < row
        bne $t0, $zero, goThruRow #loop thru i until all the rows are checked
        #done with loops, returns v1 as the total value
        add $v1, $s4, $zero #v0 = totalSum. this will be returned to Search (i.e it won't be stored in stack)
        jr $ra


restore:
    lw $s0, 4($sp)
    lw $s1, 8($sp)
    lw $s2, 12($sp)
    lw $s4, 16($sp)
  
