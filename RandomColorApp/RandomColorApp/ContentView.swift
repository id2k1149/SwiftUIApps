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
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    ContentView()
}
