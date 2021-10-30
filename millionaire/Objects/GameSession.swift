//
//  GameSession.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import Foundation

class GameSession: Codable {
    var rightAnswerCount: Int = 0
    var amountOfMoney: Int = 0
    var level: Int = 0
    private(set) var startTime: Date = Date()
    
    enum CodingKeys: String, CodingKey {
        case rightAnswerCount
        case amountOfMoney, level, startTime
    }
    
    let progress = Observable<Int>(value: 0)
}

