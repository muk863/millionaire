//
//  SettingsViewController.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    @IBOutlet weak var shuffledQuestionSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shuffledQuestionSegment.addTarget(self, action: #selector(indexSegmentChanged), for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Game.shared.shuffledQuestionsStrategy is ShufledQuestionsStrategy{
            shuffledQuestionSegment.selectedSegmentIndex = 0 //Yes
        }else{
            shuffledQuestionSegment.selectedSegmentIndex = 1 //No
        }
        
    }

    @objc func indexSegmentChanged(_ sender: AnyObject){
        switch shuffledQuestionSegment.selectedSegmentIndex {
        case 0:
            Game.shared.shuffledQuestionsStrategy = ShufledQuestionsStrategy()
            print("Shuffled")
        default:
            Game.shared.shuffledQuestionsStrategy = NotShufledQuestionsStrategy()
            print("Not Shuffled")
        }
    }
}
