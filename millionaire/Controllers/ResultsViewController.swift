//
//  ResultsViewController.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import UIKit

class ResultsViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    
    private var records:[GameSession] = []
    private let dateFormatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultTableView.delegate = self
        resultTableView.dataSource = self
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.records = Game.shared.records
    }
}

extension ResultsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        let record = records[indexPath.row]
        cell.textLabel?.text = "Money: \(record.amountOfMoney), Level: \(record.level), Answers: \(record.rightAnswerCount)"
        cell.detailTextLabel?.text = dateFormatter.string(from: record.startTime)
        
        return cell
        
    }

}
