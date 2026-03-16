//
//  ContentView.swift
//  DiceRollerApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var diceNumber = 1 // текущее число кубика

    var body: some View {
        VStack(spacing: 40) {
            Text("Dice Roller")
                .font(.largeTitle)
                .fontWeight(.bold)

            Image("dice\(diceNumber)")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            Button(action: {
                // Генерация случайного числа от 1 до 6
                diceNumber = Int.random(in: 1...6)
            }) {
                Text("Roll Dice")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background(Color.red)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
