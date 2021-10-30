//
//  Game.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import Foundation

class Game {
    
    public static let shared = Game()
    
    public var session: GameSession? = nil
    
    public let sessionCaretaker: MementoCaretaker = MementoCaretaker<GameSession>()
    
    public let userQuestionCaretaker: MementoCaretaker = MementoCaretaker<Question>()
    
    private(set) var records:[GameSession]
    
    private(set) var userQuestions: [Question]
    
    private init() {
        self.records = self.sessionCaretaker.retrieveResults()
        self.userQuestions = self.userQuestionCaretaker.retrieveResults()
    }
    
    var shuffledQuestionsStrategy: ShuffledQuestionsStrategy = NotShufledQuestionsStrategy()
    
    func recordsAppend(session:GameSession){
        records.insert(session, at: 0)
        sessionCaretaker.save(results: records)
    }
    
    func getQuestions()->[Question]{
        var unionQuestions = questions
        unionQuestions.append(contentsOf: userQuestions)
        
        return shuffledQuestionsStrategy.shuffledQuestion(questions: unionQuestions)
    }
    
    func appendUserQuestions(userQuestions: [Question]){
        self.userQuestions.append(contentsOf: userQuestions)
        userQuestionCaretaker.save(results: self.userQuestions)
    }
    
    func deleteUserQuestion(index: Int){
        self.userQuestions.remove(at: index)
        userQuestionCaretaker.save(results: self.userQuestions)
    }
    
    private let questions: [Question] = {
        var quest: [Question] = []
        quest.append(Question(question: "Какое насекомое вызвало короткое замыкание в ранней версии вычислительной машины, тем самым породив термин «компьютерный баг» («баг» в переводе с англ. «насекомое»)?",
                              answers: ["Мотылек", "Таракан", "Муха", "Японский хрущик"]))
        quest.append(Question(question: "Под каким названием известна единица с последующими ста нулями?",
                              answers: ["Гугол", "Мегатрон", "Гигабит", "Наномоль"]))
        quest.append(Question(question: "Какой химический элемент составляет более половины массы тела человека?",
                              answers: ["Кислород", "Углерод", "Кальций", "Железо"]))
        quest.append(Question(question: "Что означает гавайское слово «вики», которое дало название интернет-энциклопедии «Википедия»?",
                              answers: ["Быстрый", "Простой", "Изученный", "Маленький"]))
        quest.append(Question(question: "Какого цвета крайнее правое кольцо в олимпийской символике?",
                              answers: ["Красное", "Синее", "Желтое", "Зеленое"]))
        return quest
    }()
    
}
