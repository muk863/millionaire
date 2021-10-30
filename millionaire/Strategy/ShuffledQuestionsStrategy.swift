//
//  ShuffledQuestionsStrategy.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import Foundation

protocol ShuffledQuestionsStrategy {
    func shuffledQuestion(questions: [Question]) -> [Question]
}


class NotShufledQuestionsStrategy: ShuffledQuestionsStrategy{
    func shuffledQuestion(questions: [Question]) -> [Question] {
        return questions
    }
}

class ShufledQuestionsStrategy: ShuffledQuestionsStrategy{
    func shuffledQuestion(questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
