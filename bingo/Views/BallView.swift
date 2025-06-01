//
//  BallView.swift
//  bingo
//
//  Created by Olivier Maghe on 23/05/2025.
//

import SwiftUI

struct BallView: View {
    let number: Int
    let isDrawn: Bool
    let action: () -> Void

    var body: some View {
        Text("\(number)")
            .foregroundColor(.white)
            .frame(width: 30, height: 30)
            .background(isDrawn ? Color.red : Color.blue)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .onTapGesture {
                action()
            }
    }
}
