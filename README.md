# Assembly Game: Nano Invader
A Motorola 68000-based 2D game built using EASY68K.

## Game Instructions

**Objective:** Protect your pixels from encroaching enemies and heal any damaged areas to achieve victory!

## How to Run
1. Open `Nano Invaders.X68` in EASY68K
2. Press F9 to execute
3. You're all set!

**Description:**

- You control a defense system tasked with protecting your valuable pixels.
- Red and purple ball-shaped enemies will attempt to destroy your pixels.
- If your pixels are hit, they become "dead pixels" and you must heal them.
- Eliminate enemies to prevent further damage and to win the game.

**How to Play:**

- **Shoot Laser:** Press the "Arrow Up ↑" key to fire your laser and destroy enemies.
- **Heal Pixels:** Press the "Spacebar" to restore any dead pixels.

**Game Rules:**

- **Loss Condition:** You lose the game if any enemy reaches the edge of the screen.
- **Win Condition:** Heal a total of 5 pixels to win the game. (This number can be adjusted in the "WINNING" subroutine)
