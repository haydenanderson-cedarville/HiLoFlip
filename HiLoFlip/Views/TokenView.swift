//
//  TokenView.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/9/26.
//

import SwiftUI

struct TokenView: View {
    var tokenFaceBool: Bool
    var tokenFace: TokenSide {
        return (tokenFaceBool ? .hi : .lo)
    }
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 150, height: 150)
                .padding(10)
            Circle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2))
                .foregroundStyle(Color.white)
                .frame(width: 140, height: 140)
            Text(tokenFace.label)
                .font(.system(size: 35))
                .bold()
                .foregroundStyle(.white)
        }
//        .onTapGesture {
//            tokenFaceBool.toggle()
//        }
    }
}

#Preview {
    TokenView(tokenFaceBool: true)
}
