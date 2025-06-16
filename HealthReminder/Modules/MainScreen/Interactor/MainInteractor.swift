//
//  MainInteractor.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import Combine

protocol MainInteractorProtocol: AnyObject {
    var remindersPublisher: AnyPublisher<[Reminder], Never> { get }
}

final class MainInteractor: MainInteractorProtocol {
    private let reminderService: ReminderServiceProtocol

    var remindersPublisher: AnyPublisher<[Reminder], Never> {
        reminderService.remindersPublisher
    }

    init(reminderService: ReminderService) {
        self.reminderService = reminderService
    }
}
