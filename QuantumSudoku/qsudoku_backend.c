//
//  qsudoku_backend.c
//  QuantumSudoku
//
//  Created by Sriman Selvakumaran on 5/5/23.
//

#include "qsudoku_backend.h"
#include "demo-puzzles.h"

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
static uint8_t * notes = NULL;
static int num_entangled_systems = 0; //holds the index of the first cell in that system, last entry is sentinel (= length(entangled))
static const int NUM_CELLS = 9*9;
static const int MAX_SYSTEMS = (NUM_CELLS) / 2;

void initialize_grid(void) {
    int i;
    grid = calloc(NUM_CELLS, sizeof(uint8_t));
    entangled = calloc(NUM_CELLS, sizeof(uint8_t));
    system_pos_list = calloc(MAX_SYSTEMS, sizeof(uint8_t));
    notes = calloc(9*9*9 / sizeof(uint8_t) + 1, sizeof(uint8_t));
    for (i = 0; i < 9*9*9 / sizeof(uint8_t) + 1; i++) {
        notes[i] = 0;
    }
        
    assert(grid != NULL && entangled != NULL && system_pos_list != NULL && notes != NULL);
}

void make_puzzle(int difficulty) {
    if (difficulty < 0) {
        int i, j;
        difficulty = -difficulty - 1;
        for (i = 0; i < 9; i++)
            for (j = 0; j < 9; j++)
                grid[9*i + j]= (DEMO_ANSWERS[difficulty][i][j] << 4) + DEMO_GIVEN[difficulty][i][j];
        num_entangled_systems = DEMO_NUMENTANGLEDSYSTEMS[difficulty];
        for (i = 0; i <= num_entangled_systems; i++) // GOES ONE OVER TO COVER SENTINEL
            system_pos_list[i] = DEMO_SYSTEMPOSLIST[difficulty][i];
        for (i = 0; i < system_pos_list[num_entangled_systems]; i++)
            entangled[i] = DEMO_ENTANGLED[difficulty][i];
    } else {
        
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

int get_answer(int row, int column) {
    return grid[9*row + column] >> 4;
}

int check_cell(int row, int column) {
    int8_t cell = grid[9*row + column];
    return (cell & 0xf) == 10 || (cell >> 4) == (cell & 0xf);
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

int toggle_note(int row, int column, int number) {
    int pos = 9*row + column;
    int result = !(grid[pos] & 0xf) - 1, byte, remainder;
    if (result == 0) {
        if (number != 0) {
            pos= 9*pos + (9 - number);
            byte= pos/8;
            remainder= pos % 8;
            notes[byte] ^= (1 << (7 - remainder));
            result= ((notes[byte] & (1 << (7 - remainder))) != 0) + 1;
        } else {
            pos*= 9;
            byte= pos/8;
            remainder= pos % 8;
            notes[byte]&= ((1 << (remainder + 1)) - 1) << (8 - remainder);
            notes[byte + 1]&= (1 << (8-remainder)) - 1;
        }
    }
    return result;
}

int get_notes(int row, int column) {
    int pos = 9*(9*row + column);
    int byte = pos/8, remainder = pos % 8;
    return ((uint16_t) (notes[byte]) << (remainder + 1)) + (notes[byte + 1] >> (7 - remainder));
}

int note_exists(int row, int column, int number) {
    int pos = 9*(9*row + column) + (9 - number);
    return (notes[pos/8] & (1 << (7 - (pos % 8)))) != 0;
}

void cleanup(void) {
    if (grid != NULL) {
        free(grid);
        free(entangled);
        free(system_pos_list);
        free(notes);
    }
}
