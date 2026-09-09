//
//  CardifyModifier.swift
//  UnoGame
//
//  Created by John Delano on 9/2/26.
//

import SwiftUI

struct CardifyModifier: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            // White outer card with black border
            if isFaceUp {
                content
            } else {
                cardBack()
            }
        }
        .frame(width: 100, height: 155)
    }
    
    @ViewBuilder
    private func cardBack() -> some View {
        RoundedRectangle(cornerRadius: 15)
            .frame(width: 100, height: 155)
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(CardifyModifier(isFaceUp: isFaceUp))
    }
}
