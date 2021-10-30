//
//  MementoCaretaker.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import Foundation

final class MementoCaretaker<Object: Codable> {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private lazy var key : String = {
        String(describing: Object.self)
    }()
    
    func save(results: [Object]) {
        do {
            let data = try self.encoder.encode(results)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print(error)
        }
    }
    
    func retrieveResults() -> [Object] {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return []
        }
        do {
            return try self.decoder.decode([Object].self, from: data)
        } catch {
            print(error)
            return []
        }
    }
}
