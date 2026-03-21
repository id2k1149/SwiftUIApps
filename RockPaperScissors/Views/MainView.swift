//
//  MainView.swift
//  RockPaperScissors
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/21/26.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var vm = GameViewModel()
    private let resultHeight: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 20) {
            
            Text(vm.result?.rawValue ?? "")
                .frame(height: resultHeight)
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.blue)
            
            SlotView(offset: vm.offset, itemSize: vm.itemSize)
            
            Button("Spin") {
                vm.spin()
            }
            .padding()
            .background(vm.selectedChoice == nil ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            Text("You must select Rock, Paper, or Scissors")
                .font(.subheadline)
            
            ChoiceView(
                selected: vm.selectedChoice,
                isLocked: vm.isSpinning,
                onSelect: vm.select
            )
        }
        .padding()
    }
}

#Preview {
    MainView()
}
