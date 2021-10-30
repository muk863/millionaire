//
//  QuestionBuolder.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import Foundation

class QuestionBuilder {
    private var question: Question
    
    init(question: Question) {
        self.question = question
    }
    
    func question(_ question: String) -> QuestionBuilder {
        self.question.question = question
        return self
    }
    
    func rightAnswer(_ answer: String) -> QuestionBuilder {
        self.question.answers[0] = answer
        return self
    }
    
    func answer2(_ answer: String) -> QuestionBuilder {
        self.question.answers[1] = answer
        return self
    }
    
    func answer3(_ answer: String) -> QuestionBuilder {
        self.question.answers[2] = answer
        return self
    }
    
    func answer4(_ answer: String) -> QuestionBuilder {
        self.question.answers[3] = answer
        return self
    }
    
    func build() -> Question {
        return question
    }
}
