//
//  ContentView.swift
//  UnoGame
//
//  Created by John Delano on 8/19/26.
//


import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.hiLoGreen)
                .ignoresSafeArea()
            VStack {
                HStack {
                    CardView_2(cardType: 3)
                    CardView_2(cardType: 10)
                    CardView_2(cardType: 19)
                }
                .padding(20)
                HStack {
                    CardView_2(cardType: 20)
                    CardView_2(cardType: 41)
                    CardView_2(cardType: 52)
                }
            }
        }
    }
    

    
}

#Preview {
    ContentView()
}



