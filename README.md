//

//  ContentView.swift

//  TheSquareGame

//

//  Created by Basura 013 on 2024-12-15.

//



import SwiftUI



struct ContentView: View {

    // Track the colors of the rectangles

    @State private var colors: [[Color]] = [

        [Color.red, Color.green],

        [Color.green, Color.red]

    ]

    

    // Track selected rectangles

    @State private var selectedIndices: [(row: Int, column: Int)] = []

    

    // Feedback message

    @State private var feedback: String = ""

    

    var body: some View {

        VStack {

            ForEach(0..<2, id: \.self) { row in

                HStack {

                    ForEach(0..<2, id: \.self) { column in

                        Rectangle()

                            .fill(colors[row][column])

                            .frame(width: 100, height: 100)

                            .onTapGesture {

                                handleTap(row: row, column: column)

                            }

                            .overlay(

                                RoundedRectangle(cornerRadius: 4)

                                    .stroke(selectedIndices.contains(where: { $0 == (row, column) }) ? Color.blue : Color.clear, lineWidth: 3)

                            )

                    }

                }

            }

            

            Text(feedback)

                .font(.headline)

                .padding()

                .foregroundColor(.blue)

            

            Button(action: shuffleColors) {

                Text("Shuffle Colors")

                    .padding()

                    .background(Color.blue)

                    .foregroundColor(.white)

                    .cornerRadius(8)

                    .shadow(radius: 3)

            }

            .onHover { hovering in

                if hovering {

                    NSCursor.pointingHand.push()

                } else {

                    NSCursor.arrow.pop()

                }

            }

        }

        .padding()

    }

    

    private func handleTap(row: Int, column: Int) {

        // If already selected, ignore the tap

        if selectedIndices.contains(where: { $0 == (row, column) }) {

            return

        }

        

        // Add to selected rectangles

        selectedIndices.append((row, column))

        

        // Check if two rectangles are selected

        if selectedIndices.count == 2 {

            let first = selectedIndices[0]

            let second = selectedIndices[1]

            

            // Check if colors match and are adjacent

            if colors[first.row][first.column] == colors[second.row][second.column],

               isAdjacent(first: first, second: second) {

                feedback = "Matched!"

            } else {

                feedback = "Try Again!"

            }

            

            // Clear selected indices after delay

            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {

                selectedIndices.removeAll()

                feedback = ""

            }

        }

    }

    

    private func isAdjacent(first: (row: Int, column: Int), second: (row: Int, column: Int)) -> Bool {

        let rowDiff = abs(first.row - second.row)

        let colDiff = abs(first.column - second.column)

        return (rowDiff == 1 && colDiff == 0) || (rowDiff == 0 && colDiff == 1)

    }

    

    private func shuffleColors() {

        colors.shuffle()

        for i in 0..<colors.count {

            colors[i].shuffle()

        }

        feedback = "Colors Shuffled!"

    }

}



#Preview {

    ContentView()

}


