//
//  LocalLeaderboardService.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/23/26.
//

import Foundation

class LocalLeaderboardService: LeaderboardService {
    private static let fileURL = URL.documentsDirectory
        .appending(path: "leaderboard.json")
    
    private var entries: [LeaderboardEntry] = [] {
        didSet {
            _ = try? JSONEncoder().encode(entries).write(to: Self.fileURL)
        }
    }
    
    init() {
        if let data = try? Data(contentsOf: Self.fileURL),
           let save = try? JSONDecoder().decode([LeaderboardEntry].self, from: data) {
            entries = save
        }
    }
    
    func record(_ entry: LeaderboardEntry) {
        entries.append(entry)
    }
    
    func topEntries(limit: Int) -> [LeaderboardEntry] {
        let sortedEntries = entries.sorted { $0.score > $1.score }
        return Array(sortedEntries.prefix(max(0, limit)))
    }
}
