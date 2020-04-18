#define stdout_addr $8000
#define grid_iter $8001
#define key_input_location $8002
#define interrupt_data $DF00
#define tileset_start $2000
#define tileset_height $8
#define ts_space_start $2000 + (' ' * ($8 * $8)/($8))
#define grid_height $10
#define grid_width $10
#define display_start $2800
#define display_end $2800 + ($10 * $10)
