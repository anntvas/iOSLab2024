//
//  SceneDelegate.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var pendingDeeplinkURL: URL?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Создаём окно
        let window = UIWindow(windowScene: windowScene)

        // Инициализация сервисов
        let services = ServiceLocator.shared
        let reminderService = ReminderService()
        let notificationService = NotificationService()
        services.addService(reminderService)
        services.addService(notificationService)

        let deeplinkHandler = DeeplinkHandler(reminderService: reminderService)
        services.addService(deeplinkHandler)
        AppRouter.shared.setupDeeplinkHandler(deeplinkHandler)

        // Тестовая логика при запуске
        setupForDeeplinkTest()

        // Главный экран
        let mainVC = MainModuleAssembly.build()
        let navController = UINavigationController(rootViewController: mainVC)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }

    func setPendingDeeplink(_ url: URL) {
        self.pendingDeeplinkURL = url
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        if let url = pendingDeeplinkURL {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                ServiceLocator.shared.deeplinkHandler.handleNotification(url)
            }
            pendingDeeplinkURL = nil
        }
    }

    private func setupForDeeplinkTest() {
        let args = CommandLine.arguments

        // Создание тестового Reminder по UUID
        if let createIndex = args.firstIndex(of: "-ui-testing-create-reminder"),
           args.count > createIndex + 1 {
            let uuidString = args[createIndex + 1]
            if let uuid = UUID(uuidString: uuidString) {
                let reminder = Reminder(id: uuid, title: "UI Test", type: .custom, date: Date())
                ServiceLocator.shared.reminderService.addReminder(reminder)
                print("✅ Reminder created: \(reminder)")
            }
        }

        // Прямой запуск по диплинку
        if args.contains("-ui-testing-deeplink"),
           let idIndex = args.firstIndex(of: "-reminderId"),
           args.count > idIndex + 1 {
            let uuidString = args[idIndex + 1]
            if let uuid = UUID(uuidString: uuidString) {
                let url = URL(string: "deeplink://openScreen?screen=detail&reminderId=\(uuid.uuidString)")!
                ServiceLocator.shared.deeplinkHandler.handleNotification(url)
                print("✅ Handled deeplink at launch")
            }
        }

        // Симуляция уведомления (с задержкой до активации)
        if args.contains("-uitest-notification"),
           let idIndex = args.firstIndex(of: "-reminderId"),
           args.count > idIndex + 1 {
            let uuidString = args[idIndex + 1]
            if let uuid = UUID(uuidString: uuidString) {
                let url = URL(string: "deeplink://openScreen?screen=detail&reminderId=\(uuid.uuidString)")!
                setPendingDeeplink(url)
                print("📥 Queued notification deeplink")
            }
        }
    }

    // Не используются, но оставлены для полноты
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {}
    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

