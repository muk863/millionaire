//
//  GameViewController.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import UIKit

protocol GameDelegate: AnyObject {
    func didEndGame(session: GameSession)
}

final class GameViewController: UIViewController {

    @IBOutlet weak var questionLable: UILabel!
    @IBOutlet var answersLable: [UILabel]!
    
    @IBOutlet weak var progressLable: UILabel!
    
    private var rightAnswer: String = ""
    private var session: GameSession!
    private let cornerRadius: CGFloat = 15
    
    weak var gameDelegate: GameDelegate?
    private var questions: [Question] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        self.questions = Game.shared.getQuestions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        if Game.shared.session != nil{
            session = Game.shared.session!
            setQuestion(question: questions[session.level])
            session.progress.addObserver(Observer(closure:{ progress in
                                                    self.progressLable.text = "Ваш прогресс: \(progress)%"} ))
            session.progress.value = 0
        }else{
            print("Sessions Error!")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func configUI(){
        
        for answerLable in answersLable {
            let tapAnswerGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(tapAnswer))
            tapAnswerGestureRecognize.numberOfTapsRequired = 1
            tapAnswerGestureRecognize.numberOfTouchesRequired = 1
            answerLable.addGestureRecognizer(tapAnswerGestureRecognize)
            answerLable.layer.cornerRadius = cornerRadius
            answerLable.layer.masksToBounds = true
        }

//        callFriendView.layer.cornerRadius = cornerRadius
//        callFriendView.layer.masksToBounds = true
//
//        hallHelpView.layer.cornerRadius = cornerRadius
//        hallHelpView.layer.masksToBounds = true
//        
//        
//        let tapHallHelpGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(tapHelp))
//        hallHelpView.addGestureRecognizer(tapHallHelpGestureRecognize)
//        
//        let tapCallFriendGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(tapHelp))
//        callFriendView.addGestureRecognizer(tapCallFriendGestureRecognize)
//        
//        let tapFiftyHelpGestureRecognize = UITapGestureRecognizer(target: self, action: #selector(tapHelp))
//        fiftyHelpView.addGestureRecognizer(tapFiftyHelpGestureRecognize)
    }

//    @objc func tapHelp(_ sender: UITapGestureRecognizer){
//        switch sender.view {
//        case hallHelpView:
//            self.session.hallHelp = false
//            sender.view?.isHidden = true
//        case callFriendView:
//            self.session.hallHelp = false
//            sender.view?.isHidden = true
//        case fiftyHelpView:
//            self.session.fiftyHelp = false
//            sender.view?.isHidden = true
//        default:
//            break
//        }
//        
//    }

//    @objc func tapCallFriend(_ sender: UITapGestureRecognizer){
//        if session.callFriend {
//            session.callFriend = false
//            sender.view?.isHidden = true
//        }
//    }
    
    @objc func tapAnswer(_ sender: UITapGestureRecognizer){
        guard let answerLable = sender.view as? UILabel,
              let answer = answerLable.text else { return }
        if (answer == rightAnswer){
            session.rightAnswerCount += 1
            session.amountOfMoney += session.amountOfMoney + 100*(session.level + 1)
            session.progress.value = (session.rightAnswerCount*100) / questions.count
            nextQuestion()
        }else{
            gameOver(win: false)
        }
    }

    func setQuestion(question: Question){
        rightAnswer = question.answers[0]
        questionLable.animate(newText: question.question)
        let shufledAnswes = question.answers.shuffled()
        for (index, answer) in shufledAnswes.enumerated() {
            answersLable[index].animate(newText: answer)
        }
    }
    
    func nextQuestion(){
        if (session.level < questions.count - 1){
            session.level += 1
            setQuestion(question: questions[session.level])
        }else{
            gameOver(win: true)
        }
    }
    
    func gameOver(win: Bool) {
        
        let messageMain = win ? "Вы выиграли!"  : "Игра окончена!"
        let messageSub  = win ? "Поздравляем!" : "Очень жаль!"
        
        let alert = UIAlertController(title: messageMain,
            message: messageSub,
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default){ action in
            self.gameDelegate?.didEndGame(session: self.session)
        }
        alert.addAction(okAction)
        present(alert, animated: true)

    }
}

