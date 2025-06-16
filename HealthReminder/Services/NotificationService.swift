//
//  NotificationService.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import UserNotifications

protocol NotificationServiceProtocol {
    func requestAuthorization()
    func scheduleNotification(for reminder: Reminder)
}

final class NotificationService: NotificationServiceProtocol {
    private let factory = NotificationFactory()

    init() {
        requestAuthorization()
    }

    internal func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Ошибка при запросе разрешения: \(error)")
            } else {
                print(granted ? "Разрешение получено" : "Разрешение отклонено")
            }
        }
    }


    func scheduleNotification(for reminder: Reminder) {
        let notificationRequest = factory.makeNotification(for: reminder)
        UNUserNotificationCenter.current().add(notificationRequest) { error in
            if let error = error {
                print("Ошибка при добавлении уведомления: \(error)")
            } else {
                print("Уведомление запланировано для напоминания: \(reminder.title)")
            }
        }
    }
}
