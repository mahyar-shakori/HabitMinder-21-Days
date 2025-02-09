//
//  HomeDataManagement.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 2/7/25.
//

import Foundation

final class HomeDataManagement {
   
    private var habitList = [Habit]()
    private var futureHabitList = [FutureHabit]()
    private let realmDataService = RealmDataService()
    
    func fetchHabits() {
        habitList = realmDataService.fetchObjects(ofType: Habit.self)
    }
    
    func fetchFutureHabits() {
        futureHabitList = realmDataService.fetchObjects(ofType: FutureHabit.self)
    }
    
    func getHabitList() -> [Habit] {
        habitList
    }
    
    func getFutureHabitList() -> [FutureHabit] {
        futureHabitList
    }
    
    func addFutureHabit(title: String) {
        let futureHabit = FutureHabit()
        futureHabit.title = title
        futureHabit.id = realmDataService.incrementID(for: FutureHabit.self)
        futureHabitList.append(futureHabit)
        realmDataService.addObject(futureHabit)
    }
    
    func removeHabit(habit: Habit, at index: Int) {
        habit.reminders
            .map { "\( $0.id )" }
            .forEach { NotificationScheduler.shared.cancelNotification(identifier: $0) }
        realmDataService.deleteObject(habit)
        habitList.remove(at: index)
    }
    
    func removeFutureHabit(futureHabit: FutureHabit, at index: Int) {
        realmDataService.deleteObject(futureHabit)
        futureHabitList.remove(at: index)
    }
    
    func reorderHabits(from sourceIndex: IndexPath, to destinationIndex: IndexPath) {
        let movedObject = habitList[sourceIndex.row]
        habitList.remove(at: sourceIndex.row)
        habitList.insert(movedObject, at: destinationIndex.row)
    }
}
