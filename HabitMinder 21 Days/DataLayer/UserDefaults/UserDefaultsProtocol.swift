//
//  UserDefaultsProtocol.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import Foundation

protocol UserDefaultsProtocol {
    associatedtype ValueType
    func save(value: ValueType)
    func fetch() -> ValueType?
}
