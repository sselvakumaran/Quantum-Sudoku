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
Quantum Sudoku is my personal version of Sudoku that includes quantum entanglement.
You don't actually need to understand quantum physics to play this! It just adds a feature called 'entangled cells' where two or more cells will be interconnected such that their numbers add up to 10.
### What is entanglement?
Glad you asked! Quantum entanglement is when a group of particles (called an entangled system) are related such that their states cannot be described independently. In other words, if the state of one particle is known, then it is possible that some information can be drawn about the states of the other particles. Unlike a untangled system of random particles, if an observer knows the state of one particle, they could not draw any conclusions of the states of the other particles in the system since they are uncorrelated.
For instance, two particles can be generated in an entangled system such that their spin adds up to net zero. This means that if an observer notices one of the particles has an up spin, they also know at that moment the other particle must have had a down spin (to cancel out and result in a net zero spin).
###How does entanglement apply to Sudoku?
Simply put I was having fun. I am a personal enjoyer of Sudoku, and wanted to add a little bit of entangledness to the grid. In this implementation, when recieving a puzzle to solve, a random amount of systems with a random amount of particles will be placed on the board as well. They will be represented as cells with gradients that are equal. To make things simple, quantum entanglement is represented such that the sum of the numbers in an entangled system is 10. (Maybe if I pick up this project again I will change this.) E.g. if an entangled system has two particles, the possible sets they could be is (1,9), (2,8), (3,7), ... up to (9,1). 
Here's the catch though: You will know which cells are entangled with each other, 

## Technical details / notes
## To the quantum physicist
To the quantum physicist or quantum computer researcher, please note that this implies an entangled system of 81 particles, since every row, column, and subgrid are interconnected themselves. You should ignore the reality of a situation like this, because this is a fun little thought experiment and the bounds of reality will not stop me to create another version of Sudoku and another unique Sudoku puzzle maker algorithm.
Another thing to note is that if the cells are treated like particles, then that means there would be 9 different states of a particle. This then means that each cell is a qudit of size 9. Qudits are being researched upon and as of right now a system of 81 qudits of size 9 is... quite big. In every aspect. Originally I was intending to make this the reality of the game, and that every cell represented a photon with different polarization angles, but this seemed not only too hard to understand out of the box, but ugly. It also does not make much sense in a quantum sense, so why push towards quantum when you'd find a home closer to Sudoku? Once again, ignore all of this, and enjoy the game! :)
## To the experienced Sudoku player
To the experienced Sudoku player, this screams Killer Sudoku, but remember that just like in real life, entangled particles can span any distance apart and they will still be entangled! They can be across the board. While this makes significantly less techniques possible to port from Killer, since the bound is the sum of 10 (right now), it keeps things a little simpiler. This version of Sudoku is not meant to be as difficult as Killer, but rather extremely comparable to normal Sudoku. I hope you enjoy the new techniques that might come from this brand new game mode.
### Project details
to be updated...
### Sudoku algorithm details
to be updated...
