//
//  CreateReminderView.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import SwiftUI

enum TriggerMode: String, CaseIterable, Identifiable {
    case interval, date
    var id: String { self.rawValue }
}

struct CreateReminderView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var title = ""
    @State private var triggerMode: TriggerMode = .interval
    @State private var interval = 10
    @State private var date = Date()
    @State private var selectedType = ReminderType.water
    
    let reminderService: ReminderServiceProtocol
    let notificationService: NotificationServiceProtocol

    init(
        reminderService: ReminderServiceProtocol = ServiceLocator.shared.reminderService,
        notificationService: NotificationServiceProtocol = ServiceLocator.shared.notificationService
    ) {
        self.reminderService = reminderService
        self.notificationService = notificationService
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Название")) {
                    TextField("Введите напоминание", text: $title).accessibilityIdentifier("ReminderTitleField")
                }
                
                Section(header: Text("Тип запуска")) {
                    Picker("Режим", selection: $triggerMode) {
                        Text("Через интервал").tag(TriggerMode.interval)
                        Text("По дате и времени").tag(TriggerMode.date)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                if triggerMode == .interval {
                    Section(header: Text("Интервал")) {
                        Picker("Интервал", selection: $interval) {
                            ForEach([5, 10, 15, 30, 60], id: \.self) { minutes in
                                Text("\(minutes) минут")
                            }
                        }
                    }
                } else {
                    Section(header: Text("Дата и время")) {
                        DatePicker("Выберите дату и время", selection: $date)
                    }
                }
                
                
                Section(header: Text("Тип")) {
                    Picker("Тип напоминания", selection: $selectedType) {
                        ForEach(ReminderType.allCases, id: \.self) { type in
                            Text(type.rawValue.capitalized)
                        }
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Сохранить") {
                            let reminderDate: Date = {
                                switch triggerMode {
                                case .interval:
                                    return Calendar.current.date(byAdding: .minute, value: interval, to: Date()) ?? Date()
                                case .date:
                                    return date
                                }
                            }()
                            
                            let builder = ReminderBuilder()
                                .setTitle(title)
                                .setType(selectedType)
                                .setDate(reminderDate)
                            
                            let reminder = builder.build()
                            reminderService.addReminder(reminder)
                            notificationService.scheduleNotification(for: reminder)
                            presentationMode.wrappedValue.dismiss()
                        }.accessibilityIdentifier("SaveReminderButton")
                        Spacer()
                    }
                }
            }.navigationTitle("Создать")
        }
    }
}
