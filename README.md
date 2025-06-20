# Tic-Tac-Toe-No-Draw
This is a custom twist on classic Tic-Tac-Toe, built with Flutter. The game introduces a dynamic rule: each player can only have a maximum of 3 active symbols on the board at any time.
🎮 Unlimited Tic-Tac-Toe (3x3 Variant)
This is a custom twist on classic Tic-Tac-Toe, built with Flutter. The game introduces a dynamic rule: each player can only have a maximum of 3 active symbols on the board at any time.

🧠 How It Works
Players: Two players – X and O – take turns.

Board: Standard 3x3 grid.

Symbol Limit: Each player can only place up to 3 symbols on the board.

Oldest Symbol Removal: Once a player places their 4th symbol, their oldest symbol is automatically removed to keep the total at 3.

Visual Hint: The oldest symbol (about to be removed on the next move) is shown at 50% opacity.

Win Condition: As in traditional Tic-Tac-Toe, the first to align 3 of their symbols in a row, column, or diagonal wins.

Sound Effects:

🎵 click.mp3 — when placing a symbol.

🔄 reset.mp3 — when resetting the game.

💰 ka-ching.mp3 — when a player wins.

🛠️ Features
Clean and responsive UI.

Dark theme with animated interactions.

Reusable sound function using audioplayers.

No external backend — works entirely offline.

Mobile-friendly.

🚀 Getting Started
To run this game:

Clone the repo.

Run flutter pub get.

Make sure your pubspec.yaml includes the audio assets:

yaml
Copy
Edit
assets:
  - assets/sounds/click.mp3
  - assets/sounds/reset.mp3
  - assets/sounds/ka-ching.mp3
Run the app on an emulator or physical device using:

bash
Copy
Edit
flutter run
📁 Folder Structure
bash
Copy
Edit
lib/
 └── main.dart       # Main game logic and UI
assets/
 └── sounds/         # Audio files for game events
     ├── click.mp3
     ├── reset.mp3
     └── ka-ching.mp3
