;===================================================================
;  Code Set B decoder
;===================================================================

%define starting_black_bar   [EBP-4] ; address of the first black pixel
%define bar_width            [EBP-8]  ; smallest bar
%define line                 [EBP-12]
%define bytes_until_data     [EBP-16] ; offset
%define current_pattern      [EBP-20] ; current pattern to compare with pattern table
%define processed_bar_counter[EBP-24] ; 11 means a full pattern
%define processed_chars      [EBP-28]
%define previous_char        [EBP-32]
%define current_checksum     [EBP-36]
%define previous_checksum    [EBP-40]
%define decoded              [EBP-44] ;char pointer to buffer
%define pixel_address_holder [EBP-48]

;===================================================================
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
global decode128

decode128:
    ; prologue
    push EBP
    mov  EBP, ESP
    sub  ESP, 48            

    push EAX
    push ECX
    push EBX
    push ESI
    push EDI

    xor  ECX, ECX
    xor  EBX, EBX
    xor  EAX, EAX
    xor  ESI, ESI
    xor  EDI, EDI

    mov starting_black_bar, EAX
    mov bar_width, EAX
    mov line, EAX
    mov decoded, EAX
    mov bytes_until_data, EAX
    mov current_pattern, EAX
    mov processed_bar_counter, EAX
    mov processed_chars, EAX
    mov previous_char, EAX
    mov previous_checksum, EAX
    mov current_checksum, EAX
    mov pixel_address_holder, EAX

    ; decode128(unsigned char *source_bitmap, int scan_line_no, char *text);
    mov ESI, [EBP+8]       ; source_bitmap
    mov EAX, [EBP+12]      ; scan_line_no
    mov line, EAX
    mov EAX, [EBP+16]      ; text
    mov decoded, EAX

move_to_line:
    mov EBX, line
    mov EAX, 1800          ; 3*600
    mul EBX                ; EAX = 1800 * line
    mov bytes_until_data, EAX
    add ESI, bytes_until_data   ; ESI points at the line to scan

look_for_first_black:
    cmp byte [ESI], 0 ; look for first black pixel
    je first_black_found
    cmp ECX, 599 ; finish
    je error_barcode_not_found

    add ESI, 3
    inc ECX
    jmp look_for_first_black

first_black_found:
    mov starting_black_bar, ESI
    xor ECX, ECX

find_smallest_bar:
    cmp byte [ESI], 0      ; if black keep counting
    jne smallest_bar_found
    inc ECX ; current bar width
    cmp ECX, 15
    je error_too_wide 
    add ESI, 3
    jmp find_smallest_bar 

smallest_bar_found:
    mov EAX, ECX
    mov ECX, 2
    div ECX                ; EAX /= 2 amazingly found smallest bar, don't need to be like my riscv 
    mov bar_width, EAX     ; bar_width = EAX
    mov ESI, starting_black_bar

; Reading symbols

start_setup:
    xor EAX, EAX
    mov current_pattern, EAX
    mov processed_bar_counter, EAX

setup_bar:
    xor ECX, ECX
read_bar:
    movzx EAX, byte [ESI]  ; 1 byte
    inc ECX ; in single bar counts pixels
    add ESI, 3  ; next pixel
    cmp ECX, bar_width ; always multiplicity of bar_with
    je determine_color
    jmp read_bar

determine_color:
    cmp EAX, 0x00000000
    je found_black_bar

found_white_bar:
    ; current_pattern |= 0
    mov EAX, current_pattern
    or EAX, 0
    mov current_pattern, EAX

    ; processed_bar_counter++
    mov EAX, processed_bar_counter
    inc EAX
    cmp EAX, 11
    je found_full_pattern ; finish one symbol
    mov processed_bar_counter, EAX

    ; current_pattern <<= 1
    mov EAX, current_pattern
    shl EAX, 1
    mov current_pattern, EAX

    jmp setup_bar

found_black_bar:
    ; current_pattern |= 1
    mov EAX, current_pattern
    or EAX, 1
    mov current_pattern, EAX

    ; processed_bar_counter++
    mov EAX, processed_bar_counter
    inc EAX
    cmp EAX, 11
    je found_full_pattern
    mov processed_bar_counter, EAX

    ; current_pattern <<= 1
    mov EAX, current_pattern
    shl EAX, 1
    mov current_pattern, EAX

    jmp setup_bar

; finally got 11 bits, check the table
found_full_pattern:
    mov processed_bar_counter, EAX
    mov pixel_address_holder, ESI
    xor ECX, ECX

    mov ESI, pattern_table
    mov EAX, current_pattern

compare_pattern:
    mov EBX, [ESI + ECX*4] ; ECX == 0 get pattern_table[0], ECX == 1 get pattern_table[1]....
    cmp EBX, EAX
    jne pattern_not_equal

pattern_equal:
    ; Code Set B: 
    ;   StartB = 104
    ;   Stop = 106
    ;   0..94 => ASCII(32..126)
    ;   95..102 => no output
    ;   103 => Start A => error
    ;   105 => Start C => error
    cmp ECX, 104
    je start_code          ; Start B
    cmp ECX, 105
    je error_invalid_set     
    cmp ECX, 103
    je error_invalid_set     

    ; calculate checksum and output normal char
    mov EAX, processed_chars
    inc EAX
    mov processed_chars, EAX

    mov previous_char, ECX
    mul ECX
    mov previous_checksum, EAX
    add EAX, current_checksum
    mov current_checksum, EAX

    ; to ascii
    mov EAX, previous_char        
    add EAX, 32           

    ; out one byte to [EDI]
    mov EDI, decoded     
    mov [EDI], AL          
    inc EDI
    mov decoded , EDI     

    ; restore
    mov ESI, pixel_address_holder
    jmp start_setup

pattern_not_equal:
    inc ECX 
    cmp ECX, 106
    je stop_sign
    jmp compare_pattern

; find start B and add it to checksum
start_code:
    mov current_checksum, ECX
    mov ESI, pixel_address_holder
    jmp start_setup

; ECX=106 => Stop
stop_sign:
    xor EAX, EAX
    mov processed_bar_counter, EAX
    mov ESI, pixel_address_holder

extra_setup_bar:
    movzx EAX, byte [ESI]
    xor ECX, ECX
extra_read_bar:
    movzx EAX, byte [ESI]
    inc ECX
    add ESI, 3
    cmp ECX, bar_width
    je extra_determine_color
    jmp extra_read_bar

extra_determine_color:
    cmp EAX, 0x00000000
    je extra_found_black_bar

extra_found_white_bar:
    mov EAX, current_pattern
    shl EAX, 1
    or EAX, 0
    mov current_pattern, EAX

    mov EAX, processed_bar_counter
    inc EAX
    cmp EAX, 2
    je extra_found_full_pattern
    mov processed_bar_counter, EAX
    jmp extra_setup_bar

extra_found_black_bar:
    mov EAX, current_pattern
    shl EAX, 1
    or EAX, 1
    mov current_pattern, EAX

    mov EAX, processed_bar_counter
    inc EAX
    cmp EAX, 2
    je extra_found_full_pattern
    mov processed_bar_counter, EAX
    jmp extra_setup_bar

extra_found_full_pattern:
    mov pixel_address_holder, ESI
    mov ESI, pattern_table
    mov ECX, 106
    mov EBX, [ESI + ECX*4]
    mov EAX, current_pattern
    cmp EAX, EBX
    je code_correct

error_checksum_invalid:
    mov EAX, 2
    jmp quit

code_correct:
    mov EAX, current_checksum
    mov EBX, previous_checksum
    sub EAX, EBX       ; sub check cymbol itself
    mov EBX, 103
    div EBX            ; EAX mod 103
    cmp EDX, previous_char 
    je quit_correct

;===================================================================
error_invalid_set:
    mov EAX, 1
    jmp quit

error_barcode_not_found:
    mov EAX, 3
    jmp quit

error_too_wide:
    mov EAX, 4
    jmp quit

; remove check symbol, add 0 to the end
quit_correct:
    mov EDI, decoded
    dec EDI
    mov byte [EDI], 0
    xor EAX, EAX

; epilogue
quit:
    pop EDI
    pop ESI
    pop EBX
    pop ECX
    mov ESP, EBP
    pop EBP
    ret
