//
//  FutureHabit.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/5/25.
//

import RealmSwift

final class FutureHabit: Object {
    @Persisted(primaryKey: true) var id: Int = 0
    @Persisted var title: String = ""
}
