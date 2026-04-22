import Foundation
import SwiftUI

struct Habit: Identifiable, Codable {
    let id: UUID
    var name: String
    var emoji: String
    var completedDates: [String] = []

    init(name: String, emoji: String) {
        self.id = UUID()
        self.name = name
        self.emoji = emoji
    }

  
    static let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .short
        return f
    }()

    private var todayKey: String {
        Self.formatter.string(from: Date())
    }

    var isDoneToday: Bool {
        completedDates.contains(todayKey)
    }

    var streak: Int {
        var count = 0
        var date = Date()

        while completedDates.contains(Self.formatter.string(from: date)) {
            count += 1
            date = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        }
        return count
    }

    mutating func toggleToday() {
        let key = todayKey
        
        if completedDates.contains(key) {
            completedDates.removeAll { $0 == key }
        } else {
            completedDates.append(key)
        }
    }
}
