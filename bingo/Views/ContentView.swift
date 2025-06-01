//
//  ContentView.swift
//  bingo
//
//  Created by Olivier Maghe on 23/05/2025.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var model: BingoModel
    @State private var showResetAlert = false

    var body: some View {
        VStack(spacing: 20) {
            let columns = Array(repeating: GridItem(.fixed(25), spacing: 10), count: 10)
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(1...model.maxNumber, id: \.self) { num in
                    BallView(
                        number: num,
                        isDrawn: model.drawnNumbers.contains(num)
                    ) {
                        model.toggleNumber(num)
                    }
                }
                .frame(width: 30, height: 30) // <-- taille fixe ici

            }

            Button(action: model.drawNumber) {
                Text("Tirage")
                    .bold()
                    .padding()
                    .foregroundColor(.white)
            }
            .background(
                model.drawnNumbers.count <= 10 ? Color.green :
                model.drawnNumbers.count <= 20 ? Color.orange :
                Color.red
            )
            .cornerRadius(10)
            .buttonStyle(.plain)

            Divider()

            Label("Historique", systemImage: "numbers.rectangle.fill")
                .foregroundColor(.blue)

            Text(model.drawnNumbers.map { String($0) }.joined(separator: " - "))
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

                Button("admin") {
                    model.reset()
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .foregroundColor(.white)
                .background(Color.gray)
                .cornerRadius(3)
                .buttonStyle(.plain)
                
                Button(action: {
                    // Simple clic : affiche la fenêtre
                    GridWindowController.show(model: model)
                }) {
                    Text("Ecran secondaire")
                }
                .simultaneousGesture(
                    TapGesture(count: 2)
                        .onEnded {
                            // Double clic : bascule plein écran
                            GridWindowController.toggleFullScreen()
                        }
                )
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .cornerRadius(3)
                    .buttonStyle(.plain)
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding()
        .alert("Confirmation", isPresented: $showResetAlert) {
            Button("Annuler", role: .cancel) {}
            Button("Confirmer", role: .destructive) {
                model.reset()
            }
        } message: {
            Text("Es-tu certain de vouloir tout réinitialiser ?")
        }
    }
}
