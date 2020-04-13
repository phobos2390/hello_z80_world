; file: main.asm

#define stdout_addr $8000
#define grid_iter $8001
#define key_buffer_size $E000
#define key_buffer $E001
#define cursor_val $E002
#define key_input_location $8002
#define interrupt_data $DF00
#define tileset_start $2000
#define tileset_height $8
#define ts_space_start $2000 + (' ' * $8) 
#define grid_height $10
#define grid_width $10
#define grid_width_h $08
#define display_start $2800
#define display_end display_start + (grid_height * grid_width)
#define cursor_key $8F

start:
  jp main

isr_table:
.db isr_start
.db $0

isr_start:
  di
  ex af,af'
  exx

  ld a, (key_input_location)
  ld (key_buffer), a
  ld a, $0  
  ld (key_input_location), a

  exx
  ex af,af'  
  ret
  
main:
  call load_tileset
  call init_cursor_val
  ld hl, intro_message
  call print_hl
  im 2
  ld hl, isr_table
  ld a, h
  ld i, a
  ld a, l
  ld (interrupt_data), a
main_loop:
  call print_cursor
  ei
  halt
main_process_input:
  ld a, (key_buffer)
  sub '\n'
  jp z, main_print_nl
  add a, '\n'
  sub $01
  jp z, main_up
  add a, $01
  sub $02
  jp z, main_down
  add a, $02
  sub $03
  jp z, main_left
  add a, $03
  sub $04
  jp z, main_right
  add a, $04
  sub $08
  jp z, main_backspace
  add a, $08
  ld (stdout_addr), a
  call store_cursor_val
  jp main_loop
main_print_nl:
  call print_newline
  jp main_loop
main_up:
  ld a, (cursor_val)
  ld (stdout_addr), a
  ld a, (grid_iter)
  sub a, grid_width
  dec a
  ld (grid_iter), a
  call store_cursor_val
  jp main_loop
main_down:
  ld a, (cursor_val)
  ld (stdout_addr), a
  ld a, (grid_iter)
  add a, grid_width
  dec a
  ld (grid_iter), a
  call store_cursor_val
  jp main_loop
main_left:
  ld a, (cursor_val)
  ld (stdout_addr), a
  ld a, (grid_iter)
  dec a
  dec a
  ld (grid_iter), a
  call store_cursor_val
  jp main_loop
main_right:
  ld a, (cursor_val)
  ld (stdout_addr), a
  call store_cursor_val
  jp main_loop
main_backspace:
  ld a, ' '
  ld (stdout_addr), a
  ld a, (grid_iter)
  dec a
  dec a
  ld (grid_iter), a
  ld a, ' '
  ld (stdout_addr), a
  ld a, (grid_iter)
  dec a
  ld (grid_iter), a
  jp main_loop

init_cursor_val:
  ld a, ' '
  ld (cursor_val), a
  ret

store_cursor_val:
  push hl
  ld hl, display_start
  ld a, (grid_iter)
  add a, l
  ld l, a
  ld a, (hl)
  ld (cursor_val), a
  pop hl
  ret

print_cursor:
  ld hl, display_start
  ld a, (grid_iter)
  add a, l
  ld l, a
  ld a, cursor_key
  ld (hl), a
  ret

print_newline:
  ld a, (cursor_val)
  ld (stdout_addr), a
  ld a, (grid_iter)
  dec a
  add a, grid_width
  and $F0
  ld (grid_iter), a
  call store_cursor_val
  ret

print_hl:
  ld a,(hl)
  sub $0
  jp z, print_hl_end
  sub '\n'
  jp z, print_hl_newline
  add a, '\n'
  inc hl
  ld (stdout_addr), a
  jp print_hl
print_hl_newline:
  call print_newline
  inc hl
  jp print_hl
print_hl_end:
  ret

load_tileset:
  ld hl, tileset_orig
  ld bc, tileset_end
  ; starts at 'a' in tileset list
  ld de, ts_space_start  ;$2308
load_tileset_loop:
  ld a, c
  sub l
  jp nz, load_tileset_next
  ld a, b
  sub h
  jp z, load_tileset_end
load_tileset_next:
  ld a, (hl)
  ld (de), a
  inc hl
  inc de
  jp load_tileset_loop
load_tileset_end:
  ret

full_tileset_print:
.db  $1, $2, $3, $4, $5, $6, $7, $8, $9, $A, $B, $C, $D, $E, $F,$10
.db $11,$12,$13,$14,$15,$16,$17,$18,$19,$1A,$1B,$1C,$1D,$1E,$1F,$20
.db $21,$22,$23,$24,$25,$26,$27,$28,$29,$2A,$2B,$2C,$2D,$2E,$2F,$30
.db $31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B,$3C,$3D,$3E,$3F,$40
.db $41,$42,$43,$44,$45,$46,$47,$48,$49,$4A,$4B,$4C,$4D,$4E,$4F,$50
.db $51,$52,$53,$54,$55,$56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$5F,$60
.db $61,$62,$63,$64,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6D,$6E,$6F,$70
.db $71,$72,$73,$74,$75,$76,$77,$78,$79,$7A,$7B,$7C,$7D,$7E,$7F,$80
.db $81,$82,$83,$84,$85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$90
.db $91,$92,$93,$94,$95,$96,$97,$98,$99,$9A,$9B,$9C,$9D,$9E,$9F,$A0
.db $A1,$A2,$A3,$A4,$A5,$A6,$A7,$A8,$A9,$AA,$AB,$AC,$AD,$AE,$AF,$B0
.db $B1,$B2,$B3,$B4,$B5,$B6,$B7,$B8,$B9,$BA,$BB,$BC,$BD,$BE,$BF,$C0
.db $C1,$C2,$C3,$C4,$C5,$C6,$C7,$C8,$C9,$CA,$CB,$CC,$CD,$CE,$CF,$D0
.db $D1,$D2,$D3,$D4,$D5,$D6,$D7,$D8,$D9,$DA,$DB,$DC,$DD,$DE,$DF,$E0
.db $E1,$E2,$E3,$E4,$E5,$E6,$E7,$E8,$E9,$EA,$EB,$EC,$ED,$EE,$EF,$F0
.db $F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8,$F9,$FA,$FB,$FC,$FD,$FE,$FF,$20, $0

railway_print:
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
.db $95,$95,$9A,$95,$95,$95,$95,$95,$9A,$95,$95,$95,$95,$95,$95,$95
.db $20,$20,$94,$20,$20,$20,$20,$20,$94,$20,$20,$96,$97,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$94,$20,$96,$97,$20,$20,$20,$20
.db $20,$20,$94,$20,$20,$20,$20,$20,$94,$96,$97,$20,$20,$20,$20,$20
.db $20,$20,$94,$20,$98,$99,$20,$20,$A4,$97,$20,$20,$20,$20,$20,$20
.db $98,$99,$94,$20,$20,$98,$99,$96,$97,$20,$20,$20,$20,$20,$20,$20
.db $20,$98,$A0,$20,$20,$20,$9C,$9B,$20,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$9F,$99,$20,$96,$97,$98,$99,$20,$20,$20,$20,$20,$20,$20
.db $20,$20,$94,$98,$9D,$97,$20,$20,$98,$99,$20,$20,$20,$20,$20,$20
.db $20,$20,$9A,$95,$9E,$99,$20,$20,$20,$98,$99,$20,$20,$20,$20,$20, $0

hello_world_message:
.db "Hello World!",0

multiline_message:
.db "Multiline\nmessage\n\n\n",0

double_space:
.db "Double\n\nspaced\n\nmessage\n",0

intro_message:
.db "Hello and welcome to my shell.\n"
.db "$ ",0

#include tileset_defs.asm
