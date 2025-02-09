//
//  Reminder.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/9/24.
//

import RealmSwift

final class Reminder : Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var reminderTime : String = ""
    @Persisted var dateCreate : Date = Date()
}
