//
//  ContentView.swift
//  SlotMachine
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/18/26.
//

import SwiftUI
import Combine

// MARK: - ViewModel
class SlotMachineViewModel: ObservableObject {
    let images = ["img1", "img2", "img3"]
    let itemSize: CGFloat = 80
    
    @Published var offsetY: CGFloat = 0
    @Published var isSpinning = false
    @Published var selectedIndex: Int? = nil
    @Published var resultText: String = ""
    
    private var targetIndex: Int = 0
    private var speed: CGFloat = 0
    private var timer: Timer?
    
    // MARK: - Spin
    func startSpin() {
        guard !isSpinning, selectedIndex != nil else { return }
        
        resultText = ""
        isSpinning = true
        speed = 12
        targetIndex = Int.random(in: 0..<images.count)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.offsetY -= self.speed
            let totalHeight = self.itemSize * CGFloat(self.images.count)
            if -self.offsetY >= totalHeight {
                self.offsetY += totalHeight
            }
        }
        
        // Через случайное время начинаем замедление
        let stopTime = Double.random(in: 2.0...4.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + stopTime) {
            self.startDeceleration()
        }
    }
    
    // MARK: - Замедление до targetIndex
    private func startDeceleration() {
        let totalHeight = itemSize * CGFloat(images.count)
        let currentPos = (-offsetY).truncatingRemainder(dividingBy: totalHeight)
        let finalOffset = CGFloat(targetIndex) * itemSize
        let distance = finalOffset - currentPos + totalHeight * 2
        
        let steps = 60.0
        let stepSpeed = speed / CGFloat(steps)
        let stepDistance = distance / CGFloat(steps)
        var remaining = Int(steps)
        
        Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { [weak self] t in
            guard let self = self else { return }
            if remaining <= 0 {
                self.speed = 0
                self.offsetY = -CGFloat(self.targetIndex) * self.itemSize
                self.isSpinning = false
                t.invalidate()
                
                // Вычисляем результат
                self.determineResult()
                return
            }
            
            self.speed -= stepSpeed
            self.offsetY -= stepDistance
            remaining -= 1
        }
    }
    
    // MARK: - Логика игры 0>1>2>0
    private func determineResult() {
        guard let user = selectedIndex else { return }
        let computer = targetIndex
        
        if user == computer {
            resultText = "Draw"
        } else if (user == 0 && computer == 1) ||
                  (user == 1 && computer == 2) ||
                  (user == 2 && computer == 0) {
            resultText = "Win"
        } else {
            resultText = "Lose"
        }
    }
    
    // MARK: - Сброс
    func resetSelection() {
        if !isSpinning {
            selectedIndex = nil
            resultText = ""
        }
    }
}

// MARK: - View
struct SlotMachineMVVMView: View {
    @StateObject private var vm = SlotMachineViewModel()
    
    var body: some View {
        VStack(spacing: 30) {
            
            // Барабан
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: vm.itemSize, height: vm.itemSize)
                    .clipped()
                    .overlay(
                        VStack(spacing: 0) {
                            ForEach(0..<vm.images.count * 3, id: \.self) { i in
                                Image(vm.images[i % vm.images.count])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: vm.itemSize, height: vm.itemSize)
                            }
                        }
                        .offset(y: vm.offsetY)
                    )
                    .border(Color.black, width: 2)
            }
            
            // Кнопка Spin
            Button(action: vm.startSpin) {
                Text(vm.isSpinning ? "Spinning..." : "Spin")
                    .font(.title2)
                    .padding()
                    .frame(width: 200)
                    .background((vm.selectedIndex == nil || vm.isSpinning) ? Color.gray : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .disabled(vm.selectedIndex == nil || vm.isSpinning)
            
            // Нижний ряд выбора
            HStack(spacing: 20) {
                ForEach(0..<vm.images.count, id: \.self) { i in
                    Image(vm.images[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: vm.itemSize, height: vm.itemSize)
                        .padding(4)
                        .background(vm.selectedIndex == i ? Color.blue.opacity(0.3) : Color.clear)
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(vm.selectedIndex == i ? Color.blue : Color.clear, lineWidth: 3)
                        )
                        .onTapGesture {
                            if !vm.isSpinning {
                                vm.selectedIndex = i
                            }
                        }
                }
            }
            
            // Результат игры
            if !vm.resultText.isEmpty {
                Text(vm.resultText)
                    .font(.title)
                    .bold()
                    .foregroundColor(vm.resultText == "Win" ? .green : (vm.resultText == "Lose" ? .red : .gray))
            }
        }
        .padding()
    }
}

#Preview {
    SlotMachineMVVMView()
}
