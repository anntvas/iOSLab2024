//
//  ReminderService.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import Combine

protocol ReminderServiceProtocol: AnyObject {
    var remindersPublisher: AnyPublisher<[Reminder], Never> { get } // чтобы другие могли подписаться на изменения ремайндер
    func addReminder(_ reminder: Reminder)
    func getReminder(with id: UUID) -> Reminder?
}

final class ReminderService: ReminderServiceProtocol {
    
    @Published var reminders = [Reminder]()
    
    var remindersPublisher: AnyPublisher<[Reminder], Never> {
        $reminders.eraseToAnyPublisher()
    }
    
    func addReminder(_ reminder: Reminder) {
        reminders.append(reminder)
    }
    
    func getReminder(with id: UUID) -> Reminder? {
        reminders.first { $0.id == id }
    }

}
