//
//  DeeplinkHandler.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

//
//  DeeplinkHandler.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import UIKit

protocol DeeplinkHandlerProtocol {
    func handleNotification(_ url: URL)
}

final class DeeplinkHandler: DeeplinkHandlerProtocol {
    var onOpenReminderDetail: ((Reminder) -> Void)?
    
    private let reminderService: ReminderServiceProtocol
    
    init(reminderService: ReminderServiceProtocol) {
        self.reminderService = reminderService
    }
    
    
    func handleNotification(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Failed to parse deeplink URL components")
            return
        }
        
        // Обработка по host
        switch components.host {
        case "openScreen":
            handleOpenScreen(with: components.queryItems ?? [])
        default:
            print("Unsupported deeplink host: \(components.host ?? "nil")")
        }
    }
    
    private func handleOpenScreen(with queryItems: [URLQueryItem]) {
        // Ищем параметр screen
        guard let screenQuery = queryItems.first(where: { $0.name == "screen" }) else {
            print("Missing screen parameter in deeplink")
            return
        }
        
        // Обработка по типу экрана
        switch screenQuery.value {
        case "detail":
            handleDetailScreen(with: queryItems)
        default:
            print("Unsupported screen type: \(screenQuery.value ?? "nil")")
        }
    }

    private func handleDetailScreen(with queryItems: [URLQueryItem]) {
        // Ищем параметр reminderId
        guard let idString = queryItems.first(where: { $0.name == "reminderId" })?.value,
              let uuid = UUID(uuidString: idString) else {
            print("Invalid or missing reminderId in deeplink")
            return
        }
        
        // Получаем напоминание
        guard let reminder = reminderService.getReminder(with: uuid) else {
            print("Reminder not found with id: \(uuid)")
            return
        }
        
        // Вызываем замыкание для навигации
        onOpenReminderDetail?(reminder)
    }
}
