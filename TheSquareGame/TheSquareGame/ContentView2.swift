import SwiftUI

struct ContentView2: View {
    @State private var currentPage: MenuPage = .home

    var body: some View {
        Group {
            switch currentPage {
            case .home:
                HomeMenuView(currentPage: $currentPage)
            case .game:
                GameView()
            case .guide:
                GuideView(currentPage: $currentPage)
            }
        }
        .animation(.easeInOut, value: currentPage) // Smooth transitions
    }
}

enum MenuPage {
    case home
    case game
    case guide
}

struct HomeMenuView: View {
    @Binding var currentPage: MenuPage
    
    // Fetch the high score from UserDefaults
    @State private var highScore: Int = UserDefaults.standard.integer(forKey: "highScore")
    
    var body: some View {
        VStack {
            Text("🎮 Square Game 🎮")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundColor(.white)
                .shadow(radius: 5)

            Spacer()

            Button(action: {
                currentPage = .game
            }) {
                Text("Start Game")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.blue, Color.green], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .padding(.top, 10)

            Button(action: {
                currentPage = .guide
            }) {
                Text("Guide")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.purple, Color.pink], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)

            Button(action: {
                // High Score Button - You can display or navigate to a high score screen
                print("High Score: \(highScore)") // Show high score for now
            }) {
                Text("High Score")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.yellow, Color.orange], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
            
            Button(action: {
                exit(0) // Exit the app
            }) {
                Text("Exit")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        LinearGradient(colors: [Color.red, Color.orange], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)

            Spacer()
        }
        .padding()
    }
}

struct GameView: View {
    @State private var score: Int = 0

    var body: some View {
        VStack {
            Text("🎯 Game Screen")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.green)
                .shadow(radius: 5)

            Spacer()

            Text("Your game logic runs here.")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .multilineTextAlignment(.center)

            Spacer()

            Button(action: {
                // Placeholder for additional actions
            }) {
                Text("Back to Menu")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [Color.gray, Color.blue], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

struct GuideView: View {
    @Binding var currentPage: MenuPage

    var body: some View {
        VStack {
            Text("📖 Game Guide")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.purple)
                .shadow(radius: 5)

            Spacer()

            Text("""
                - Start: Begin the game.
                - Guide: Learn how to play.
                - Exit: Quit the app.
                """)
                .multilineTextAlignment(.center)
                .foregroundColor(.white)
                .padding()

            Spacer()

            Button(action: {
                currentPage = .home
            }) {
                Text("Back to Menu")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        LinearGradient(colors: [Color.blue, Color.pink], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
            .padding(.horizontal, 40)
        }
        .padding()
    }
}

#Preview {
    ContentView2()
}
