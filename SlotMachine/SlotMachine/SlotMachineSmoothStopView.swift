//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI

struct SlotMachineSmoothStopView: View {
    
    let images = ["img1", "img2", "img3"]
    let imageHeight: CGFloat = 150
    
    @State private var offsetY: CGFloat = 0
    @State private var isSpinning = false
    @State private var targetIndex: Int = 0
    
    // Для повторения картинок (чтобы создать эффект бесконечного вращения)
    var repeatedImages: [String] {
        Array(repeating: images, count: 3).flatMap { $0 }
    }
    
    var body: some View {
        VStack(spacing: 40) {
            
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 150, height: imageHeight)
                    .clipped()
                    .overlay(
                        VStack(spacing: 0) {
                            ForEach(repeatedImages.indices, id: \.self) { i in
                                Image(repeatedImages[i])
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
        guard !isSpinning else { return }
        isSpinning = true
        
        // Случайная цель
        targetIndex = Int.random(in: 0..<images.count)
        
        // Количество повторов для плавного эффекта "бесконечного" вращения
        let spinRounds = images.count * 3
        
        // Случайная длительность вращения
        let duration = Double.random(in: 2...4)
        
        withAnimation(.easeOut(duration: duration)) {
            // Смещаем на несколько повторов + целевой индекс
            offsetY = -CGFloat(spinRounds + targetIndex) * imageHeight
        }
        
        // По окончании анимации корректируем позицию на точный targetIndex
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            offsetY = -CGFloat(targetIndex) * imageHeight
            isSpinning = false
        }
    }
}

#Preview {
    SlotMachineSmoothStopView()
}
