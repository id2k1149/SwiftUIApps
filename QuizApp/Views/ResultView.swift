//
//  ResultView.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let total: Int
    var onRestart: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Викторина завершена!")
                .font(.largeTitle)
            
            Text("Ваш результат: \(score)/\(total)")
                .font(.title2)
            
            Button(action: {
                onRestart()
            }) {
                Text("Начать заново")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.7))
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}
