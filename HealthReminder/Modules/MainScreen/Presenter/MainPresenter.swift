//
//  MainPresenter.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import Foundation
import Combine

protocol MainPresenterProtocol: AnyObject {
    var remindersCount: Int { get }
    func viewDidLoad()
    func reminder(at index: Int) -> Reminder
    func didTapAdd()
    func didSelectReminder(at index: Int)
    func openReminderFromNotification(_ reminder: Reminder)
}

final class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    private let interactor: MainInteractorProtocol
    private let router: MainRouterProtocol?
    private var cancellables = Set<AnyCancellable>()

    private var reminders: [Reminder] = []

    init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    func viewDidLoad() {
        interactor.remindersPublisher
            .sink { [weak self] reminders in
                self?.reminders = reminders
                self?.view?.reloadData()
            }
            .store(in: &cancellables)
    }

    var remindersCount: Int {
        reminders.count
    }

    func reminder(at index: Int) -> Reminder {
        reminders[index]
    }

    func didTapAdd() {
        router?.openCreateReminder()
    }
    
    func openReminderFromNotification(_ reminder: Reminder) {
        router?.openReminderDetail(reminder)
    }
    
    func didSelectReminder(at index: Int) {
        let reminder = reminders[index]
        router?.openReminderDetail(reminder)
    }

}
