//
//  ViewController.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        Game.shared.session = GameSession()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if  let gameViewController = storyBoard.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController{
            gameViewController.gameDelegate = self
            self.navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    
    @IBAction func tapResulButton(_ sender: UIButton) {
        
    }
}

extension StartViewController: GameDelegate {
    
    func didEndGame(session: GameSession) {
        print("Money: \(session.amountOfMoney), Level: \(session.level), Answers: \(session.rightAnswerCount)")
        navigationController?.popViewController(animated: true)
        Game.shared.recordsAppend(session: session)
    }
    
}
