
    .data
fname:          .asciz "2.bmp"
header_buf:     .space 54
nl:             .asciz "\n"
strDataOff:     .asciz "Data Offset: "
strWidth:       .asciz "Width: "
strHeight:      .asciz "Height: "
strError:       .asciz "File error!\n"

data_offset:    .word 0
width:          .word 0
height:         .word 0

buffer:         .space 200000
strMiddleLine:  .asciz "Middle line pixels (Blue values): "
space:          .asciz " "

barspace_buf:   .space 4000   # store up to 1000 segments (4 bytes each)
barspace_count: .word 0
strSegment:     .asciz "First 10 segments: "


    .text
    .global main
main:
    # Open the BMP file
    li a7, 1024          # file_open
    la a0, fname         # filename
    li a1, 0             # read-only mode
    ecall
    mv s1, a0            # s1 = file descriptor
    li t0, -1
    beq a0, t0, file_error

    # Read the first 54 bytes (BMP header + DIB header)
    li a7, 63            # file_read
    mv a0, s1
    la a1, header_buf
    li a2, 54
    ecall
    li t0, 54
    bne a0, t0, file_error

    # Close the file after reading header
    li a7, 57            # file_close
    mv a0, s1
    ecall

    # Parse data_offset, width, height
    la t1, header_buf

    # data_offset @0x0A
    addi t2, t1, 10
    lbu t3, 0(t2)
    lbu t4, 1(t2)
    lbu t5, 2(t2)
    lbu t6, 3(t2)
    slli t4, t4, 8
    slli t5, t5, 16
    slli t6, t6, 24
    add t3, t3, t4
    add t3, t3, t5
    add t3, t3, t6
    la t0, data_offset
    sw t3, 0(t0)

    # width @0x12 (18)
    addi t2, t1, 18
    lbu t3, 0(t2)
    lbu t4, 1(t2)
    lbu t5, 2(t2)
    lbu t6, 3(t2)
    slli t4, t4, 8
    slli t5, t5, 16
    slli t6, t6, 24
    add t3, t3, t4
    add t3, t3, t5
    add t3, t3, t6
    la t0, width
    sw t3, 0(t0)

    # height @0x16 (22)
    addi t2, t1, 22
    lbu t3, 0(t2)
    lbu t4, 1(t2)
    lbu t5, 2(t2)
    lbu t6, 3(t2)
    slli t4, t4, 8
    slli t5, t5, 16
    slli t6, t6, 24
    add t3, t3, t4
    add t3, t3, t5
    add t3, t3, t6
    la t0, height
    sw t3, 0(t0)

    # Print parsed results
    # Print Data Offset
    la a0, strDataOff
    li a7, 4
    ecall

    la t0, data_offset
    lw a0, 0(t0)
    li a7, 1
    ecall
    la a0, nl
    li a7, 4
    ecall

    # Print Width
    la a0, strWidth
    li a7,4
    ecall

    la t0, width
    lw a0,0(t0)
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

    # Print Height
    la a0, strHeight
    li a7,4
    ecall

    la t0,height
    lw a0,0(t0)
    li a7,1
    ecall
    la a0,nl
    li a7,4
    ecall

    # Print pixels
    # Reopen the file to read the entire image
    la a0, fname
    li a1, 0
    li a7, 1024   # file_open
    ecall
    mv s1, a0
    li t0, -1
    beq a0, t0, file_error

    # Read entire file into buffer
    li a7, 63     # file_read
    mv a0, s1
    la a1, buffer
    li a2, 200000
    ecall

    # Close the file
    li a7,57      # file_close
    mv a0,s1
    ecall

    # Compute the middle line start address
    la t0, height
    lw t1,0(t0)    # t1 = height
    srli t1,t1,1   # t1 = height/2

    la t0, width
    lw t2,0(t0)    # t2 = width
    li t3,3
    mul t4,t2,t3   # t4 = width*3 bytes per line
    mul t5,t1,t4   # t5 = (height/2)*(width*3)

    la t0, data_offset
    lw t6,0(t0)    # t6 = data_offset
    add t6,t6,t5   # t6 = data_offset + (height/2)*(width*3)
    
    # t6 now points to middle line offset in the file
    la t0, buffer
    add s2,t0,t6   # s2 points to the middle line pixel data in memory

    # Print all pixels' blue component
    la a0, strMiddleLine
    li a7,4
    ecall

    la t0, width
    lw t1,0(t0)    # t1 = width
    li t2,600      # print all pixels
print_pixels:
    beqz t2, print_done
    lbu t3,0(s2)   # B = first byte of pixel
    mv a0,t3
    li a7,1        # print_int
    ecall
    la a0, space
    li a7,4
    ecall

    addi s2,s2,3   # move to next pixel
    addi t2,t2,-1
    j print_pixels

print_done:
    la a0,nl
    li a7,4
    ecall

    # Exit 
    li a0,0
    li a7,93
    ecall

file_error:
    la a0, strError
    li a7,4
    ecall
    li a0,1
    li a7,93
    ecall


