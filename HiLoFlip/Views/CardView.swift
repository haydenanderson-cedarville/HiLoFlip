//
//  CardView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/9/26.
//

import SwiftUI

struct CardView: View {

    var card: HiLoGame.Card

    var body: some View {
        cardFront
            .cardify(isFaceUp: card.isFaceUp)
    }
    
    @ViewBuilder
    private var cardFront: some View {
        cardBody(symbol: card.value)
        
        cardSymbol(symbol: card.value, size: 30)
        
        cornerSymbols
    }
    
    private func colorForIndex(_ index: Int) -> Color {
        let hue = Double(index) / 100.0
        return Color(hue: hue, saturation: 0.8, brightness: 1)
    }
    
    private func cardBody(symbol: Int) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(colorForIndex(symbol))
                .frame(width: 100, height: 155)
            Circle()
                .fill(.black)
                .frame(width: 65, height: 65)
        }
    }
    
    private var cornerSymbols: some View {
        VStack {
            HStack {
                circleWithSymbol(symbolType: symbol(for: card.value), circleColor: .white, textColor: .black, size: 25)
                Spacer()
            }
            Spacer()
            HStack {
                Spacer()
                circleWithSymbol(symbolType: symbol(for: card.value), circleColor: .white, textColor: .black, size: 25)
            }
        }
        .padding(6)
    }
    
    
    private func cardSymbol(symbol: Int, size: CGFloat) -> some View {
        Text("\(symbol)")
            .font(.system(size: size))
            .bold()
            .underline(symbol == 6 || symbol == 9)
            .foregroundStyle(.white)
    }
    
    private func symbol(for number: Int) -> SpecialSymbol? {
        switch number % 10 {
        case 0:
            return .tenPoint
        case 1:
            return .skip
        case 2:
            return .mustPlaySecond
        default:
            return nil
        }
    }
    
    private func circleWithSymbol(symbolType: SpecialSymbol?, circleColor: Color, textColor: Color, size: CGFloat) -> some View {
        ZStack {
            if let symbolType {
                Circle()
                    .fill(circleColor)
                    .frame(width: size, height: size)
                if symbolType == .tenPoint {
                    TenPointSymbol()
                        .scaleEffect(0.8)
                } else if symbolType == .skip {
                    SkipSymbol()
                        .scaleEffect(1.2)
                } else {
                    MustPlaySecondSymbol()
                        .scaleEffect(0.5)
                }
            }
        }
        .frame(width: size, height: size)
    }
}
    
#Preview {
    CardView(card: HiLoGame.Card(value: 0))
}
