//
//  NotificationFactoryTests.swift
//  HealthReminderTests
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import XCTest
@testable import HealthReminder

final class NotificationFactoryTests: XCTestCase {
    
    func testNotificationRequestGeneration() {
        let reminder = Reminder(id: UUID(), title: "Мое напоминание о зачете", type: .custom, date: Date())
        let factory = NotificationFactory()
        let request = factory.makeNotification(for: reminder)
        
        XCTAssertEqual(request.identifier, reminder.id.uuidString)
        XCTAssertEqual(request.content.title, "Мое напоминание о зачете")
        XCTAssertEqual(request.content.body, "Пора приступить к задаче Другое!")
        
    }
}
