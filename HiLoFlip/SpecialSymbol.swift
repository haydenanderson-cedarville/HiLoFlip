//
//  SpecialSymbol.swift
//  HiLoFlip
//
//  Created by Hayden Anderson on 9/16/26.
//

import Foundation

enum SpecialSymbol {
    case tenPoint, skip, mustPlaySecond
    
    var sfSymbolName: String {
        switch self {
            case .tenPoint:
                return "star.fill"
            case .skip:
                return "circle.slash"
            case .mustPlaySecond:
                return "doc.on.doc.fill"
        }
    }
}
