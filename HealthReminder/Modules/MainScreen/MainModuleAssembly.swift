//
//  MainModuleAssembly.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import UIKit

enum MainModuleAssembly {
    static func build() -> UIViewController {
        let reminderService = ServiceLocator.shared.reminderService
        let view = MainViewController()
        let interactor = MainInteractor(reminderService: reminderService)
        let router = MainRouter()
        let presenter = MainPresenter(view: view, interactor: interactor, router: router)

        view.presenter = presenter
        router.viewController = view

        return view
    }
}
