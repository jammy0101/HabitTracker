//
//  HabitViewModel.swift
//  HabitTracker
//
//  Created by RASHID on 22/04/2026.
//

import Foundation
import Combine
import SwiftUI


class HabitViewModel: ObservableObject {
    @Published var habits: [Habit] = [] {
        didSet { save() }  // auto-save every change
    }
    private let key = "saved_habits"

    init() { load() }

    func add(name: String, emoji: String) {
        habits.append(Habit(name: name, emoji: emoji))
    }
    func toggle(_ habit: Habit) {
        if let i = habits.firstIndex(where: { $0.id == habit.id }) {
            habits[i].toggleToday()
        }
    }
    func delete(at offsets: IndexSet) { habits.remove(atOffsets: offsets) }

    var doneCount: Int { habits.filter { $0.isDoneToday }.count }

    private func save() {
        if let data = try? JSONEncoder().encode(habits) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Habit].self, from: data)
        else { return }
        habits = saved
    }
}
