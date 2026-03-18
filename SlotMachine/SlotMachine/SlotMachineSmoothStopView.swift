//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI

struct SlotMachineLinearStopView: View {
    
    let images = ["img1", "img2", "img3"]
    let imageHeight: CGFloat = 150
    
    @State private var offsetY: CGFloat = 0
    @State private var isSpinning = false
    @State private var speed: CGFloat = 0
    @State private var timer: Timer?
    @State private var targetIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 40) {
            
            ZStack {
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
        speed = 12 // постоянная скорость
        targetIndex = Int.random(in: 0..<images.count)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
            offsetY -= speed
            let totalHeight = imageHeight * CGFloat(images.count)
            if -offsetY >= totalHeight {
                offsetY += totalHeight
            }
        }
        
        // Через случайное время начинаем замедление
        let stopTime = Double.random(in: 2.0...4.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + stopTime) {
            startDeceleration()
        }
    }
    
    func startDeceleration() {
        let totalHeight = imageHeight * CGFloat(images.count)
        let currentPos = (-offsetY).truncatingRemainder(dividingBy: totalHeight)
        let finalOffset = CGFloat(targetIndex) * imageHeight
        let distance = finalOffset - currentPos + totalHeight * 2 // проход несколько циклов
        
        let decelerationSteps = 60.0
        let stepSpeedReduction = speed / CGFloat(decelerationSteps)
        let stepDistance = distance / CGFloat(decelerationSteps)
        
        var stepsRemaining = Int(decelerationSteps)
        
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
            if stepsRemaining <= 0 {
                speed = 0
                offsetY = -finalOffset
                isSpinning = false
                timer.invalidate()
                return
            }
            
            speed -= stepSpeedReduction
            offsetY -= stepDistance
            stepsRemaining -= 1
        }
    }
}

#Preview {
    SlotMachineLinearStopView()
}
