//
//  GameView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/9/26.
//


import SwiftUI

struct GameView: View {
    
    var game = HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"])
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.hiLoGreen)
                .ignoresSafeArea()
            VStack {
                PlayerView
                HStack {
                    TokenView()
                    Button("Shuffle") {
                        game.resetGame()
                    }
                        .buttonStyle(.borderedProminent)
                        .padding(10)
                }
                PlayerView
            }
        }
    }
    
    @ViewBuilder
    private var PlayerView: some View {
        let columns = Array(repeating: GridItem(), count: 4)
        
        ScrollView {
            LazyVGrid(columns: columns) {
                    CardView(card: HiLoGame.Card(value: 0))
                    CardView(card: HiLoGame.Card(value: 1))
                    CardView(card: HiLoGame.Card(value: 2))
                    CardView(card: HiLoGame.Card(value: 3))
                    CardView(card: HiLoGame.Card(value: 4))
                    CardView(card: HiLoGame.Card(value: 5))
                    CardView(card: HiLoGame.Card(value: 6))
            }
            .scaleEffect(0.9)
        }
    }
    

    
}

#Preview {
    GameView()
}
