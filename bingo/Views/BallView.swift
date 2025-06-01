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
        GeometryReader { geo in
            Text("\(number)")
                .foregroundColor(.white)
                .font(.system(size: geo.size.width * 0.6, weight: .bold)) // taille du texte proportionnelle
                .frame(width: geo.size.width, height: geo.size.height)
                .background(isDrawn ? Color.red : Color.blue)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .contentShape(Circle()) // pour que le tap soit sur tout le cercle
                .onTapGesture {
                    action()
                }
        }
    }
}
