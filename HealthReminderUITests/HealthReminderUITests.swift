//
//  HealthReminderUITests.swift
//  HealthReminderUITests
//
//  Created by Anna on 14.06.2025.
//

import XCTest

final class HealthReminderUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    /// Тест создания напоминания через UI
    func testCreateReminder() throws {
        // Нажимаем кнопку добавления
        app.navigationBars.buttons["addButton"].tap()

        // Вводим заголовок
        let titleField = app.textFields["ReminderTitleField"]
        XCTAssertTrue(titleField.waitForExistence(timeout: 2))
        titleField.tap()
        titleField.typeText("Проверка UI")

        // Сохраняем
        app.buttons["SaveReminderButton"].tap()

        // Проверяем, что напоминание появилось в списке
        let reminderCell = app.staticTexts["reminderTitleLabel"]
        let exists = reminderCell.waitForExistence(timeout: 2)
        XCTAssertTrue(exists)
    }

    /// Тест перехода по диплинку к ReminderDetailView
    func testOpenReminderViaLocalNotificationDeeplink() throws {
        let uuid = UUID().uuidString
        app.launchArguments = [
            "-uitest-notification",
            "-reminderId", uuid,
            "-ui-testing-create-reminder", uuid
        ]
        app.launch()

        let detailTitle = app.staticTexts["ReminderDetailTitle"]
        XCTAssertTrue(detailTitle.waitForExistence(timeout: 5), "Reminder detail screen did not appear after simulating notification tap")
    }



}
