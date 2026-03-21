//
//  SlotView.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

struct SlotView: View {
    
    let offset: CGFloat
    let itemSize: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke(Color.red, lineWidth: 2)
                .frame(width: itemSize, height: itemSize)
            
            GeometryReader { _ in
                VStack(spacing: 0) {
                    ForEach(0..<RPSChoice.allCases.count * 10, id: \.self) { i in
                        Image(RPSChoice.allCases[i % 3].imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemSize, height: itemSize)
                            .clipped()
                    }
                }
                .offset(y: offset)
            }
            .frame(width: itemSize, height: itemSize)
            .clipped()
        }
    }
}
