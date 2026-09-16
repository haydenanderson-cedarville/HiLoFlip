//
//  LeaderboardService.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/23/26.
//

import Foundation

protocol LeaderboardService {
    func record(_ entry: LeaderboardEntry)
    func topEntries(limit: Int) -> [LeaderboardEntry]
}
