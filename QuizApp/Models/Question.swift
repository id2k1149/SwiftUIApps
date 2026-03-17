//
//  Question.swift
//  QuizApp
//
//  Created by Alfred Thaddeus Crane Pennyworth on 3/17/26.
//

import Foundation

struct Question: Identifiable {
    let id = UUID()
    let text: String
    let answers: [Answer]
}
