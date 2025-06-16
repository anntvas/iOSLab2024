//
//  ReminderBuilder.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation

final class ReminderBuilder {
    private var id: UUID = UUID()
    private var title: String = ""
    private var type: ReminderType = .custom
    private var date: Date = Date()

    func setTitle(_ title: String) -> Self {
        self.title = title
        return self
    }

    func setType(_ type: ReminderType) -> Self {
        self.type = type
        return self
    }

    func setDate(_ date: Date) -> Self {
        self.date = date
        return self
    }

    func build() -> Reminder {
        Reminder(id: id, title: title, type: type, date: date)
    }
}
