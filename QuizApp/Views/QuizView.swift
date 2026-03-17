//
//  QuizView.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel

    var body: some View {
        VStack {
            if viewModel.showResult {
                ResultView(score: viewModel.score,
                           total: viewModel.questions.count) {
                    viewModel.resetQuiz()
                }
            } else {
                QuestionView(
                    question: viewModel.currentQuestion,
                    onAnswerSelected: { answer in
                        viewModel.answerSelected(answer)
                    },
                    lastAnswerCorrect: viewModel.lastAnswerCorrect, timeRemaining: viewModel.timeRemaining
                )
            }
        }
        .padding()
    }
}
