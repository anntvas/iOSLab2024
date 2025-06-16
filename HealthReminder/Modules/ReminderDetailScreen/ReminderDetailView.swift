//
//  ReminderDetailView.swift
//  HealthReminder
//
//  Created by Anna on 14.06.2025.
//

import SwiftUI

struct ReminderDetailView: View {
    let reminder: Reminder

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            // Title
            Text(reminder.title)
                .font(.system(size: 36, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top, 40).accessibilityIdentifier("ReminderDetailTitle")

            HStack(spacing: 16) {
                Image(systemName: "calendar")
                    .foregroundColor(.accentColor)
                    .font(.system(size: 28))
                Text(reminder.date.formatted(date: .long, time: .shortened))
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.primary)
            }

            HStack(spacing: 16) {
                Circle()
                    .fill(reminder.type.color)
                    .frame(width: 28, height: 28)
                Text(reminder.type.rawValue)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.primary)
            }

            Spacer()
        }
        .padding(.horizontal, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .background(Color(.systemBackground).ignoresSafeArea())
        .navigationTitle("Details")
    }
}

extension ReminderType {
    var color: Color {
        switch self {
        case .water: return .blue
        case .exercise: return .orange
        case .vitamins: return .green
        case .sleep: return .purple
        case .food: return .pink
        case .breathing: return .teal
        case .custom: return .gray
        }
    }
}
