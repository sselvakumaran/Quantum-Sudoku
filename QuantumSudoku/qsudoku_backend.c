//
//  qsudoku_backend.c
//  QuantumSudoku
//
//  Created by Sriman Selvakumaran on 5/5/23.
//

#include "qsudoku_backend.h"

/*
first 4 bits: current shown number (placed by user)
 0: nothing placed by user yet
 1-9: number
 10: answer given
 last four bits: answer number
 this is 1-9 for simplicity
 */
static uint8_t * grid = NULL;
static uint8_t ** entangled = NULL;
static int num_entangled_sets = 0;

const static uint8_t testpuzzleanswers[9][9] =
    {{9,1,6,3,5,7,8,2,4},
    {4,7,5,8,1,2,9,3,6},
    {3,8,2,6,9,4,5,1,7},
    {1,6,3,7,2,8,4,5,9},
    {5,2,7,9,4,6,3,8,1},
    {8,9,4,1,3,5,7,6,2},
    {6,5,1,4,7,3,2,9,8},
    {2,4,9,5,8,1,6,7,3},
    {7,3,8,2,6,9,1,4,5}};
const static uint8_t testpuzzlegiven[9][9] =
    {{10,0,10,10,0,10,0,0,0},
    {0,10,10,0,10,0,0,10,10},
    {10,10,0,0,0,0,10,0,10},
    {0,10,0,10,0,0,0,0,10},
    {10,0,0,0,10,0,10,10,10},
    {0,10,0,0,10,10,0,10,0},
    {0,0,10,0,0,0,0,10,0},
    {10,0,10,10,10,0,10,0,10},
    {10,0,0,10,10,0,10,0,10}};

void initialize_grid(void) {
    grid = calloc(81, sizeof(uint8_t));
}

void make_puzzle(int difficulty) {
    if (grid == NULL)
        return;
    if (!difficulty) {
        int i, j;
        for (i = 0; i < 9; i++)
            for (j = 0; j < 9; j++)
                grid[9*i + j]= 16*testpuzzleanswers[i][j] + testpuzzlegiven[i][j];
    }
}

int place_number(int row, int column, int number) {
    int8_t cell = grid[9*row + column];
    if ((cell & 0xf) != 10)
        cell = number + (cell & 0xf0);
    grid[9*row + column] = cell;
    return cell & 0xf;
}

int is_cell_given(int row, int column) {
    int8_t cell = grid[9*row + column];
    return (cell & 0xf) == 10;
}

int get_number(int row, int column) {
    int8_t cell = grid[9*row + column];
    return (cell & 0xf) == 10 ? (cell & 0xf0) >> 4 : cell & 0xf;
}

int check_cell(int row, int column) {
    return 0;
}
void cleanup(void) {
    if (grid != NULL) {
        free(grid);
    }
}
