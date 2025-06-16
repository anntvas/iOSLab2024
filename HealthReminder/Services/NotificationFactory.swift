//
//  NotificationFactory.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import UserNotifications

final class NotificationFactory {
    func makeNotification(for reminder: Reminder) -> UNNotificationRequest {
        let content = UNMutableNotificationContent()
        content.title = reminder.title
        content.body = "Пора приступить к задаче \(reminder.type.rawValue)!"
        content.sound = .default
        content.userInfo = ["deeplink": "deeplinkproject://openScreen?screen=detail&reminderId=\(reminder.id)"]
        

        let triggerDate = reminder.date
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: triggerDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)

        
        let request = UNNotificationRequest(
            identifier: reminder.id.uuidString,
            content: content,
            trigger: trigger
        )
        return request
    }
}
