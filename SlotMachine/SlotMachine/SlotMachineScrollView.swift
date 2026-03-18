//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI

struct SlotMachineScrollView: View {
    
    let images = ["img1", "img2", "img3"]
    
    @State private var offsetY: CGFloat = 0
    @State private var isSpinning = false
    @State private var timer: Timer?
    
    let imageHeight: CGFloat = 150
    
    var body: some View {
        VStack(spacing: 40) {
            
            ZStack {
                // Окно слота
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 150, height: imageHeight)
                    .clipped()
                    .overlay(
                        VStack(spacing: 0) {
                            ForEach(0..<images.count * 3, id: \.self) { i in
                                Image(images[i % images.count])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: imageHeight)
                            }
                        }
                        .offset(y: offsetY)
                    )
                    .border(Color.black, width: 2)
            }
            
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
        offsetY = 0
        
        // Таймер для плавного движения барабана
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            offsetY -= 5
            
            // Зацикливание: как только “прошел” один цикл картинок, сброс
            let totalHeight = imageHeight * CGFloat(images.count)
            if -offsetY >= totalHeight {
                offsetY = 0
            }
        }
        
        // Длительность вращения
        let stopTime = Double.random(in: 2...4)
        DispatchQueue.main.asyncAfter(deadline: .now() + stopTime) {
            stopSpinning()
        }
    }
    
    func stopSpinning() {
        timer?.invalidate()
        timer = nil
        
        // Выбираем случайную картинку для показа
        let finalIndex = Int.random(in: 0..<images.count)
        withAnimation(.easeOut(duration: 0.5)) {
            offsetY = -CGFloat(finalIndex) * imageHeight
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            isSpinning = false
        }
    }
}

#Preview {
    SlotMachineScrollView()
}
