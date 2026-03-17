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
    @Published var timeRemaining: Int = 10          // секунда на каждый вопрос
    
    private var timer: Timer?                        // сам таймер

    // MARK: - Инициализация
    init(questions: [Question]) {
        self.questions = questions.shuffled()       // перемешиваем вопросы
        startTimer()
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
        timer?.invalidate()
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
            // После изменения currentQuestionIndex
            startTimer()
        } else {
            showResult = true
        }
    }
    
    // MARK: start Timer
    private func startTimer() {
        // Сбрасываем таймер
        timer?.invalidate()
        timeRemaining = 10
        
        // Создаём новый таймер
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            } else {
                // Время вышло — считаем неправильным и идём дальше
                self.lastAnswerCorrect = false
                self.timer?.invalidate()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.goToNextQuestion()
                }
            }
        }
    }

    // MARK: - Сброс викторины
    func resetQuiz() {
        currentQuestionIndex = 0
        score = 0
        showResult = false
        questions.shuffle()
        startTimer()
    }
}
