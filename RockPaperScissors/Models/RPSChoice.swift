//
//  RPSChoice.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

enum RPSChoice: Int, CaseIterable {
    case rock = 0, paper, scissors
    
    var imageName: String {
        switch self {
        case .rock: return "img0"
        case .paper: return "img1"
        case .scissors: return "img2"
        }
    }
}
