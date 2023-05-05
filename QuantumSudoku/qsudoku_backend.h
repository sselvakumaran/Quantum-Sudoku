//
//  qsudoku_backend.h
//  QuantumSudoku
//
//  Created by Sriman Selvakumaran on 5/5/23.
//

#ifndef qsudoku_backend_h
#define qsudoku_backend_h

#include <stdlib.h>

void initialize_grid(void);
void make_puzzle(int difficulty);
int place_number(int row, int column, int number);
int is_cell_given(int row, int column);
int get_number(int row, int column);
int check_cell(int row, int column);
void cleanup(void);

#endif /* qsudoku_backend_h */
