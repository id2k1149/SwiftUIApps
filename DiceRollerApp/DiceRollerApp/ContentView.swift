//
//  ContentView.swift
//  DiceRollerApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var dice1 = 1
    @State private var dice2 = 1
    
    @State private var rotation1 = 0.0
    @State private var rotation2 = 0.0
    
    @State private var offset1 = 0.0
    @State private var offset2 = 0.0
    
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 40) {
            Text("Dice Roller")
                .font(.largeTitle)
                .fontWeight(.bold)

            
            HStack(spacing: 0) {
                
                Image("dice\(dice1)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .rotationEffect(.degrees(rotation1))
                        .scaleEffect(scale)
                        .offset(x: -offset1)
                        .shadow(radius: 10)
                
                Image("dice\(dice2)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150)
                        .rotationEffect(.degrees(rotation2))
                        .scaleEffect(scale)
                        .offset(x: -offset2)
                        .shadow(radius: 10)
            }
            .animation(.easeOut(duration: 0.7), value: rotation1)
            .animation(.easeOut(duration: 0.9), value: rotation2)

            Button(action: {

                // новое случайное число
                dice1 = Int.random(in: 1...6)
                dice2 = Int.random(in: 1...6)

                
                let spins1 = Double.random(in: 360...720)
                let spins2 = Double.random(in: 360...720)
                
                let direction1 = Bool.random() ? 1.0 : -1.0
                let direction2 = Bool.random() ? 1.0 : -1.0

                rotation1 += spins1 * direction1
                rotation2 += spins2 * direction2
                
                
                // подпрыгивание
                scale = 1.5
                
                // разъезжаются
                offset1 = -60
                offset2 = 60

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    scale = 1.0
                    offset1 = 0
                    offset2 = 0
                }

            }) {
                Text("Roll Dice")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Capsule())
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
