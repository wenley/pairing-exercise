
# Pair Programming Workshop Starter

## Background

Claim: Pair Programming is a skill. Like any other skill (playing an instrument, public speaking), it can and should be practiced deliberately, both in isolation and in tandem with other related skills.

This is the starter codebase for a pair programming workshop run by Wenley Tong covering unit testing. It is intended to provide an environment and progression to:
1. Practice the skill of pair programming
2. See different modes / paradigms for doing pair programming
3. See the benefits + limits of Test-Driven Development (TDD)

Supported Languages:
- Ruby
- Javascript

More languages will be added at request.

## Getting Started

### Ruby

0. Install Ruby 2.7.1
1. Install bundler (`gem install bundler`)
2. Run `bundle`
3. Run `rspec spec/conway_game_spec.rb`

### Javascript

0. Install yarn (`brew install yarn`)
1. Run `yarn`
2. Run `yarn test`

## Introduction to the Workshop

In this workshop, you will implement the same problem multiple times, with different partners and different modes of pairing. After each session, you should either throw away all the code you wrote (preferable), or commit and forget the code you wrote, starting from a clean slate each time.

#### The Domain

The particular domain is not terribly important, but for us today, it is [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life).

The rules of the Game are simple:
- You have a 2D Euclidean grid of "cells"
- Each cell can either be "alive" or "dead" at a given moment in time
- Each cell has 8 "neighbors" (diagonals and orthogonals)
- To compute the state of the world at time T + 1, we look at every cell at time T:
  - If the cell had 0 or 1 alive neighbors, it dies ("starving")
  - If the cell had 2 alive neighbors, it stays the same
  - If the cell had 3 alive neighbors, it becomes alive
  - If the cell had 4 or more alive neighbors, it dies ("overcrowding")

#### The Task

The task for each session is the same: To implement a working version of Conway's Game of Life.

However, remember: **solving the problem is NOT the main purpose of the exercise; finishing an implementation is NOT the goal.**

Instead, the goal is to think and reflect about how the collaboration dynamic feels. In each session, you will use a different collaboration dynamic to solve the problem -> you should think about how different setups for pairing each operate. See the next section for a progression of pairing styles.

Hints for getting started with coding:
- If you want/need to simplify the problem to get started (e.g. only a 10 x 10 grid, change the exact rules), do it! If you finish early with these simplifications, try to get back to the original prompt
- You should write some tests to verify correctness. The Wikipedia page has [some good test cases](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Examples_of_patterns).
- You should probably write two functions:
  1. `step` to advance time by one tick
  2. `show` to produce a multi-line String to graphically show the internal state. (Trust me, this is much easier than reading nested arrays of integers or booleans; it also gives a public interface to verify the correctness of `step`).

## Styles of Pairing

### Unguided pairing
- Do whatever you want! Just solve the problem
- Main goal: Get familiar with the problem and its gotchas

### Driver / Navigator
- One person is the Driver, the other the Navigator
- The Driver is the only person allowed to type
- The Driver cannot type anything not directed by the Navigator

### TDD
- This extends the Driver / Navigator pattern, except the pattern should now be:
  - Write a test
  - Show it fails
  - Make it pass
  - Repeat

### TDD Tennis
- This is a different way to do TDD, without the Driver / Navigator collaboration dynamic
- One person writes a test that the other person must make pass with minimal (though still collaborative) work
- What happens if you want to write a new test while making a different one pass?
  - Suppose Person A is implementing the app code to make Test 1 pass, but wants to introduce Test 2 as an intermediate step. Do it! Then have Person B implement the app code to make Test 2 pass before switching back to have Person A finish making Test 1 pass.
  - This can nest ad infinitum, but before doing so, ask yourself: Could I write less app code to make Test 1 pass before writing Test 2? Remember, one reason to practice TDD is to write less code at a time.

### Silent TDD Tennis
- You may talk with your partner for at most 2 minutes at the beginning (or not at all! _Challenge Mode_). Afterwards, no talking and proceed with TDD Tennis as usual.
