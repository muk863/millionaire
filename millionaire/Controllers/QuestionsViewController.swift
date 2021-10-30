//
//  QuestionsViewController.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import UIKit

final class QuestionsViewController: UIViewController {
    
    @IBOutlet weak var plusImageView: UIImageView!
    @IBOutlet weak var addAllQuestionsButton: UIButton!
    @IBOutlet weak var userQuestionsTable: UITableView!
    
    @IBOutlet weak var questionText: UITextField!
    @IBOutlet weak var rightAnswerText: UITextField!
    @IBOutlet weak var answer2Text: UITextField!
    @IBOutlet weak var answer3Text: UITextField!
    @IBOutlet weak var answer4Text: UITextField!
    
    private var userQuestions:[Question] = []
    private var plusImageViewAnabled: Bool = false{
        didSet{
            plusImageView.isUserInteractionEnabled = plusImageViewAnabled
            plusImageView.tintColor = plusImageViewAnabled == true ?  UIColor.systemGreen : UIColor.lightGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userQuestions = []
        plusImageViewAnabled = false
    }
    
    @IBAction func tapDddAllQuestionsButton(_ sender: UIButton) {
        Game.shared.appendUserQuestions(userQuestions: userQuestions)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewQuestion(){
        let bounds = self.plusImageView.bounds.size
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1.0, options: [], animations: {
            self.plusImageView.bounds.size = CGSize(width: bounds.width + bounds.width / 4, height: bounds.height + bounds.height / 4)
        })
        userQuestions.append(Question(question: questionText.text ?? "",
                                      answers: [rightAnswerText.text ?? "",
                                                answer2Text.text ?? "",
                                                answer3Text.text ?? "",
                                                answer4Text.text ?? ""]))
        

        clearTextFields()
        userQuestionsTable.reloadData()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField){
        
        plusImageViewAnabled = !questionText.isEmpty &&
                               !rightAnswerText.isEmpty &&
                               !answer2Text.isEmpty &&
                               !answer3Text.isEmpty &&
                               !answer4Text.isEmpty
        
    }
    private func clearTextFields(){
        questionText.text = ""
        rightAnswerText.text = ""
        answer2Text.text = ""
        answer3Text.text = ""
        answer4Text.text = ""
    }
    
    @objc private func hideKeyboard(){
        questionText.endEditing(true)
        rightAnswerText.endEditing(true)
        answer2Text.endEditing(true)
        answer3Text.endEditing(true)
        answer4Text.endEditing(true)
    }

    private func configUI(){
        questionText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        rightAnswerText.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answer2Text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answer3Text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        answer4Text.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        userQuestionsTable.register(QuestionTableViewCell.nib, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        userQuestionsTable.delegate = self
        userQuestionsTable.dataSource = self
        
        let tapPlus = UITapGestureRecognizer(target: self, action: #selector(addNewQuestion))
        plusImageView.addGestureRecognizer(tapPlus)
        plusImageViewAnabled = false
        
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        userQuestionsTable.addGestureRecognizer(hideKeyboardGesture)
    }
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell
        else { return UITableViewCell() }
        cell.configureCell(question: userQuestions[indexPath.row])
        return cell
    }
}

