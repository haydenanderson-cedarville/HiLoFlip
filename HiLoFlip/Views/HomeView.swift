//
//  HomeView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/2/26.
//

import SwiftUI

struct HomeView: View {
    @State private var viewModel = HiLoFlipCardGame(
        playerNames: ["Player 1", "Player 2"]
    )

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Color.clear
                    .cardify(isFaceUp: false)
                    .frame(width: 180)
                NavigationLink("New Game") {
                    GameView(game: viewModel)
                        .onAppear { viewModel.resetGame() }
                }
                NavigationLink("Continue Game") {
                    GameView(game: viewModel)
                }
                NavigationLink("Leaderboard") {
                    LeaderboardView()
                }
                NavigationLink("Settings") {
                    SettingsView()
                }
                NavigationLink("Instructions") {
                    InstructionsView()
                }
            }
            .navigationTitle("HiLoFlip")
        }
    }
}

#Preview {
    HomeView()
}
