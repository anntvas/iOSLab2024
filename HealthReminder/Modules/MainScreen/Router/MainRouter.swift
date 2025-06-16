//
//  MainRouter.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import UIKit
import SwiftUI

protocol MainRouterProtocol: AnyObject {
    func openCreateReminder()
    func openReminderDetail(_ reminder: Reminder)
}

final class MainRouter: MainRouterProtocol {
    weak var viewController: UIViewController?

    func openCreateReminder() {
        let createView = CreateReminderView()
        let hosting = UIHostingController(rootView: createView)
        viewController?.present(hosting, animated: true)
    }
    
    func openReminderDetail(_ reminder: Reminder) {
        let detailView = ReminderDetailView(reminder: reminder)
        let hosting = UIHostingController(rootView: detailView)
        viewController?.present(hosting, animated: true)
    }

}
