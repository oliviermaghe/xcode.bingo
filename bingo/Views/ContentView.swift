//
//  ContentView.swift
//  bingo
//
//  Created by Olivier Maghe on 23/05/2025.
//

import SwiftUI

struct ContentView: View {
    let maxNumber = 90
    @State private var drawnNumbers: [Int] = []
    @State private var showResetAlert = false

    func reset() {
        drawnNumbers.removeAll()
    }

    func drawNumber() {
        let availableNumbers = (1...maxNumber).filter { !drawnNumbers.contains($0) }
        guard let newNumber = availableNumbers.randomElement() else { return }
        withAnimation {
            drawnNumbers.append(newNumber)
        }
    }

    func toggleNumber(_ num: Int) {
        if let index = drawnNumbers.firstIndex(of: num) {
            drawnNumbers.remove(at: index)
        } else {
            drawnNumbers.insert(num, at: 0)
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            let columns = Array(repeating: GridItem(.fixed(25), spacing: 10), count: 10)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(1...maxNumber, id: \.self) { num in
                    BallView(
                        number: num,
                        isDrawn: drawnNumbers.contains(num)
                    ) {
                        toggleNumber(num)
                    }
                }
            }

            Button(action: drawNumber) {
                Text("Tirage aléatoire")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
            }
            .background(
                drawnNumbers.count <= 10 ? Color.green :
                drawnNumbers.count <= 20 ? Color.orange :
                Color.red
            )
            .cornerRadius(10)
            .buttonStyle(.plain)

            Divider()

            Label("Sorties", systemImage: "numbers.rectangle.fill")
                .foregroundColor(.blue)

            Text(drawnNumbers.map { String($0) }.joined(separator: " - "))
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(alignment: .leading)
                .padding()

            Divider()

            HStack {
                Button("Réinitialiser") {
                    showResetAlert = true
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(3)
                .buttonStyle(.plain)
                
                Button(action:reset) {
                    Text("admin")
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(3)
                .buttonStyle(.plain)            }
            


        } // <-- fin VStack

        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .alert("Confirmation", isPresented: $showResetAlert) {
            Button("Annuler", role: .cancel) {}
            Button("Confirmer", role: .destructive) {
                reset()
            }
        } message: {
            Text("Es-tu certain de vouloir tout réinitialiser ?")
        }
    }
}

#Preview {
    ContentView()
}
