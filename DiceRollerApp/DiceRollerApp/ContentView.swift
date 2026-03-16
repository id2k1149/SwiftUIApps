//
//  ContentView.swift
//  DiceRollerApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var diceNumber = 1
    @State private var rotation = 0.0
    @State private var scale: CGFloat = 1.0

    var body: some View {
        VStack(spacing: 40) {
            Text("Dice Roller")
                .font(.largeTitle)
                .fontWeight(.bold)

            Image("dice\(diceNumber)")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .rotationEffect(.degrees(rotation))
                // подпрыгивание
                .scaleEffect(scale)
                // shadow
                .shadow(radius: 10)
                .animation(.easeOut(duration: 0.6), value: rotation)

            Button(action: {

                // новое случайное число
                diceNumber = Int.random(in: 1...6)

                // добавляем вращение
//                rotation += 360
//                rotation += Double.random(in: 720...1440)
                let spins = Double.random(in: 360...720)
                let direction = Bool.random() ? 1.0 : -1.0

                rotation += spins * direction
                
                //*
                // подпрыгивание
                scale = 1.4

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    scale = 1.0
                }
                // */

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
