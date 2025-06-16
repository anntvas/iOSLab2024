//
//  ReminderServiceTests.swift
//  HealthReminderTests
//
//  Created by Anna on 14.06.2025.
//

import XCTest
@testable import HealthReminder

final class ReminderServiceTests: XCTestCase {

    func testAddReminder() {
        let service = ReminderService()
        let reminder = Reminder(id: UUID(), title: "Выпить воду", type: .water, date: Date())

        service.addReminder(reminder)

        XCTAssertEqual(service.reminders.count, 1)
        XCTAssertEqual(service.reminders.first?.title, "Выпить воду")
    }

    func testPublishedReminders() {
        let service = ReminderService()
        var received = [Reminder]()

        let expectation = self.expectation(description: "Should publish reminder")
        let cancellable = service.$reminders
            .dropFirst()
            .sink {
                received = $0
                expectation.fulfill()
            }

        service.addReminder(Reminder(id: UUID(), title: "Тест", type: .sleep, date: Date()))

        waitForExpectations(timeout: 1)
        XCTAssertEqual(received.count, 1)
        cancellable.cancel()
    }
}
