//
//  ContentView.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import SwiftUI

struct ContentView: View {
    // Создаём ViewModel как StateObject, чтобы SwiftUI отслеживал изменения
    @StateObject private var viewModel = QuizViewModel(questions: [
        Question(
            text: "Столица Франции?",
            answers: [
                Answer(text: "Лондон", isCorrect: false),
                Answer(text: "Париж", isCorrect: true),
                Answer(text: "Берлин", isCorrect: false)
            ]
        ),
        Question(
            text: "Сколько планет в Солнечной системе?",
            answers: [
                Answer(text: "7", isCorrect: false),
                Answer(text: "8", isCorrect: true),
                Answer(text: "9", isCorrect: false)
            ]
        ),
        Question(
            text: "На каком континенте находится Египет?",
            answers: [
                Answer(text: "Азия", isCorrect: false),
                Answer(text: "Африка", isCorrect: true),
                Answer(text: "Европа", isCorrect: false)
            ]
        )
    ])
    
    var body: some View {
        // Передаём ViewModel в QuizView
        QuizView(viewModel: viewModel)
    }
}

#Preview {
    ContentView()
}
