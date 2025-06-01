//
//  BingoModel.swift
//  bingo
//
//  Created by Olivier Maghe on 01/06/2025.
//

import Foundation
import SwiftUI

class BingoModel: ObservableObject {
    @Published var drawnNumbers: [Int] = []

    let maxNumber = 90

    func drawNumber() {
        let availableNumbers = (1...maxNumber).filter { !drawnNumbers.contains($0) }
        guard let newNumber = availableNumbers.randomElement() else { return }
        drawnNumbers.append(newNumber)
    }

    func toggleNumber(_ num: Int) {
        if let index = drawnNumbers.firstIndex(of: num) {
            drawnNumbers.remove(at: index)
        } else {
            drawnNumbers.insert(num, at: 0)
        }
    }

    func reset() {
        drawnNumbers.removeAll()
    }
}
