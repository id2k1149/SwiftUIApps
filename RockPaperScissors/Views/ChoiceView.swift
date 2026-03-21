//
//  ChoiceView.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

struct ChoiceView: View {
    
    let selected: RPSChoice?
    let isLocked: Bool
    let onSelect: (RPSChoice) -> Void
    
    private let itemSize: CGFloat = 100
    
    var body: some View {
        HStack(spacing: 20) {
            ForEach(RPSChoice.allCases, id: \.self) { choice in
                Image(choice.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: itemSize, height: itemSize)
                    .padding(4)
                    .background(selected == choice ? Color.red : Color.clear)
                    .cornerRadius(8)
                    .onTapGesture {
                        guard !isLocked else { return }
                        onSelect(choice)
                    }
            }
        }
    }
}
