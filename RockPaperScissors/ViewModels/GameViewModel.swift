//
//  GameViewModel.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

final class GameViewModel: ObservableObject {
    
    // MARK: - Published State
    
    @Published var offset: CGFloat = 0
    @Published var selectedChoice: RPSChoice? = nil
    @Published var isSpinning = false
    @Published var result: GameResult? = nil
    
    // MARK: - Constants
    
    let itemSize: CGFloat = 100
    
    // MARK: - Actions
    
    func select(_ choice: RPSChoice) {
        guard !isSpinning else { return }
        selectedChoice = choice
    }
    
    func spin() {
        guard selectedChoice != nil else { return }
        
        result = nil
        isSpinning = true
        offset = 0
        
        let target = RPSChoice.allCases.randomElement()!
        let cycles = Int.random(in: 3...6)
        
        let totalHeight = itemSize * CGFloat(RPSChoice.allCases.count)
        let finalOffset = -CGFloat(cycles) * totalHeight - CGFloat(target.rawValue) * itemSize
        
        withAnimation(.easeOut(duration: 2)) {
            offset = finalOffset
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if let user = self.selectedChoice {
                self.result = GameResult.calculate(user: user, opponent: target)
            }
            self.isSpinning = false
        }
    }
}
