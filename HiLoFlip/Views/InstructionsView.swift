//
//  InstructionsView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 11/2/26.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                Text("On your turn, look at the Hi-Lo chip. If 'Hi' is face-up, you must play a card to the discard pile that’s higher than the current top card of the pile. If 'Lo' is face-up,then you must play a lower card.")
                Text("Note: If you are starting a round, form a new discard pile by playing any card from your hand next to the draw pile.")
                Text("You must play a card if possible, but if not then flip the Hi-Lo chip. If the chip lands on the opposite side, play a card from your hand and end your turn. If it lands on the same side as before, draw the top card of the draw pile and play it if possible. If you’re still unable to play a card, you’ll instead make a “reset” play. To make a reset play, first, the player who most recently played a card collects all the cards in the discard pile. (Keep collected cards in a face-down pile in front of you.) Then, play any card from your hand to start a new discard pile. Play proceeds clockwise, with the next player following the same rules as above.")
                Text("Note: If the draw pile ever runs out, keep the top card of the discard pile and shuffle the rest of the cards in the discard pile to form a new draw pile.")
                Text("Cards ending in “1”: Playing one of these cards causes the next player to draw 1 card and immediately skip their turn.")
                Text("Cards ending in “2”: When you play a card ending in 2, you must immediately play a second card, unless it was your final card.")
                Text("Cards ending in “0”: These cards are each worth 10 points when scoring (see: “Ending the Round”).")
                Text("The round ends when one player has discarded all the cards in their hand. That player wins all of the cards in the current discard pile and receives a bonus of 10 points for going out. All players count the cards they collected and score 10 points for each card ending in “0”, and 1 point each for all other cards. Each player announces their total for the scorekeeper to tally.")
            }
            .padding(20)
            .navigationTitle("How to Play")
        }
    }
}

#Preview {
    NavigationStack {
        InstructionsView()
    }
}
