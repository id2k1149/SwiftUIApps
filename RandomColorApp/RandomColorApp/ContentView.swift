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
                                    // Цвет текста
                                    .foregroundColor(.white)
                                    // Голубой фон кнопки
                                    .background(Color.blue)
                                    // Кнопка в форме капсулы
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            // Черная окантовка
                                            .stroke(Color.black, lineWidth: 2)
                                        )
            }
        }
    }
}

#Preview {
    ContentView()
}
