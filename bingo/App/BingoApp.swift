//
//  BingoApp.swift
//  bingo
//
//  Created by Olivier Maghe on 23/05/2025.
//

import SwiftUI

@main
struct bingoApp: App {
    @StateObject var model = BingoModel()

    var body: some Scene {
        WindowGroup("Contrôle") {
            ContentView(model: model)
        }

        WindowGroup("Grille des tirages") {
            GridOnlyView(model: model)
        }
    }
}

