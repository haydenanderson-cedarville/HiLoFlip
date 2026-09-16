//
//  GameView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/9/26.
//


import SwiftUI

struct GameView: View {
    @Namespace private var cardNameSpace
    @Environment(\.dismiss) private var dismiss
    let game: HiLoFlipCardGame
    @State private var showingQuitConfirmation = false
    @State private var isOverDiscard = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.hiLoGreen)
                .ignoresSafeArea()
            VStack {
                VStack {
                    Text(game.players[0].name)
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                    playerView(game.players[0], at: 0)
                }
                HStack {
                    VStack {
                        Text("Deck")
                            .foregroundStyle(.white)
                            .bold()
                        if let card = game.game.deck.last {
                            CardView(card: card, isFaceUp: false)
                        } else {
                            Color.clear.cardify(isFaceUp: false)
                        }
                    }
                    TokenView(tokenFaceBool: game.isTokenHi)
                        .onTapGesture {
                            withAnimation { game.flipToken() }
                        }
                    VStack {
                        Text("Discard")
                            .foregroundStyle(.white)
                            .bold()
                        discardCard
                            .frame(width: 100, height: 155)
                            .scaleEffect(isOverDiscard ? 1.05 : 1)
                            .shadow(radius: isOverDiscard ? 8 : 0)
                            .animation(.spring, value: isOverDiscard)
                            .dropDestination(for: String.self) { ids, _ in
                                guard let id = ids.first else { return false }
                                return withAnimation(.spring) {
                                    game.playCard(with: id)
                                }
                            } isTargeted: { targeted in
                                isOverDiscard = targeted
                            }
                    }
                }
                if let winner = game.winner {
                    Text("\(winner) wins the round!")
                        .foregroundStyle(.white)
                } else if game.mustPlaySecond {
                    Text("Play a second card")
                        .foregroundStyle(.white)
                } else if game.isResetPlay {
                    Text("Reset play: play any card")
                        .foregroundStyle(.white)
                } else if !game.hasPlayableCard {
                    Text("No legal move: Tap the HI/LO token!")
                        .foregroundStyle(.white)
                }
                VStack {
                    Text(game.players[1].name)
                        .font(.system(size: 24))
                        .foregroundStyle(.white)
                    playerView(game.players[1], at: 1)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Quit Game") { showingQuitConfirmation = true }
            }
        }
        .confirmationDialog("Quit this game?", isPresented: $showingQuitConfirmation) {
            Button("Quit Game", role: .destructive) { dismiss() }
            Button("Keep Playing", role: .cancel) { }
        }
        .navigationBarBackButtonHidden(true)
    }

    @ViewBuilder
    private var discardCard: some View {
        if let card = game.game.discardPile.last {
            CardView(card: card, isFaceUp: true)
                .matchedGeometryEffect(id: card.id, in: cardNameSpace)
        } else {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(.white, lineWidth: 2)
                .overlay(Text("Play here").foregroundStyle(.white))
        }
    }

    @ViewBuilder
    private func playerView(_ player: HiLoGame.Player, at index: Int) -> some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 9) {
                ForEach(game.hand(for: player), id: \.id) { card in
                    playerCard(card, at: index)
                }
            }
            .scaleEffect(0.9)
        }
    }

    @ViewBuilder
    private func playerCard(_ card: HiLoGame.Card, at index: Int) -> some View {
        if index == game.currentPlayerIndex && game.winner == nil {
            CardView(card: card, isFaceUp: true)
                .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
                .draggable(card.id.uuidString) {
                    CardView(card: card, isFaceUp: true)
                        .scaleEffect(1.05)
                        .shadow(radius: 8)
                }
        } else {
            CardView(card: card, isFaceUp: false)
                .matchedGeometryEffect(id: card.id, in: cardNameSpace)
                .transition(.asymmetric(insertion: .scale.combined(with: .opacity), removal: .opacity))
        }
    }
}

#Preview {
    NavigationStack {
        GameView(game: HiLoFlipCardGame(playerNames: ["Player 1", "Player 2"]))
    }
}
