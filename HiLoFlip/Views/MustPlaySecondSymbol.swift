//
//  MustPlaySecond.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/19/26.
//

import SwiftUI

struct MustPlaySecondSymbol: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let backRectangle = CGRect(x: rect.minX - rect.width * 0.1, y: rect.minY - rect.height * 0.2, width: rect.width, height: rect.height * 1.3)
        path.addRoundedRect(in: backRectangle, cornerSize: CGSize(width: rect.width * 0.1, height: rect.height * 0.1))
        
        let frontRectangle = CGRect(x: rect.minX + rect.width * 0.1, y: rect.minY, width: rect.width, height: rect.height * 1.3)
        path.addRoundedRect(in: frontRectangle, cornerSize: CGSize(width: rect.width * 0.1, height: rect.height * 0.1))
        return path
    }
}

#Preview {
    MustPlaySecondSymbol()
        .fill(.black)
        .stroke(.white, lineWidth: 1)
        .frame(width: 100, height: 100)
}
