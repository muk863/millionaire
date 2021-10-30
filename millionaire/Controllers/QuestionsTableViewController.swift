//
//  QuestionsTableViewController.swift
//  millionaire
//
//  Created by username on 30.10.2021.
//

import UIKit

class QuestionsTableViewController: UIViewController {

    @IBOutlet weak var userQuestionsTable: UITableView!
    
    private var userQuestions:[Question] = []{
        didSet{
            userQuestionsTable.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userQuestionsTable.register(QuestionTableViewCell.nib, forCellReuseIdentifier: QuestionTableViewCell.identifier)
        userQuestionsTable.delegate = self
        userQuestionsTable.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userQuestions = Game.shared.userQuestions
    }
}

extension QuestionsTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as? QuestionTableViewCell
        else { return UITableViewCell() }
        cell.configureCell(question: userQuestions[indexPath.row])
        return cell
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            
            userQuestions.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Game.shared.deleteUserQuestion(index: indexPath.row)

            tableView.endUpdates()
        }
    }
    
}
