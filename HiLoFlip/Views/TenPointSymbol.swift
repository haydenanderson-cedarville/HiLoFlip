//
//  Star.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 10/19/26.
//

import SwiftUI

struct TenPointSymbol: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(
            x: rect.midX,
            y: rect.midY
        )
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius * 0.45
        
        for i in 0...10 {
            let angle = (-Double.pi / 2) + Double(i) * (2 * Double.pi / 10)
            let radius = i.isMultiple(of: 2) ? outerRadius : innerRadius
            
            let x = center.x + radius * cos(angle)
            let y = center.y + radius * sin(angle)
            let point = CGPoint(x: x, y: y)
            
            i == 0 ? path.move(to: point) : path.addLine(to: point)
        }
        path.closeSubpath()
        
        return path
    }
    
    var body: some View {
        fill(.black)
    }
}

#Preview {
    TenPointSymbol()
        .frame(width: 100, height: 100)
}
