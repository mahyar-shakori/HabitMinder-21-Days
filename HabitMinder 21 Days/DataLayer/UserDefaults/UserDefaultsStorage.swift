//
//  UserDefaultsStorage.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import Foundation

final class UserDefaultsStorage<Key: StorageKeyProtocol, Value>: UserDefaultsProtocol {
    typealias ValueType = Value
    
    private var key: Key
    
    init(key: Key) {
        self.key = key
    }
    
    func save(value: Value) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func fetch() -> Value? {
        UserDefaults.standard.object(forKey: key.rawValue) as? Value
    }
}
