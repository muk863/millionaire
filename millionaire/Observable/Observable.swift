//
//  Observable.swift
//  millionaire
//
//  Created by username on 29.10.2021.
//

import Foundation

class Observable<ValueType> {
    
    init(value: ValueType) {
        self.value = value
    }
    
    var value: ValueType {
        didSet {
            subscribers.forEach { $0.closure(value) }
        }
    }
    
    var subscribers = Set<Observer<ValueType>>()
    
    func addObserver(_ observer: Observer<ValueType>) {
        subscribers.insert(observer)
    }
    
    func removeObserver(_ observer: Observer<ValueType>) {
        subscribers.remove(observer)
    }
}

class Observer<ValueType> {
    init(closure: @escaping (ValueType) -> Void) {
        self.closure = closure
    }
    
    var closure: (ValueType) -> Void
    var id = UUID().uuidString
}

extension Observer: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Observer: Equatable {
    static func == (lhs: Observer<ValueType>, rhs: Observer<ValueType>) -> Bool {
        lhs.id == rhs.id
    }
}
