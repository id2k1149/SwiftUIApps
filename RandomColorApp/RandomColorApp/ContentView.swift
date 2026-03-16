//
//  ContentView.swift
//  RandomColorApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var bgColor = Color.white
    
    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()
            
            Button(action: {
                // Генерация случайного цвета
                bgColor = Color(
                    red: Double.random(in: 0...1),
                    green: Double.random(in: 0...1),
                    blue: Double.random(in: 0...1)
                )
            }) {
                Text("Change Color")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 15)
                                    .foregroundColor(.white)        // Цвет текста
                                    .background(Color.blue)        // Голубой фон кнопки
                                    .clipShape(Capsule())          // Кнопка в форме капсулы
                                    .overlay(
                                        Capsule()
                                            .stroke(Color.black, lineWidth: 2) // Черная окантовка
                                        )
            }
        }
    }
}

#Preview {
    ContentView()
}
