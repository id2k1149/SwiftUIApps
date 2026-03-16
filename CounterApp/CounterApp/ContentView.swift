//
//  ContentView.swift
//  CounterApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/16/26.
//

import SwiftUI

struct ContentView: View {
    @State private var count = 0
    
    var body: some View {
        VStack(spacing: 40) {
            Text("\(count)")
                .font(.system(size: 60))
            
            HStack(spacing: 40) {
                Button("-") { count -= 1 }
                Button("+") { count += 1 }
            }
            .font(.largeTitle)
        }
    }
}

#Preview {
    ContentView()
}
