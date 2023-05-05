//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

void initialize_grid(void);
void make_puzzle(int difficulty);
int place_number(int row, int column, int number);
int is_cell_given(int row, int column);
int get_number(int row, int column);
int check_cell(int row, int column);
void cleanup(void);
