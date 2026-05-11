# Tic-Tac-Toe-No-Draw

Tic-Tac-Toe with one twist — inspired by the **Tic Tac Toe Bolt** electronic game device. Each player can only have 3 symbols on the board. Place a 4th and your oldest vanishes. No draws, built with Flutter.

---
 
### 📦 Stack
 
- **Flutter** (Dart)
- **audioplayers** — sound effects
- **Material Design** — dark mode UI
---
 
### ✨ Quick start

create a new flutter projetc.
add the assets and lib folders to your project.

```bash
flutter pub get
flutter run
```
 
Works on Android, iOS, and any Flutter-supported platform.
 
---
 
### 🎮 How to play
 
Two players take turns placing **X** and **O** on a standard 3×3 grid.
 
- Each player can have a **maximum of 3 symbols** on the board
- When you place your **4th symbol**, your oldest one is automatically removed
- The symbol about to be removed is shown at **50% opacity** as a visual hint
- First to align 3 symbols in a row, column, or diagonal **wins**
---
 
### 🤖 How it works
 
The game tracks a queue of placed symbols per player. On each turn:
 
- The new symbol is added to the player's queue
- If the queue exceeds 3, the **oldest symbol** is dequeued and removed from the board
- Win condition is checked after every placement against all 8 possible lines
- The fading opacity effect is applied to `queue[0]` — the next symbol to be removed
---
 
### 👤 Author
 
**Bahady** — [github.com/bahady1](https://github.com/bahady1)
 
---
 
### 📀 Preview
 


https://github.com/user-attachments/assets/746715db-8ab5-4033-9b89-d0ed0edad247


