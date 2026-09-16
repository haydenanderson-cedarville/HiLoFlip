//
//  HiLoFlipCardGame.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/1/26.
//

import SwiftUI

@Observable
class HiLoFlipCardGame {
    private var game: HiLoGame
    var players: [HiLoGame.Player]
    {
        get {
            game.players
        }
    }
    var isTokenHi: Bool
    {
        get {
            game.isTokenHi
        }
    }
    
    init(playerNames: [String]) {
        self.game = HiLoGame(playerNames: playerNames)
    }
    
    func resetGame() {
        game.resetGame()
    }
    
    func hand(for player: HiLoGame.Player) -> [HiLoGame.Card] {
        return player.hand
    }
}
