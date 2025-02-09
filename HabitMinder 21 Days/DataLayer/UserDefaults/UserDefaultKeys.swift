//
//  UserDefaultKeys.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import Foundation

enum UserDefaultKeys: String, StorageKeyProtocol {
    case userName = "userDefaultsStorage_UserName"
    case isQuoteOff = "userDefaultsStorage_IsQuoteOff"
    case isLogin = "userDefaultsStorage_IsLogin"
}
