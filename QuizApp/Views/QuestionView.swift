//
//  QuestionView.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import SwiftUI

struct QuestionView: View {
    let question: Question
    var onAnswerSelected: (Answer) -> Void
    var lastAnswerCorrect: Bool?  // feedback из ViewModel

    var body: some View {
        VStack(spacing: 20) {
            // Вопрос
            Text(question.text)
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding()

            // Кнопки с ответами
            ForEach(question.answers) { answer in
                Button(action: { onAnswerSelected(answer) }) {
                    Text(answer.text)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(buttonColor(answer: answer))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
                .disabled(lastAnswerCorrect != nil) // блокируем кнопки на время feedback
            }

            // Feedback
            if let correct = lastAnswerCorrect {
                Text(correct ? "Правильно!" : "Неправильно!")
                    .foregroundColor(correct ? .green : .red)
                    .font(.headline)
            }
        }
        .padding()
        .animation(.default, value: lastAnswerCorrect)
    }

    // Цвет кнопки при выборе (подсветка правильного / неправильного)
    private func buttonColor(answer: Answer) -> Color {
        guard let correct = lastAnswerCorrect else { return Color.blue.opacity(0.7) }
        if answer.isCorrect { return .green }
        return .red.opacity(0.7)
    }
}
