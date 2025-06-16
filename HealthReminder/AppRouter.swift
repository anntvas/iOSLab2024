//
//  AppRouter.swift
//  HealthReminder
//
//  Created by Anna on 16.06.2025.
//

import Foundation
import UIKit
import SwiftUI
final class AppRouter {
    static let shared = AppRouter()
    private init() {}
    
    func setupDeeplinkHandler(_ handler: DeeplinkHandler) {
        // Устанавливаем замыкание для открытия экрана деталей
        handler.onOpenReminderDetail = { [weak self] reminder in
            self?.navigateToReminderDetail(reminder: reminder)
        }
    }
    
    private func navigateToReminderDetail(reminder: Reminder) {
        DispatchQueue.main.async {
            // Находим активный навигационный контроллер
            guard let scene = UIApplication.shared.connectedScenes.first(where: {
                $0.activationState == .foregroundActive
            }) as? UIWindowScene,
            let rootController = scene.windows.first?.rootViewController else {
                print("No active window scene found")
                return
            }
            
            // Находим текущий навигационный контроллер
            var navigationController: UINavigationController?
            
            if let tabController = rootController as? UITabBarController {
                navigationController = tabController.selectedViewController as? UINavigationController
            } else {
                navigationController = rootController as? UINavigationController
            }
            
            // Проверяем, не открыт ли уже этот экран
            if let topVC = navigationController?.topViewController as? ReminderDetailView,
               topVC.reminder.id == reminder.id {
                return
            }
            
            // Создаем и показываем экран деталей
            let detailVC = ReminderDetailView(reminder: reminder)
            let hostingController = UIHostingController(rootView: detailVC)
            navigationController?.present(hostingController, animated: true)
        }
    }
}
