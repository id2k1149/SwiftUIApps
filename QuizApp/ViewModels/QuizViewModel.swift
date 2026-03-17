//
//  QuizViewModel.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import SwiftUI

class QuizViewModel: ObservableObject {
    // MARK: - Данные
    @Published var questions: [Question] = []      // массив всех вопросов
    @Published var currentQuestionIndex = 0        // индекс текущего вопроса
    @Published var score = 0                        // счет правильных ответов
    @Published var showResult = false               // показывать экран результата
    @Published var lastAnswerCorrect: Bool? = nil   // feedback

    // MARK: - Инициализация
    init(questions: [Question]) {
        self.questions = questions.shuffled()       // перемешиваем вопросы
    }

    // MARK: - Текущий вопрос
    var currentQuestion: Question {
        questions[currentQuestionIndex]
    }

    // MARK: - Выбор ответа
    func answerSelected(_ answer: Answer) {
            lastAnswerCorrect = answer.isCorrect
            
            // Увеличиваем счет, если ответ правильный
            if answer.isCorrect {
                score += 1
            }
            
            // Переход к следующему вопрос с небольшой задержкой (0.8 сек)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.lastAnswerCorrect = nil
                self.goToNextQuestion()
            }
    }

    // MARK: - Переход к следующему вопросу
    private func goToNextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
        } else {
            showResult = true
        }
    }

    // MARK: - Сброс викторины
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showResult = false
        questions.shuffle()
    }
}
