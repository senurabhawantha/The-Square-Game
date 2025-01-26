import SwiftUI

struct ContentView: View {
    @State private var colors: [[Color]] = []
    @State private var matchedIndices: [(row: Int, column: Int)] = []
    @State private var selectedIndices: [(row: Int, column: Int)] = []
    @State private var feedback: String = ""
    @State private var score: Int = 0
    @State private var isGameWon: Bool = false

    // Timer-related states
    @State private var remainingTime: Int = 30
    @State private var timer: Timer? = nil
    @State private var isTimerRunning: Bool = false

    init() {
        _colors = State(initialValue: ContentView.generateGrid()) // Use static call here
    }

    var body: some View {
        VStack {
            if isGameWon {
                Text("🎉 You Win! 🎉")
                    .font(.largeTitle)
                    .foregroundColor(.green)
                    .padding()

                Text("Final Score: \(score)")
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()

                Button(action: restartGame) {
                    Text("Restart Game")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .shadow(radius: 3)
                }
            } else {
                if isTimerRunning {
                    Text("Time Remaining: \(remainingTime)s")
                        .font(.headline)
                        .foregroundColor(remainingTime > 10 ? .green : .red)
                        .padding()
                }

                ForEach(0..<3, id: \.self) { row in
                    HStack {
                        ForEach(0..<3, id: \.self) { column in
                            Rectangle()
                                .fill(
                                    matchedIndices.contains(where: { $0 == (row, column) }) ? Color.gray :
                                    colors[row][column]
                                )
                                .frame(width: 100, height: 100)
                                .onTapGesture {
                                    if colors[row][column] != Color.black,
                                       !matchedIndices.contains(where: { $0 == (row, column) }) {
                                        handleTap(row: row, column: column)
                                    }
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(selectedIndices.contains(where: { $0 == (row, column) }) ? Color.blue : Color.clear, lineWidth: 3)
                                )
                                .opacity(matchedIndices.contains(where: { $0 == (row, column) }) ? 0.6 : 1.0)
                        }
                    }
                }

                Text(feedback)
                    .font(.headline)
                    .padding()
                    .foregroundColor(feedback == "Try Again!" ? .red : .blue)

                Text("Score: \(score)")
                    .font(.headline)
                    .padding()
                    .foregroundColor(.green)
            }
        }
        .padding()
    }

    private func handleTap(row: Int, column: Int) {
        if !isTimerRunning {
            startTimer()
        }

        if selectedIndices.contains(where: { $0 == (row, column) }) {
            return
        }

        selectedIndices.append((row, column))

        if selectedIndices.count == 2 {
            let first = selectedIndices[0]
            let second = selectedIndices[1]

            if colors[first.row][first.column] == colors[second.row][second.column] {
                matchedIndices.append(contentsOf: [first, second])
                score += 10

                if matchedIndices.count == 8 {
                    isGameWon = true
                    stopTimer()
                }
            } else {
                feedback = "Try Again!"
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    feedback = ""
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                selectedIndices.removeAll()
            }
        }
    }

    private func startTimer() {
        isTimerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                stopTimer()
                isGameWon = false // Game ends if time runs out
            }
        }
    }

    private func stopTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func restartGame() {
        colors = ContentView.generateGrid() // Use static call here
        matchedIndices.removeAll()
        selectedIndices.removeAll()
        feedback = ""
        score = 0
        isGameWon = false
        remainingTime = 30
        stopTimer()
    }

    private static func generateGrid() -> [[Color]] { // Kept as static
        let allColors: [Color] = [.red, .blue, .green, .yellow]
        var colorPool = allColors.flatMap { [$0, $0] }
        colorPool.append(.black)
        colorPool.shuffle()

        var grid: [[Color]] = []
        for row in 0..<3 {
            var rowColors: [Color] = []
            for column in 0..<3 {
                rowColors.append(colorPool[row * 3 + column])
            }
            grid.append(rowColors)
        }

        return grid
    }
}

#Preview {
    ContentView()
}
