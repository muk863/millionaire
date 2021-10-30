//
//  QuestionTableViewCell.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    static let nib = UINib(nibName: "QuestionTableViewCell", bundle: nil)
    static let identifier = "QuestionTableViewCell"
    static let height: CGFloat = 110
    
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var rightAnswerText: UITextField!
    @IBOutlet weak var answer2Text: UITextField!
    @IBOutlet weak var answer3Text: UITextField!
    @IBOutlet weak var answer4Text: UITextField!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(question: Question) {
        questionText.text = question.question
        rightAnswerText.text = question.answers[0]
        answer2Text.text = question.answers[1]
        answer3Text.text = question.answers[2]
        answer4Text.text = question.answers[3]
    }
}
