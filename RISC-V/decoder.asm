    .data

    # Code128 Code Set B pattern table 
pattern_table:
    # Value=0 (space) -> ASCII=32
    .word 2,1,2,2,2,2    #0 SP
    .word 2,2,2,1,2,2    #1 !
    .word 2,2,2,2,2,1    #2 "
    .word 1,2,1,2,2,3    #3 #
    .word 1,2,1,3,2,2    #4 $
    .word 1,3,1,2,2,2    #5 %
    .word 1,2,2,2,1,3    #6 &
    .word 1,2,2,3,1,2    #7 '
    .word 1,3,2,2,1,2    #8 (
    .word 2,2,1,2,1,3    #9 )
    .word 2,2,1,3,1,2    #10 *
    .word 2,3,1,2,1,2    #11 +
    .word 1,1,2,2,3,2    #12 ,
    .word 1,2,2,1,3,2    #13 -
    .word 1,2,2,2,3,1    #14 .
    .word 1,1,3,2,2,2    #15 /
    .word 1,2,3,1,2,2    #16 0
    .word 1,2,3,2,2,1    #17 1
    .word 2,2,3,2,1,1    #18 2
    .word 2,2,1,1,3,2    #19 3
    .word 2,2,1,2,3,1    #20 4
    .word 2,1,3,2,1,2    #21 5
    .word 2,2,3,1,1,2    #22 6
    .word 3,1,2,1,3,1    #23 7
    .word 3,1,1,2,2,2    #24 8
    .word 3,2,1,1,2,2    #25 9
    .word 3,2,1,2,2,1    #26 :
    .word 3,1,2,2,1,2    #27 ;
    .word 3,2,2,1,1,2    #28 <
    .word 3,2,2,2,1,1    #29 =
    .word 2,1,2,1,2,3    #30 >
    .word 2,1,2,3,2,1    #31 ?
    .word 2,3,2,1,2,1    #32 @
    .word 1,1,1,3,2,3    #33 A
    .word 1,3,1,1,2,3    #34 B
    .word 1,3,1,3,2,1    #35 C
    .word 1,1,2,3,1,3    #36 D
    .word 1,3,2,1,1,3    #37 E
    .word 1,3,2,3,1,1    #38 F
    .word 2,1,1,3,1,3    #39 G
    .word 2,3,1,1,1,3    #40 H
    .word 2,3,1,3,1,1    #41 I
    .word 1,1,2,1,3,3    #42 J
    .word 1,1,2,3,3,1    #43 K
    .word 1,3,2,1,3,1    #44 L
    .word 1,1,3,1,2,3    #45 M
    .word 1,1,3,3,2,1    #46 N
    .word 1,3,3,1,2,1    #47 O
    .word 3,1,3,1,2,1    #48 P
    .word 2,1,1,3,3,1    #49 Q
    .word 2,3,1,1,3,1    #50 R
    .word 2,1,3,1,1,3    #51 S
    .word 2,1,3,3,1,1    #52 T
    .word 2,1,3,1,3,1    #53 U
    .word 3,1,1,1,2,3    #54 V
    .word 3,1,1,3,2,1    #55 W
    .word 3,3,1,1,2,1    #56 X
    .word 3,1,2,1,1,3    #57 Y
    .word 3,1,2,3,1,1    #58 Z
    .word 3,3,2,1,1,1    #59 [
    .word 3,1,4,1,1,1    #60 \
    .word 2,2,1,4,1,1    #61 ]
    .word 4,3,1,1,1,1    #62 ^
    .word 1,1,1,2,2,4    #63 _
    .word 1,1,1,4,2,2    #64 `
    .word 1,2,1,1,2,4    #65 a
    .word 1,2,1,4,2,1    #66 b
    .word 1,4,1,1,2,2    #67 c
    .word 1,4,1,2,2,1    #68 d
    .word 1,1,2,2,1,4    #69 e
    .word 1,1,2,4,1,2    #70 f
    .word 1,2,2,1,1,4    #71 g
    .word 1,2,2,4,1,1    #72 h
    .word 1,4,2,1,1,2    #73 i
    .word 1,4,2,2,1,1    #74 j
    .word 2,4,1,2,1,1    #75 k
    .word 2,2,1,1,1,4    #76 l
    .word 4,1,3,1,1,1    #77 m
    .word 2,4,1,1,1,2    #78 n
    .word 1,3,4,1,1,1    #79 o
    .word 1,1,1,2,4,2    #80 p
    .word 1,2,1,1,4,2    #81 q
    .word 1,2,1,2,4,1    #82 r
    .word 1,1,4,2,1,2    #83 s
    .word 1,2,4,1,1,2    #84 t
    .word 1,2,4,2,1,1    #85 u
    .word 4,1,1,2,1,2    #86 v
    .word 4,2,1,1,1,2    #87 w
    .word 4,2,1,2,1,1    #88 x
    .word 2,1,2,1,4,1    #89 y
    .word 2,1,4,1,2,1    #90 z
    .word 4,1,2,1,2,1    #91 {
    .word 1,1,1,1,4,3    #92 |
    .word 1,1,1,3,4,1    #93 }
    .word 1,3,1,1,4,1    #94 ~
    .word 1,1,4,1,1,3    #95 DEL
    .word 1,1,4,3,1,1    #96 FNC 3
    .word 4,1,1,1,1,3    #97 FNC 2
    .word 4,1,1,3,1,1    #98 SHIFT
    .word 1,1,3,1,4,1    #99 CODE C
    .word 1,1,4,1,3,1    #100 FNC 4 
    .word 3,1,1,1,4,1    #101 CODE A
    .word 4,1,1,1,3,1    #102 FNC1
    .word 2,1,1,4,1,2    #103 Start A
    .word 2,1,1,2,1,4    #104 Start B
    .word 2,1,1,2,3,2    #105 Start C
    .word 2,3,3,1,1,1,2  #106 Stop

start_b_pattern: .word 2,1,1,2,1,4

decoded_buffer: .space 256
decoded_length: .word 0
buffer:         .space 200000
barspace_buf:   .space 4000
barspace_count: .word 0

accum:   .word 0     # accumulator
data_i:  .word 0     # i-th data
start_val: .word 0   # start symbol value


nl:             .asciz "\n"
space:          .asciz " "
fname:          .asciz "3.bmp"


check_symbol_fail: .asciz "Check symbol fails"
leftover_segments: .asciz "Leftover segments : "
symbol_index: .asciz "Current symbol Index : "
buffer_pointer: .asciz "Buffer pointer t5 : "
start_b_index:   .asciz "Found Start B at segment index: "
no_start_b:      .asciz "No Start B found.\n"
decode_complete: .asciz "Decoded string: "
symbol_candidate: .asciz "Symbol candidate segments: "
no_symbol_match:   .asciz "No symbol matched!\n"
special_symbol:   .asciz "Special symbol value: "
matched_symbol_value: .asciz "Matched symbol value: "
open_error:        	  .asciz "File error!\n"
initial_segment:      .asciz "Initial segments: "
normalized_segment:   .asciz "Normalized segments : "


value_to_char_table:
    # 0~94
    .byte 32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,
           48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,
           64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,
           80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,
           96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,
           112,113,114,115,116,117,118,119,120,121,122,123,124,125,126
    # 95~106 => 0
    .byte 0,0,0,0,0,0,0,0,0,0,0,0  

    .text
    .global main

main:
    # open file and read it to buffer
    li a7, 1024
    la a0, fname
    li a1, 0
    ecall
    mv s1, a0
    li t0, -1
    beq a0, t0, file_error

    li a7, 63
    mv a0, s1
    la a1, buffer
    li a2, 200000
    ecall

    li a7, 57
    mv a0, s1
    ecall
    
    li s3, 122  # data offset
    li s4, 600  # width
    li s5, 50   # height

    # compute middle line: t1=buffer+data_offset
    li t0, 3
    mul t6, s4, t0   # s4=600 => 600*3=1800
    
    srli s5, s5, 1   # s5=50/2
    addi s5, s5, -1   
    mul t6, t6, s5   # 24*1800=43200 which is the beginning of middle line
    add t6, t6, s3   # data_offset+43200=43322
    la t1, buffer
    add t1, t1, t6   # t1: pointer to middle line

    # convert 600 pixels to black/white segments in barspace_buf
    li t2, 600 # pixels
    li t3, 0 # current counting a white pixel
    li t4, 0 # current length of same color pixels
    la t5, barspace_buf
    li t6, 0 # segment counter

pix_loop:
    beqz t2, pix_done
    # compare (B+G+R)/3 with 128 
    lbu s3, 0(t1)
    lbu s4, 1(t1)
    lbu s5, 2(t1)
    add s3, s3, s4
    add s3, s3, s5
    li s6, 3
    div s3, s3, s6
    li s6, 128
    blt s3,s6, is_black

    beqz t3, white_cont # pixel is white
    
    sw t4, 0(t5)
    addi t5,t5,4
    addi t6,t6,1
    li t4,1
    li t3,0
    j pix_next

white_cont:
    addi t4,t4,1 # add length
    j pix_next

is_black:
    li t0,1
    beq t3,t0, black_cont # previous is black
    
    sw t4,0(t5) # previous is white
    addi t5,t5,4
    addi t6,t6,1
    li t4,1
    li t3,1
    j pix_next

black_cont:
    addi t4,t4,1

pix_next:
    addi t1,t1,3
    addi t2,t2,-1
    j pix_loop

pix_done:
    sw t4,0(t5)
    addi t5,t5,4
    addi t6,t6,1
    la t0, barspace_count 
    sw t6, 0(t0) # store how many segments we have to barspace_count 

    # print initail segments
    la a0, initial_segment
    li a7, 4
    ecall
    la t0, barspace_count
    lw t2, 0(t0)
    la t5, barspace_buf
    
print_segment:
    beqz t2, print_segment_done
    lw s3,0(t5)
    mv a0,s3
    li a7,1
    ecall
    la a0, space
    li a7,4
    ecall
    addi t5,t5,4 # move pointer to next word
    addi t2,t2,-1
    j print_segment

print_segment_done:
    la a0,nl
    li a7,4
    ecall

    # find minimal non-zero width => normalize => print
    la t0, barspace_count
    lw t2, 0(t0)
    la t5, barspace_buf
    mv t6, t2
    li t0, 999999
    
find_min_loop:
    beqz t6, min_found # no more segments, finish
    lw s3, 0(t5)
    beqz s3, skip_zero_min 
    blt s3,t0, new_min_min # update new minimal, store it in t0
    
skip_zero_min:
    addi t5,t5,4
    addi t6,t6,-1
    j find_min_loop

new_min_min:
    mv t0, s3
    addi t5,t5,4
    addi t6,t6,-1
    j find_min_loop

min_found:
    la t1, barspace_count
    lw t2, 0(t1)
    la t5, barspace_buf
    
norm_loop:
    beqz t2, norm_done
    lw s3, 0(t5)
    beqz s3, no_div # if it's zero, move the pointer
    div s3,s3,t0 # current segment/minimal = normalized segment
    sw s3, 0(t5)
    
no_div:
    addi t5,t5,4
    addi t2,t2,-1
    j norm_loop

norm_done:
    la a0, nl
    li a7,4
    ecall

    la a0, normalized_segment
    li a7,4
    ecall

    la t1, barspace_count
    lw t2, 0(t1)
    la t5, barspace_buf
    li t1, 300
print_norm_segments:
    beqz t1, norm_segment_done
    beqz t2, norm_segment_done
    lw s3, 0(t5)
    mv a0,s3
    li a7,1
    ecall
    la a0, space
    li a7,4
    ecall
    addi t5,t5,4
    addi t1,t1,-1
    addi t2,t2,-1
    j print_norm_segments

norm_segment_done:
    la a0, nl
    li a7,4
    ecall

    # =================== Find start B ===================
    la t0, barspace_count
    lw t2, 0(t0) # total segment number
    la t5, barspace_buf # buffer pointer
    li t1, 0 # current segment index
    li t3, 6 # 6 segments for one pattern
    la s2, start_b_pattern

find_start_b:
    mv s4,t2 # s4 = t2 - t1 = barspace_count - t1 < 6: end
    sub s4,s4,t1
    li t0,6
    blt s4,t0,no_start_b_found

    la t5, barspace_buf
    li s1,4
    mul s4,t1,s1
    add t5,t5,s4 # move t5 to 4*t1

    li s0,0 # how many segments matched
    
check_sb_loop:
    beq s0,t3, start_b_found
    lw s3,0(t5) # load current segment
    lw s6,0(s2) # load a segment from the start b pattern
    bne s3,s6, next_candidate
    addi t5,t5,4
    addi s2,s2,4
    addi s0,s0,1
    j check_sb_loop

next_candidate:
    addi t1,t1,1
    j find_start_b

no_start_b_found:
    la a0,no_start_b
    li a7,4
    ecall
    li a0,0
    li a7,93
    ecall

start_b_found:
    la a0,nl
    li a7,4
    ecall
    la a0,start_b_index
    li a7,4
    ecall
    mv a0,t1
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

  # check symbol
    li s5,104
    la t0,start_val
    sw s5,0(t0)

    la t0,accum
    sw s5,0(t0)
  #

    addi t1,t1,6 # jump to next part of 6 segments after finding start b
    
    # ========== Decode loop ==========
decode_loop: 
    # leftover = barspace_count - t1
    la t0, barspace_count
    lw t2, 0(t0)
    sub t2, t2, t1
    li t3,6

    la a0,nl
    li a7,4
    ecall

    la a0, leftover_segments
    li a7,4
    ecall
    mv a0,t2    
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall
    
    la a0, symbol_index
    li a7,4
    ecall
    mv a0,t1    
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall
    
    la a0, buffer_pointer
    li a7,4
    ecall
    mv a0,t5    
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

    # recalculate t5 = barspace_buf + t1*4 since these 6 segments start from a new place
    la t5, barspace_buf
    li s1,4
    mul s4,t1,s1
    add t5,t5,s4

    la a0,nl
    li a7,4
    ecall
    la a0, symbol_candidate
    li a7,4
    ecall

    # print 6 segments
    li s0,6
    mv s1,t5
    
print_6_segments:
    beqz s0, print_6_segment_done
    lw s3, 0(s1)
    mv a0,s3
    li a7,1
    ecall
    la a0,space
    li a7,4
    ecall
    addi s1,s1,4
    addi s0,s0,-1
    j print_6_segments
    
print_6_segment_done:
    la a0,nl
    li a7,4
    ecall

    # symbol_search
    la s7, pattern_table
    li s8,107 # max 107 to search, if it's 0 means symbol not found
    li s10,0 # symbol value

symbol_search:
    la a0,nl
    li a7,4
    ecall

    mv s11,t5 # store t5 to s11 in case of match failure
    beqz s8, symbol_not_found
    mv s9,s7 # current symbol starting segment
    li s0,0
    li t0,6
    
check_symbol_loop:
    beq s0,t0, symbol_match # if 6 segments match then it's a symbol
    lw s3,0(t5) # get barspace_buf current segment
    lw s6,0(s9) # get pattern table current segment

    # dispaly them 
    mv a0,s3
    li a7,1
    ecall
    la a0,space
    li a7,4
    ecall

    mv a0,s6
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall 
    
    # compare them
    bne s3,s6, next_symbol # try next symbol from the pattern table
    addi t5,t5,4
    addi s9,s9,4
    addi s0,s0,1 # counter++
    j check_symbol_loop

symbol_match:
    la a0,matched_symbol_value
    li a7,4
    ecall

    mv a0,s10
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

    li s4,106
    beq s10,s4, done_decoding

    # leftover is 14 segments means time for check symbol
    la t0, barspace_count
    lw t2, 0(t0)
    sub t2, t2, t1 # t2: the leftover
    li t3,14
    beq t2, t3, check_symbol

    # normal data
    li t0,103
    blt s10,t0, is_data_char

    j handle_special

check_symbol:
    # t4 is check symbol we calculated
    # compare accum % 103 and s10
    la t0, accum
    lw t2,0(t0)
    li t3,103
    rem t4, t2, t3
    
    mv a0,s10
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall
    mv a0,t4
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall
    
    bne t4, s10, check_fail
    
    # skip 6 segments, do not output
    addi t1,t1,6
    addi t5,t5,24
    j decode_loop

check_fail:
    # handle check failure
    la a0, check_symbol_fail
    li a7,4
    ecall
    j done_decoding

is_data_char:
    # convert s10 to ASCII
    la t0, value_to_char_table
    add t0,t0,s10
    lbu s0,0(t0) # one byte only

    # store into decoded_buffer
    la s1, decoded_length
    lw t2,0(s1)
    la t3, decoded_buffer
    add t3,t3,t2
    sb s0, 0(t3)
    addi t2,t2,1
    sw t2,0(s1)

    # accumulate for check symbol 
    # data_i => i-th data symbol
    la t0, data_i
    lw s1, 0(t0)
    addi s1, s1, 1      # i++
    sw s1, 0(t0)

    # accum += i * s10
    la t0, accum
    lw t2, 0(t0)        # t2 = accum
    mul t4, s1, s10     # t4 = i * symbol_value
    add t2, t2, t4      # accum += t4
    sw t2, 0(t0)
 
    # move to next symbol
    addi t1,t1,6
    addi t5,t5,24
    j decode_loop

next_symbol:
    mv t5,s11 # when match fails, restore it and compare from the beginning of the current 6 segments
    li s0,0

    la a0,matched_symbol_value
    li a7,4
    ecall
    mv a0,s10
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

    addi s7,s7,24
    addi s10,s10,1 # symbol value++
    addi s8,s8,-1 # all possible symbols
    j symbol_search

symbol_not_found:
    la a0,no_symbol_match
    li a7,4
    ecall
    j done_decoding

handle_special:
    la a0, special_symbol
    li a7, 4
    ecall

    mv a0, s10
    li a7, 1
    ecall
    la a0, nl
    li a7, 4
    ecall

    addi t5,t5,24
    j decode_loop

done_decoding:
    la t0,decoded_length # how many char are in buffer
    lw t1,0(t0)
    la t2,decoded_buffer
    add t2,t2,t1 # find the end
    li s0,0
    sb s0,0(t2) # add "\0" for print

    la a0,nl
    li a7,4
    ecall

    la a0,decode_complete
    li a7,4
    ecall

    la t0,decoded_buffer
    mv a0,t0
    li a7,4
    ecall
    la a0,nl
    li a7,4
    ecall

    li a0,0
    li a7,93
    ecall

file_error:
    la a0, open_error
    li a7,4
    ecall
    li a0,1
    li a7,93
    ecall
