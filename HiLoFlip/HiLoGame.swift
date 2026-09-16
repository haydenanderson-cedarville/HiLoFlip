//
//  HiLoGame.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/1/26.
//

import Foundation

struct HiLoGame: Codable {
    
    private(set) var deck: [Card] = []
    private(set) var discardPile: [Card] = []
    private(set) var players: [Player] = []
    private(set) var isTokenHi = Bool.random()
    private(set) var currentPlayerIndex = 0
    private(set) var mustPlaySecond = false
    private(set) var isResetPlay = false
    private(set) var winner: String? = nil
    private(set) var collectedCards: [[Card]] = [[], []]
    private var lastPlayerIndex: Int? = nil
    
    var currentPlayer: String {
        players[currentPlayerIndex].name
    }
    
    struct Card: Identifiable, Codable {
        private(set) var id = UUID()
        let value: Int
        fileprivate(set) var isFaceUp: Bool = true
        
        var isTenPointCard: Bool { value % 10 == 0 }
        var isSkipCard: Bool { value % 10 == 1 }
        var isMustPlaySecondCard: Bool { value % 10 == 2 }
        
        var isSpecialCard: Bool {
            isTenPointCard || isSkipCard || isMustPlaySecondCard
        }
    }
    
    struct Player: Codable {
        var name: String
        fileprivate(set) var hand: [Card] = []
        private(set) var score = 0
    }
    
    init(playerNames: [String]) {
        for name in playerNames { players.append(Player(name: name)) }
        collectedCards = Array(repeating: [], count: players.count)
        resetGame()
    }
    
    mutating func dealCards() {
        deck.shuffle()
        for index in players.indices {
            for _ in 0..<7 {
                if let card = deck.popLast() {
                    players[index].hand.append(card)
                }
            }
        }
    }
    
    mutating func resetGame() {
        discardPile.removeAll()
        deck.removeAll()
        for number in 1...100 { deck.append(Card(value: number)) }
        for index in players.indices {
            players[index].hand.removeAll()
        }
        
        collectedCards = Array(repeating: [], count: players.count)
        isTokenHi = Bool.random()
        currentPlayerIndex = 0
        lastPlayerIndex = nil
        mustPlaySecond = false
        isResetPlay = false
        winner = nil
        dealCards()
    }
    
    mutating func renamePlayer(at index: Int, to name: String) {
        guard players.indices.contains(index) else { return }
        players[index].name = name
    }
    
    func canPlay(_ card: Card, from index: Int) -> Bool {
        guard winner == nil, players.indices.contains(index),
              index == currentPlayerIndex,
              players[index].hand.contains(where: { $0.id == card.id }) else {
            return false
        }
        if discardPile.isEmpty || isResetPlay { return true }
        guard let top = discardPile.last else { return true }
        return isTokenHi ? card.value > top.value : card.value < top.value
    }
    
    var hasPlayableCard: Bool {
        guard players.indices.contains(currentPlayerIndex) else { return false }
        return players[currentPlayerIndex].hand.contains {
            canPlay($0, from: currentPlayerIndex)
        }
    }
    
    private var otherPlayer: Int {
        (currentPlayerIndex + 1) % players.count
    }
    
    private mutating func switchTurn() {
        lastPlayerIndex = currentPlayerIndex
        currentPlayerIndex = otherPlayer
    }
    
    mutating func play(_ card: Card, from index: Int) -> Bool {
        guard canPlay(card, from: index),
              let position = players[index].hand.firstIndex(where: { $0.id == card.id }) else {
            return false
        }
        let playedCard = players[index].hand.remove(at: position)
        discardPile.append(playedCard)
        mustPlaySecond = false
        isResetPlay = false
        
        if players[index].hand.isEmpty {
            winner = players[index].name
        } else if playedCard.isMustPlaySecondCard {
            mustPlaySecond = true
            if !hasPlayableCard {
                prepareReset(collector: lastPlayerIndex ?? otherPlayer)
            }
        } else if playedCard.isSkipCard {
            drawCard(for: otherPlayer)
            if !hasPlayableCard {
                prepareReset(collector: otherPlayer)
            }
        } else {
            switchTurn()
        }
        return true
    }
    
    private mutating func refillDeckIfNeeded() {
        guard deck.isEmpty, discardPile.count > 1 else { return }
        let top = discardPile.removeLast()
        deck = discardPile
        deck.shuffle()
        discardPile = [top]
    }
    
    private mutating func drawCard(for index: Int) {
        guard players.indices.contains(index) else { return }
        refillDeckIfNeeded()
        if let card = deck.popLast() {
            players[index].hand.append(card)
        }
    }
    
    private mutating func prepareReset(collector: Int) {
        if players.indices.contains(collector) {
            collectedCards[collector].append(contentsOf: discardPile)
        }
        discardPile.removeAll()
        mustPlaySecond = false
        isResetPlay = true
    }
    
    mutating func flipToken() {
        guard winner == nil, !hasPlayableCard, !isResetPlay, !mustPlaySecond else { return }
        
        let side = isTokenHi
        isTokenHi = Bool.random()
    }
}
