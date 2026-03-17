//
//  Answer.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import Foundation

struct Answer: Identifiable {
    let id = UUID()
    let text: String
    let isCorrect: Bool
}
