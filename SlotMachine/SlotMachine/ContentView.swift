//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI

struct ContentView: View {
    
    let images = ["img1", "img2", "img3"]
    
    @State private var currentIndex = 0
    @State private var isSpinning = false
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 40) {
            
            // Окно слота
            Image(images[currentIndex])
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipped()
                .border(Color.black, width: 2)
            
            // Кнопка
            Button(action: startSpinning) {
                Text(isSpinning ? "Крутится..." : "Крутить")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background(isSpinning ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(isSpinning)
        }
    }
    
    func startSpinning() {
        isSpinning = true
        
        // Таймер для зацикленного движения
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            currentIndex = (currentIndex + 1) % images.count
        }
        
        // Случайная длительность вращения
        let stopTime = Double.random(in: 2...4)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + stopTime) {
            stopSpinning()
        }
    }
    
    func stopSpinning() {
        timer?.invalidate()
        timer = nil
        
        // Финальная картинка
        currentIndex = Int.random(in: 0..<images.count)
        
        isSpinning = false
    }
}

#Preview {
    ContentView()
}
