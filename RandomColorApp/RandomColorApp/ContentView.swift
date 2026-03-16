//
//  ContentView.swift
//  RandomColorApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var bgColor = Color.white
    @State private var isPressed = false // состояние нажатия для анимации

    var body: some View {
        ZStack {
            bgColor
                .ignoresSafeArea()

            Button(action: {
                // Меняем цвет фона случайным образом
                bgColor = Color(
                    red: Double.random(in: 0...1),
                    green: Double.random(in: 0...1),
                    blue: Double.random(in: 0...1)
                )

                // Включаем анимацию нажатия
                withAnimation(.easeInOut(duration: 0.1)) {
                    isPressed = true
                }

                // Через короткое время возвращаем к нормальному размеру
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
                        isPressed = false
                    }
                }

            }) {
                Text("Change Color")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(Capsule())
                    .overlay(
                        Capsule()
                            .stroke(Color.white, lineWidth: 2)
                    )
            }
            // Динамическое увеличение при нажатии
            .scaleEffect(isPressed ? 1.2 : 1.0)
            // Маленькая “вибрация” при нажатии
          //  .rotationEffect(.degrees(isPressed ? 5 : 0))
            .animation(.spring(), value: isPressed)
        }
    }
}

#Preview {
    ContentView()
}
