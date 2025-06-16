//
//  SnapshotTests.swift
//  HealthReminderTests
//
//  Created by Anna on 14.06.2025.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import HealthReminder

final class SnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        isRecording = false
    }

    func testCreateReminderViewEmpty() {
        let view = CreateReminderView()
        let host = UIHostingController(rootView: view)
        host.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844) // iPhone 13

        assertSnapshot(matching: host, as: .image)

    }

    func testReminderDetailView() {
        let reminder = Reminder(
            id: UUID(),
            title: "Выпить воду",
            type: .water,
            date: Date()
        )

        let view = ReminderDetailView(reminder: reminder)
        let host = UIHostingController(rootView: view)
//        host.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(matching: host, as: .image)
 
    }
}
