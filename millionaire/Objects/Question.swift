//
//  Question.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import Foundation

class Question: Codable {
    
    public static let answerCount = 4
    var question: String = ""
    var answers = [String](repeating: "", count: answerCount)
    
    init(question: String, answers:[String]) {
        self.question = question
        self.answers = answers
    }
    
    convenience init (question: String, rightAnswer: String, answer2: String, answer3: String, answer4: String) {
        self.init(question: question, answers: [rightAnswer, answer2, answer3, answer4])
    }
    
    convenience init (){
        self.init(question: "", answers: [String](repeating: "", count: Question.answerCount))
    }
}
