[BITS 16]
[org 0x7C00]

start:
    mov si, PickMode
    call print_string
    call get_char
    mov dl,al           ; store the inputted char in dl so we can make use of al
    call check_mode
    call bob_speaks

bob_speaks:
    mov si, BobSpeaks
    call print_string
.startspeaking
    mov si, NormalWords
    call print_string
    cmp dl,0x31         ; check if we are in sport mode
    je .sportspeaking   ; if we are then output sport words too
    jmp .startspeaking
.sportspeaking
    mov si, SportWords
    call print_string
    jmp .startspeaking

check_mode:             ; dl contains the character inputted
    cmp dl,0x30         ; compare dl with ascii 0 (normal mode)
    jne .checksport     ; if we are not in normal mode try sport
    retn                ; we are in normal, return
.checksport
    cmp dl,0x31         ; compare dl with ascii 1 (spot mode)
    jne .checkfail      ; if it's not 1 then it must be invalid input so fail
    retn
.checkfail
    mov si, ModeFail    ; move the mode fail message to si to be printed
    call print_string
    jmp $               ; jump to far memory to hang

print_string:           ; Expects null terminated message in si
    mov al,[si]         ; Copy the character at si to register al
    or al,al            ; Comparing with itself will be 0 when al contains null
    jz  .end            ; Returns when al contains null
    inc si              ; Move one character down the string
    call print_char
    jmp print_string
.end:
    retn

print_char:
    mov ah,0x0E         ; Specifies that we want to write a character to the screen
    mov bl,0x07         ; Specifies output text color.  Not required, but useful to know
    mov bh,0x00         ; Page number.  Leave this alone.
    int 0x10            ; Signal video interrupt to BIOS
    retn

get_char:
    mov ah,0x00         ; Read character requires 0 in ah register
    int 0x16            ; Signal keyboard interrupt to BIOS
    call print_char     ; Reading a char will leave its ascii value in ah, print_char prints from ah
    retn                ; this should echo the char to the screen

;data
    PickMode db '[0] Normal Mode',0x0D,0x0A,'[1] Sport mode',0x0D,0x0A,0x0D,0x0A,'Pick a mode: ',0
    ModeFail db 0x0D,0x0A,'Invalid mode'
    BobSpeaks db 0x0D,0x0A,'Bob has something to say:',0x0D,0x0A,0x0D,0x0A
    NormalWords db 'beard',0x0D,0x0A,'beer',0x0D,0x0A,'pie',0x0D,0x0A
    SportWords db 'cricket',0x0D,0x0A,'rugby',0x0D,0x0A

TIMES 510 - ($ - $$) db 0
DW 0xAA55


