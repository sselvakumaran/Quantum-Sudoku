//
//  qsudoku_backend.h
//  QuantumSudoku
//
//  Created by Sriman Selvakumaran on 5/5/23.
//

#ifndef qsudoku_backend_h
#define qsudoku_backend_h

#include <stdlib.h>
#include <assert.h>

#define G(r,c) (9*(r) + (c))

void initialize_grid(void);
void make_puzzle(int difficulty);
int place_number(int row, int column, int number);
int is_cell_given(int row, int column);
int get_number(int row, int column);
int get_answer(int row, int column);
int check_cell(int row, int column);
int get_num_entangled_systems(void);
int get_num_entangled_in_system(int system);
int get_pos_entangled_cell(int system, int cell_num);
int get_row(int pos);
int get_column(int pos);
int toggle_note(int row, int column, int number);
int get_notes(int row, int column);
void cleanup(void);

#endif /* qsudoku_backend_h */
