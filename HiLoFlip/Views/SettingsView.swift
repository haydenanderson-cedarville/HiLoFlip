//
//  SettingsView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/2/26.
//

import SwiftUI

struct SettingsView: View {
    
    @AppStorage("favoriteColor") private var favoriteColor = "Red"
    
    @AppStorage("playerName1") private var playerName1 = "Player 1"
    @AppStorage("playerName2") private var playerName2 = "Player 2"

    var body: some View {
        Form {
            TextField("Player 1 name", text: $playerName1)
            TextField("Player 2 name", text: $playerName2)
            TextField("Favorite color", text: $favoriteColor)
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
