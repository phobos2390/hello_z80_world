; file: main.asm

main:
  call load_tileset
  ld hl, full_tileset_print
  call print_hl
  ld hl, hello_world_message
  call print_hl
  halt

print_hl:
  ld a,(hl)
  sub $0
  jp z, print_hl_end
  inc hl
  ld ($8000), a
  jp print_hl
print_hl_end:
  ret

load_tileset:
  ld hl, tileset_orig
  ld bc, tileset_end
  ; starts at 'a' in tileset list
  ld de, $2100 ;$2308
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

hello_world_message:
.db "Hello World!",0

#include tileset_defs.asm