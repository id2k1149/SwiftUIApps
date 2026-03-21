//
//  GameResult.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

enum GameResult: String {
    case win = "Win"
    case lose = "Lose"
    case draw = "Draw"
    
    static func calculate(user: RPSChoice, opponent: RPSChoice) -> GameResult {
        if user == opponent { return .draw }
        
        switch (user, opponent) {
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
            return .win
        default:
            return .lose
        }
    }
}
