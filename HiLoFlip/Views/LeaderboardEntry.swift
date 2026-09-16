//
//  LeaderboardEntry.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/23/26.
//

import Foundation

struct LeaderboardEntry: Codable {
    let playerName: String
    let score: Int
    let createdAt: String
}
