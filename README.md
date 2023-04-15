# Quantum-Sudoku
Quantum twist to a classic puzzle game

Sriman Selvakumaran
University of Maryland, College Park \
The First-Year Research and Innovation Experience (FIRE) \
Quantum Machine Learning (QML) Spring 2023 - Creative Project
## What is Quantum Sudoku?
Quantum Sudoku is just like classic sudoku with a twist. 
Sudoku is a puzzle game where the player must insert the numbers 1-9 in a grid of 9x9 cells such that no row, column, or 3x3 subgrid has repeated numbers.
There are various techniques to solve Sudoku, and puzzles can range in difficulty.
Quantum Sudoku is my personal version of Sudoku that includes quantum entanglement. \
Each cell in the grid represents a set of qubits such that their combined states yields a number between 0 and 7 (think of binary)
### What's different from Classical Sudoku?
- Instead of a 9x9 grid, it is 8x8. 
  - This is to preserve the concept of a 'qubit' only having 2 states, and 8 is a power of 2. 
This is also to make it reasonably short, as 16x16 would make more sense but these puzzles would be too long.
- Instead of normal 8x8 where blocks are 4x2, instead blocks will be 4x4, with the rule that each state must appear twice in such block.
  - This is a personal thing, I would rather keep it symmetric. :)
