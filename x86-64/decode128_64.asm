BITS 64

%define starting_black_bar     qword [rbp - 8]
%define bar_width              qword [rbp - 16]
%define line                   qword [rbp - 24]
%define bytes_until_data       qword [rbp - 32]
%define current_pattern        qword [rbp - 40]
%define processed_bar_counter  qword [rbp - 48]
%define processed_chars        qword [rbp - 56]
%define previous_char          qword [rbp - 64]
%define current_checksum       qword [rbp - 72]
%define previous_checksum      qword [rbp - 80]
%define decoded                qword [rbp - 88]
%define pixel_address_holder   qword [rbp - 96]

section .data

pattern_table:
    dd  0x6CC, 0x66C, 0x666, 0x498, 0x48C, 0x44C, 0x4C8, 0x4C4,
    dd  0x464, 0x648, 0x644, 0x624, 0x59C, 0x4DC, 0x4CE, 0x5CC,
    dd  0x4EC, 0x4E6, 0x672, 0x65C, 0x64E, 0x6E4, 0x674, 0x76E,
    dd  0x74C, 0x72C, 0x726, 0x764, 0x734, 0x732, 0x6D8, 0x6C6,
    dd  0x636, 0x518, 0x458, 0x446, 0x588, 0x468, 0x462, 0x688,
    dd  0x628, 0x622, 0x5B8, 0x58E, 0x46E, 0x5D8, 0x5C6, 0x476,
    dd  0x776, 0x68E, 0x62E, 0x6E8, 0x6E2, 0x6EE, 0x758, 0x746,
    dd  0x716, 0x768, 0x762, 0x71A, 0x77A, 0x642, 0x78A, 0x530,
    dd  0x50C, 0x4B0, 0x486, 0x42C, 0x426, 0x590, 0x584, 0x4D0,
    dd  0x4C2, 0x434, 0x432, 0x612, 0x650, 0x7BA, 0x614, 0x47A,
    dd  0x53C, 0x4BC, 0x49E, 0x5E4, 0x4F4, 0x4F2, 0x7A4, 0x794,
    dd  0x792, 0x6DE, 0x6F6, 0x7B6, 0x578, 0x51E, 0x45E, 0x5E8,
    dd  0x5E2, 0x7A8, 0x7A2, 0x5DE, 0x5EE, 0x75E, 0x7AE, 0x684,
    dd  0x690, 0x69C, 0x18EB


;===================================================================
section .text
global decode128_64

decode128_64:
    push rbp
    mov  rbp, rsp
    sub  rsp, 96

    
    push rax
    push rcx
    push rbx
    push r13
    push r12

    xor  rcx, rcx
    xor  rbx, rbx
    xor  rax, rax
    xor  r13, r13
    xor  r12, r12

    mov starting_black_bar, rax
    mov bar_width, rax
    mov line, rax
    mov decoded, rax
    mov bytes_until_data, rax
    mov current_pattern, rax
    mov processed_bar_counter, rax
    mov processed_chars, rax
    mov previous_char, rax
    mov previous_checksum, rax
    mov current_checksum, rax
    mov pixel_address_holder, rax

    ; decode128(unsigned char *source_bitmap, int scan_line_no, char *text);
    mov r13, rdi       ; source_bitmap
    mov rax, rsi      ; scan_line_no
    mov line, rax
    mov rax, rdx      ; text
    mov decoded, rax

move_to_line:
    mov rbx, line
    mov rax, 1800          ; 3*600
    mul rbx                ; rax = 1800 * line
    mov bytes_until_data, rax
    add r13, bytes_until_data   ; r13 points at the line to scan

look_for_first_black:
    cmp byte [r13], 0 ; look for first black pixel
    je first_black_found
    cmp rcx, 599 ; finish
    je error_barcode_not_found

    add r13, 3
    inc rcx
    jmp look_for_first_black

first_black_found:
    mov starting_black_bar, r13
    xor rcx, rcx

find_smallest_bar:
    cmp byte [r13], 0      ; if black keep counting
    jne smallest_bar_found
    inc rcx ; current bar width
    cmp rcx, 15
    je error_too_wide 
    add r13, 3
    jmp find_smallest_bar 

smallest_bar_found:
    mov rax, rcx
    mov rcx, 2
    div rcx                ; rax /= 2 amazingly found smallest bar, don't need to be like my riscv 
    mov bar_width, rax     ; bar_width = rax
    mov r13, starting_black_bar

; Reading symbols

start_setup:
    xor rax, rax
    mov current_pattern, rax
    mov processed_bar_counter, rax

setup_bar:
    xor rcx, rcx
read_bar:
    movzx rax, byte [r13]  ; 1 byte
    inc rcx ; in single bar counts pixels
    add r13, 3  ; next pixel
    cmp rcx, bar_width ; always multiplicity of bar_with
    je determine_color
    jmp read_bar

determine_color:
    cmp rax, 0x00000000
    je found_black_bar

found_white_bar:
    ; current_pattern |= 0
    mov rax, current_pattern
    or rax, 0
    mov current_pattern, rax

    ; processed_bar_counter++
    mov rax, processed_bar_counter
    inc rax
    cmp rax, 11
    je found_full_pattern ; finish one symbol
    mov processed_bar_counter, rax

    ; current_pattern <<= 1
    mov rax, current_pattern
    shl rax, 1
    mov current_pattern, rax

    jmp setup_bar

found_black_bar:
    ; current_pattern |= 1
    mov rax, current_pattern
    or rax, 1
    mov current_pattern, rax

    ; processed_bar_counter++
    mov rax, processed_bar_counter
    inc rax
    cmp rax, 11
    je found_full_pattern
    mov processed_bar_counter, rax

    ; current_pattern <<= 1
    mov rax, current_pattern
    shl rax, 1
    mov current_pattern, rax

    jmp setup_bar

; finally got 11 bits, check the table
found_full_pattern:
    mov processed_bar_counter, rax
    mov pixel_address_holder, r13
    xor rcx, rcx

    mov r13, pattern_table
    mov rax, current_pattern

compare_pattern:
    movsxd rbx, dword [r13 + rcx*4]  ; rcx == 0 get pattern_table[0], rcx == 1 get pattern_table[1]....
    cmp rbx, rax
    jne pattern_not_equal

pattern_equal:
    ; Code Set B: 
    ;   StartB = 104
    ;   Stop = 106
    ;   0..94 => ASCII(32..126)
    ;   95..102 => no output
    ;   103 => Start A => error
    ;   105 => Start C => error
    cmp rcx, 104
    je start_code          ; StartB
    cmp rcx, 105
    je error_invalid_set     
    cmp rcx, 103
    je error_invalid_set     

    ; calculate checksum and output normal char
    mov rax, processed_chars
    inc rax
    mov processed_chars, rax

    mov previous_char, rcx
    mul rcx
    mov previous_checksum, rax
    add rax, current_checksum
    mov current_checksum, rax

    ; to ascii
    mov rax, previous_char        
    add rax, 32           

    ; out one byte to [r12]
    mov r12, decoded     
    mov [r12], AL          
    inc r12
    mov decoded , r12     

    ; restore
    mov r13, pixel_address_holder
    jmp start_setup

pattern_not_equal:
    inc rcx 
    cmp rcx, 106
    je stop_sign
    jmp compare_pattern

; find start B and add it to checksum
start_code:
    mov current_checksum, rcx
    mov r13, pixel_address_holder
    jmp start_setup

; rcx=106 => Stop
stop_sign:
    xor rax, rax
    mov processed_bar_counter, rax
    mov r13, pixel_address_holder

extra_setup_bar:
    movzx rax, byte [r13]
    xor rcx, rcx
extra_read_bar:
    movzx rax, byte [r13]
    inc rcx
    add r13, 3
    cmp rcx, bar_width
    je extra_determine_color
    jmp extra_read_bar

extra_determine_color:
    cmp rax, 0x00000000
    je extra_found_black_bar

extra_found_white_bar:
    mov rax, current_pattern
    shl rax, 1
    or rax, 0
    mov current_pattern, rax

    mov rax, processed_bar_counter
    inc rax
    cmp rax, 2
    je extra_found_full_pattern
    mov processed_bar_counter, rax
    jmp extra_setup_bar

extra_found_black_bar:
    mov rax, current_pattern
    shl rax, 1
    or rax, 1
    mov current_pattern, rax

    mov rax, processed_bar_counter
    inc rax
    cmp rax, 2
    je extra_found_full_pattern
    mov processed_bar_counter, rax
    jmp extra_setup_bar

extra_found_full_pattern:
    mov pixel_address_holder, r13
    mov r13, pattern_table
    mov rcx, 106
    movsxd rbx, dword [r13 + rcx*4] 
    mov rax, current_pattern
    cmp rax, rbx
    je code_correct

error_checksum_invalid:
    mov rax, 2
    jmp quit

code_correct:
    mov rax, current_checksum
    mov rbx, previous_checksum
    sub rax, rbx       ; sub check cymbol itself
    mov rbx, 103
    div rbx            ; rax mod 103
    cmp rdx, previous_char 
    je quit_correct

;===================================================================
error_invalid_set:
    mov rax, 1
    jmp quit

error_barcode_not_found:
    mov rax, 3
    jmp quit

error_too_wide:
    mov rax, 4
    jmp quit

; remove check symbol, add 0 to the end
quit_correct:
    mov r12, decoded
    dec r12
    mov byte [r12], 0
    xor rax, rax

; epilogue
quit:
    pop r12
    pop r13
    pop rbx
    pop rcx
    mov rsp, rbp
    pop rbp
    ret
