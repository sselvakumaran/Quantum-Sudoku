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
static uint8_t * entangled = NULL;
static uint8_t * system_pos_list = NULL;
static int num_entangled_systems = 0; //holds the index of the first cell in that system, last entry is sentinel (= length(entangled))
static const int NUM_CELLS = 9*9;
static const int MAX_SYSTEMS = (NUM_CELLS) / 2;

const static uint8_t TESTPUZZLE_ANSWERS[9][9] =
    {{9,1,6,3,5,7,8,2,4},
    {4,7,5,8,1,2,9,3,6},
    {3,8,2,6,9,4,5,1,7},
    {1,6,3,7,2,8,4,5,9},
    {5,2,7,9,4,6,3,8,1},
    {8,9,4,1,3,5,7,6,2},
    {6,5,1,4,7,3,2,9,8},
    {2,4,9,5,8,1,6,7,3},
    {7,3,8,2,6,9,1,4,5}};
const static uint8_t TESTPUZZLE_GIVEN[9][9] =
    {{10,0,10,10,0,10,0,0,0},
    {0,10,10,0,10,0,0,10,10},
    {10,10,0,0,0,0,10,0,10},
    {0,10,0,10,0,0,0,0,10},
    {10,0,0,0,10,0,10,10,10},
    {0,10,0,0,10,10,0,10,0},
    {0,0,10,0,0,0,0,10,0},
    {10,0,10,10,10,0,10,0,10},
    {10,0,0,10,10,0,10,0,10}};
const static uint8_t TESTPUZZLE_ENTANGLED[] = {G(0,0), G(7,7), G(5, 2), G(5,6), G(8,3), G(0,8), G(2,3), G(8,1)};
const static uint8_t TESTPUZZLE_SYSTEMPOSLIST[] = {0,2,5,8};
const static uint8_t TESTPUZZLE_NUMENTANGLEDSYSTEMS = 3;

void initialize_grid(void) {
    grid = calloc(NUM_CELLS, sizeof(uint8_t));
    entangled = calloc(NUM_CELLS, sizeof(uint8_t));
    system_pos_list = calloc(MAX_SYSTEMS, sizeof(uint8_t));
    assert(grid != NULL && entangled != NULL && system_pos_list != NULL);
}

void make_puzzle(int difficulty) {
    if (!difficulty) {
        int i, j;
        for (i = 0; i < 9; i++)
            for (j = 0; j < 9; j++)
                grid[9*i + j]= (TESTPUZZLE_ANSWERS[i][j] << 4) + TESTPUZZLE_GIVEN[i][j];
        
        num_entangled_systems = TESTPUZZLE_NUMENTANGLEDSYSTEMS;
        for (i = 0; i <= num_entangled_systems; i++) // GOES ONE OVER TO COVER SENTINEL
            system_pos_list[i] = TESTPUZZLE_SYSTEMPOSLIST[i];
        for (i = 0; i < system_pos_list[num_entangled_systems]; i++)
            entangled[i] = TESTPUZZLE_ENTANGLED[i];
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
int get_num_entangled_systems(void) {
    return num_entangled_systems;
}
int get_num_entangled_in_system(int system) {
    assert(system < num_entangled_systems);
    return system_pos_list[system + 1] - system_pos_list[system];
}
int get_pos_entangled_cell(int system, int cell_num) {
    assert(cell_num < get_num_entangled_in_system(system));
    return entangled[system_pos_list[system] + cell_num];
}
int get_row(int pos) {
    return pos / 9;
}
int get_column(int pos) {
    return pos % 9;
}
void cleanup(void) {
    if (grid != NULL) {
        free(grid);
        free(entangled);
        free(system_pos_list);
    }
}
