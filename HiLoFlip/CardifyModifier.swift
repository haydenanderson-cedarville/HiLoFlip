//
//  CardifyModifier.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/9/26.
//

import SwiftUI

struct CardifyModifier: ViewModifier {
    let isFaceUp: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                content
            } else {
                cardBack()
            }
        }
        .frame(width: 100, height: 155)
    }
    
    @ViewBuilder
    private func tokenBody(_ text: String) -> some View {
        ZStack {
            Circle()
                .strokeBorder(.white, lineWidth: 1)
                .foregroundStyle(Color.black)
                .frame(width: 55, height: 55)
            Text("\(text)")
                .font(.system(size: 30))
                .bold()
                .foregroundStyle(Color.white)
        }
    }
    
    @ViewBuilder
    private func cardBack() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .frame(width: 100, height: 155)
            VStack {
                HStack {
                    tokenBody("HI")
                    Spacer()
                }
                Spacer()
                    .frame(height: 10)
                HStack {
                    Spacer()
                    tokenBody("LO")
                }
            }
            .padding(6)
        }
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(CardifyModifier(isFaceUp: isFaceUp))
    }
}
