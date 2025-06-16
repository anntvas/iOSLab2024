//
//  Reminder.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation

struct Reminder {
    let id: UUID
    let title: String
    let type: ReminderType
    let date: Date
}

enum ReminderType: String, CaseIterable {
    case water = "Вода"
    case exercise = "Разминка"
    case vitamins = "Витамины"
    case sleep = "Сон"
    case food = "Еда"
    case breathing = "Дыхание"
    case custom = "Другое"
}
