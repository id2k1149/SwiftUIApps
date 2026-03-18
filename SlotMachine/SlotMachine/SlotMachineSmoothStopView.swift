//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI

struct SlotMachineGameLogicView: View {
    
    let images = ["img1", "img2", "img3"]
    let itemSize: CGFloat = 80 // размер картинок
    
    @State private var offsetY: CGFloat = 0
    @State private var isSpinning = false
    @State private var speed: CGFloat = 0
    @State private var timer: Timer?
    @State private var targetIndex: Int = 0
    
    @State private var selectedIndex: Int? = nil
    @State private var resultText: String = "" // Win / Lose / Draw
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Барабан
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: itemSize, height: itemSize)
                    .clipped()
                    .overlay(
                        VStack(spacing: 0) {
                            ForEach(0..<images.count * 3, id: \.self) { i in
                                Image(images[i % images.count])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: itemSize, height: itemSize)
                            }
                        }
                        .offset(y: offsetY)
                    )
                    .border(Color.black, width: 2)
            }
            
            // Кнопка вращения
            Button(action: startSpinning) {
                Text(isSpinning ? "Spinning..." : "Spin")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background((selectedIndex == nil || isSpinning) ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(selectedIndex == nil || isSpinning)
            
            // Горизонтальный ряд картинок для выбора
            HStack(spacing: 20) {
                ForEach(0..<images.count, id: \.self) { i in
                    Image(images[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: itemSize, height: itemSize)
                        .padding(4)
                        .background(selectedIndex == i ? Color.blue.opacity(0.3) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(selectedIndex == i ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            if !isSpinning {
                                selectedIndex = i
                            }
                        }
                }
            }
            
            // Результат игры
            if !resultText.isEmpty {
                Text(resultText)
                    .font(.title)
                    .bold()
                    .foregroundColor(resultText == "Win" ? .green : (resultText == "Lose" ? .red : .gray))
            }
        }
        .padding()
    }
    
    // MARK: - Слот-машина
    
    func startSpinning() {
        guard !isSpinning, selectedIndex != nil else { return }
        resultText = "" // сброс результата
        isSpinning = true
        speed = 12
        targetIndex = Int.random(in: 0..<images.count)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { _ in
            offsetY -= speed
            let totalHeight = itemSize * CGFloat(images.count)
            if -offsetY >= totalHeight {
                offsetY += totalHeight
            }
        }
        
        let stopTime = Double.random(in: 2.0...4.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + stopTime) {
            startDeceleration()
        }
    }
    
    func startDeceleration() {
        let totalHeight = itemSize * CGFloat(images.count)
        let currentPos = (-offsetY).truncatingRemainder(dividingBy: totalHeight)
        let finalOffset = CGFloat(targetIndex) * itemSize
        let distance = finalOffset - currentPos + totalHeight * 2
        
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
                
                determineResult()
                return
            }
            
            speed -= stepSpeedReduction
            offsetY -= stepDistance
            stepsRemaining -= 1
        }
    }
    
    // MARK: - Логика игры: 1>2>3>1
    func determineResult() {
        guard let userChoice = selectedIndex else { return }
        let computerChoice = targetIndex
        
        if userChoice == computerChoice {
            resultText = "Draw"
        } else if (userChoice == 0 && computerChoice == 1) ||
                  (userChoice == 1 && computerChoice == 2) ||
                  (userChoice == 2 && computerChoice == 0) {
            resultText = "Win"
        } else {
            resultText = "Lose"
        }
    }
}

#Preview {
    SlotMachineGameLogicView()
}
