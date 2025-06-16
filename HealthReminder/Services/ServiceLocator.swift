//
//  ServiceLocator.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation

final class ServiceLocator {
    static let shared = ServiceLocator()
    
    private var services: [String: Any] = [:]

    private init() { }
    
    func addService<T>(_ service: T) {
        let key = String(describing: T.self)
        services[key] = service
    }
    
    func getService<T>() -> T {
        let key = String(describing: T.self)
        guard let service = services[key] as? T else {
            fatalError("Service \(key) not registered")
        }
        return service
    }
}

extension ServiceLocator {
    var reminderService: ReminderService { getService() }
    var notificationService: NotificationService { getService() }
    var deeplinkHandler: DeeplinkHandler { getService() }
}
