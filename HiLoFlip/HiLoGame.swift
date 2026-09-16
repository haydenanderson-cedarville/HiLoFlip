//
//  HiLoGame.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/1/26.
//

import Foundation

struct HiLoGame {
    
    private(set) var deck: [Card]
    private(set) var players: [Player]
    private(set) var isTokenHi: Bool
    
    struct Card {
        let value: Int
        fileprivate(set) var isFaceUp: Bool
        private(set) var isSpecialCard: Bool
        private(set) var isTenPointCard: Bool
        private(set) var isSkipCard: Bool
        private(set) var isMustPlaySecondCard: Bool
        
        init(value: Int) {
            self.value = value
            isFaceUp = true
            isTenPointCard = (value % 10 == 0)
            isSkipCard = (value % 10 == 1)
            isMustPlaySecondCard = (value % 10 == 2)
            isSpecialCard = (isTenPointCard || isSkipCard || isMustPlaySecondCard)
        }
    }
    
    struct Player {
        private(set) var name: String
        fileprivate(set) var hand: [Card]
        private(set) var score: Int
        
        init(name: String) {
            self.name = name
            hand = []
            score = 0
        }
    }
    
    init(playerNames: [String]) {
        self.isTokenHi = false
        self.deck = []
        for number in 1...100 {
            deck.append(Card(value: number))
        }
        self.players = []
        for player in players {
            players.append(Player(name: player.name))
        }
    }
    
    private mutating func dealCards() {
        deck.shuffle()
        for player in players.indices {
            for _ in 0...6 {
                if let card = deck.popLast() {
                    players[player].hand.append(card)
                }
            }
        }
    }
    
    mutating func resetGame() {
        deck.removeAll()
        for number in 1...100 {
            deck.append(Card(value: number))
        }
        for player in players.indices {
            players[player].hand.removeAll()
        }
        dealCards()
    }
}
