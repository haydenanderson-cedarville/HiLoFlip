//
//  HiLoFlipCardGame.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/1/26.
//

import SwiftUI
import Foundation

@Observable
class HiLoFlipCardGame {
    var leaderboard: LeaderboardService = LocalLeaderboardService()
    private static let fileURL = URL.documentsDirectory
        .appending(path: "save.json")
    var players: [HiLoGame.Player] { game.players }
    var isTokenHi: Bool { game.isTokenHi }
    var currentPlayerIndex: Int { game.currentPlayerIndex }
    var winner: String? { game.winner }
    var mustPlaySecond: Bool { game.mustPlaySecond }
    var isResetPlay: Bool { game.isResetPlay }
    var hasPlayableCard: Bool { game.hasPlayableCard }
    
    var game: HiLoGame {
        didSet {
            _ = try? JSONEncoder().encode(game).write(to: Self.fileURL)
        }
    }

    var playerOneName: String {
        get {
            game.players[0].name
        }
        set {
            game.renamePlayer(at: 0, to: newValue)
        }
    }
    
    var playerTwoName: String {
        get {
            game.players[1].name
        }
        set {
            game.renamePlayer(at: 1, to: newValue)
        }
    }
    
    init(playerNames: [String]) {
        if let data = try? Data(contentsOf: Self.fileURL),
            let save = try? JSONDecoder().decode(HiLoGame.self, from: data) {
            self.game = save
        }
        else {
            self.game = HiLoGame(playerNames: playerNames)
            _ = try? JSONEncoder().encode(game).write(to: Self.fileURL)
        }
    }
    
    func resetGame() {
        game.resetGame()
    }
    
    func hand(for player: HiLoGame.Player) -> [HiLoGame.Card] {
        return player.hand
    }
    
    func canPlay(_ card: HiLoGame.Card, from playerIndex: Int) -> Bool {
        game.canPlay(card, from: playerIndex)
    }
    
    func flipToken() {
        game.flipToken()
    }
    
    func playCard(with id: String) -> Bool {
        let index = game.currentPlayerIndex
        guard let card = game.players[index].hand.first(where: { $0.id.uuidString == id }) else { return false }
        return game.play(card, from: index)
    }
}
