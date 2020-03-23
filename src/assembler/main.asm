; file: main.asm

main:
  call load_tileset
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
  ld de, $2308
load_tileset_loop:
  ld a, c
  sub l
  jp z, load_tileset_end
  ld a, (hl)
  ld (de), a
  inc hl
  inc de
  jp load_tileset_loop
load_tileset_end:
  ret

hello_world_message:
.db "hello world lorem ipsum scanty "
.db "brothers with the law on our side creative "
.db "coronavirus prevention social distancing how "
.db "do you do i am honestly scared for my future i "
.db "live alone and do not have anyone to call my own so "
.db "please turn on your magic beam mr sandman bring me a dream",0

tileset_orig:
tileset_a:
.db %00000000
.db %00111000
.db %01000100
.db %00000010
.db %00111010
.db %01000110
.db %00111010
.db %00000000

tileset_b:
.db %00000000
.db %01000000
.db %01000000
.db %01011100
.db %01100010
.db %01100010
.db %01011100
.db %00000000

tileset_c:
.db %00000000
.db %00000000
.db %00111100
.db %01000010
.db %01000000
.db %01000010
.db %00111100
.db %00000000

tileset_d:
.db %00000000
.db %00000010
.db %00000010
.db %00111010
.db %01000110
.db %01000110
.db %00111010
.db %00000000

tileset_e:
.db %00000000
.db %00000000
.db %00111100
.db %01000010
.db %01111110
.db %01000000
.db %00111100
.db %00000000

tileset_f:
.db %00000000
.db %00001100
.db %00010010
.db %00010000
.db %00111100
.db %00010000
.db %00010000
.db %00000000

tileset_g:
.db %00000000
.db %00111100
.db %01000010
.db %01000110
.db %00111010
.db %00000010
.db %01000010
.db %00111100

tileset_h:
.db %00000000
.db %01000000
.db %01000000
.db %01000000
.db %01111000
.db %01000100
.db %01000100
.db %00000000

tileset_i:
.db %00000000
.db %00010000
.db %00000000
.db %00110000
.db %00010000
.db %00010000
.db %00111000
.db %00000000

tileset_j:
.db %00000000
.db %00000100
.db %00000000
.db %00001100
.db %00000100
.db %00000100
.db %00000100
.db %00011000

tileset_k:
.db %00000000
.db %01000000
.db %01000000
.db %01001100
.db %01110000
.db %01010000
.db %01001000
.db %00000000

tileset_l:
.db %00000000
.db %00110000
.db %00010000
.db %00010000
.db %00010000
.db %00010000
.db %00111000
.db %00000000

tileset_m:
.db %00000000
.db %00000000
.db %00000000
.db %01101000
.db %01010100
.db %01010100
.db %01010100
.db %00000000

tileset_n:
.db %00000000
.db %00000000
.db %00000000
.db %01111000
.db %01000100
.db %01000100
.db %01000100
.db %00000000

tileset_o:
.db %00000000
.db %00000000
.db %00000000
.db %00111100
.db %01000010
.db %01000010
.db %00111100
.db %00000000

tileset_p:
.db %00000000
.db %00000000
.db %01111000
.db %01000100
.db %01000100
.db %01111000
.db %01000000
.db %01000000

tileset_q:
.db %00000000
.db %00000000
.db %00111010
.db %01000110
.db %01000110
.db %00111010
.db %00000011
.db %00000010

tileset_r:
.db %00000000
.db %00000000
.db %01011100
.db %01100100
.db %01000000
.db %01000000
.db %01000000
.db %00000000

tileset_s:
.db %00000000
.db %00000000
.db %00011100
.db %00100000
.db %00011000
.db %00000100
.db %00111000
.db %00000000

tileset_t:
.db %00000000
.db %00100000
.db %00100000
.db %01111000
.db %00100000
.db %00100000
.db %00011000
.db %00000000

tileset_u:
.db %00000000
.db %00000000
.db %01000010
.db %01000010
.db %01000010
.db %01000110
.db %00111010
.db %00000000

tileset_v:
.db %00000000
.db %00000000
.db %01000010
.db %01000010
.db %00100100
.db %00100100
.db %00011000
.db %00000000

tileset_w:
.db %00000000
.db %00000000
.db %01001010
.db %01001010
.db %01001010
.db %01001010
.db %00110100
.db %00000000

tileset_x:
.db %00000000
.db %00000000
.db %01000010
.db %00100100
.db %00011000
.db %00100100
.db %01000010
.db %00000000

tileset_y:
.db %00000000
.db %00000000
.db %01000010
.db %01000010
.db %01000110
.db %00111010
.db %00000010
.db %01111100

tileset_z:
.db %00000000
.db %00000000
.db %01111110
.db %00000100
.db %00011000
.db %00100000
.db %01111110
.db %00000000

tileset_end:
