//
//  MainViewController.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import UIKit

protocol MainViewProtocol: AnyObject {
    func reloadData()
}

final class MainViewController: UIViewController, MainViewProtocol {

    var presenter: MainPresenterProtocol!

    private let mainView = MainView()
    private let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Напоминания"
        navigationItem.rightBarButtonItem = addButton
        addButton.target = self
        addButton.action = #selector(addTapped)
        addButton.accessibilityIdentifier = "addButton"

        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.tableView.register(ReminderTableViewCell.self, forCellReuseIdentifier: ReminderTableViewCell.identifier)

        presenter.viewDidLoad()
    }

    @objc private func addTapped() {
        presenter.didTapAdd()
    }

    func reloadData() {
        mainView.tableView.reloadData()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.remindersCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reminder = presenter.reminder(at: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReminderTableViewCell.identifier, for: indexPath) as? ReminderTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: reminder)
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectReminder(at: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
