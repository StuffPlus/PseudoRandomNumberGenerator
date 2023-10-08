; Pseudo Random Number generator

ldi r16, $45 ; pre-seeded number
ldi r30, $00 ; counter
; xor the bottom 2 bits
randloop: bst r16, 0 ; store bit 0 of the register r16 into the T bit copy storage
bld r17, 0 ; load whats in T into bit 0 of r17
bst r16, 1 ; store bit 1 into T bit copy storage
bld r18, 0 ; load T into bit 0 of r18
eor r17, r18 ; xor r17 and r18 together and store into r17

; right shift the number once
lsr r16

; left shitf the xor results 7 times
ldi r31, $00 ; this is the counter
shift7loop: lsl r17 ; left shift r17 once
inc r31 ; add one to the counter
cpi r31, 7 ; check if the counter has reached 7
brne shift7loop ; branch back to the start of the loop if not equal
; set the msb of the number with the xor result and store into r16
or r16, r17

; to check if the number is between 01-59 HEX value
ldi r22, $59 ; store the maximun value into r22 
ldi r23, $01 ; store the minimun value into r23
clr r21 ; clear r21 just in case there are values stored within
or r21, r16 ; copy r16 into r21 
sub r22, r21 ; subtract r22 from r21
brcs randloop ; if their is a carry value then branch back to the beginning to generate a new number
sub r21, r23 ; subtract r21 from r23
brcs randloop ; branch if there is a carry value back to the beginning to generate a new number

; store the msb and the lsb of the final result
bst r16, 7 ; store the msb of r16 into T
bld r19, 7 ; load the bit into r19
bst r16, 0 ; store the lsb of r16 into T
bld r20, 0 ; load the bit into r20
out $1b, r19 ; store the msb into port a
out $18, r20 ; store the lsb into port b

inc r30 ; increment the counter
cpi r30, 6 ; check if the counter has reached 6
brne randloop ; branch back to the beginning
breq end ; goes the end function

end: rjmp end ; infinitely loop at the end to stop the program from running again.









