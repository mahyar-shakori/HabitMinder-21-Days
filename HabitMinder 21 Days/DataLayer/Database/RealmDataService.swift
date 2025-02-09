//
//  RealmDataService.swift
//  HabitMinder 21 Days
//
//  Created by Mahyar on 1/20/25.
//

import RealmSwift

final class RealmDataService {
    private var realm: Realm?
    
    init() {
        configureRealm()
        realm = try? Realm()
    }
    
    private func configureRealm() {
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Reminder.className()) { _, newObject in
                        newObject?[RealmKeys.dateCreate] = Date()
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    func fetchObjects<T: Object>(ofType type: T.Type) -> [T] {
        guard let realm = realm else {
            return []
        }
        return Array(realm.objects(type))
    }
    
    func addObject<T: Object>(_ object: T) {
        performWriteOperation { [weak self] in
            self?.realm?.add(object)
        }
    }
    
    func deleteObject<T: Object>(_ object: T) {
        performWriteOperation { [weak self] in
            self?.realm?.delete(object)
        }
    }
    
    private func maxID<T: Object>(for type: T.Type) -> Int {
        guard let realm = realm else {
            return 0
        }
        return realm.objects(type).max(ofProperty: RealmKeys.id) as Int? ?? 0
    }
    
    func incrementID<T: Object>(for type: T.Type) -> Int {
        maxID(for: type) + 1
    }
    
    func updateHabit(habitTitle: String, newTitle: String, updateDateCreate: Bool? = false) {
        performWriteOperation { [weak self] in
            let habitsToUpdate = self?.realm?.objects(Habit.self).filter(RealmKeys.titleEdit, habitTitle)
            habitsToUpdate?.forEach { habit in
                habit.title = newTitle
                if let result = updateDateCreate, result {
                    habit.dateCreate = Date()
                }
            }
        }
    }
    
    private func performWriteOperation(_ operation: @escaping () -> Void) {
        try? realm?.write {
            operation()
        }
    }
}
