import SwiftUI
import Foundation

struct Ring: View {
    let progress: Double
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.15), lineWidth: 8)
            
            Circle()
                .trim(from: 0, to: min(progress, 1.0))
                .stroke(color, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.spring(), value: progress)
        }
    }
}

// Habit card with tap gesture
struct HabitCard: View {
    let habit: Habit
    let onTap: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Text(habit.emoji).font(.system(size: 36))
            Text(habit.name).font(.subheadline).bold()
            
           
            Text("\(habit.streak) day streak")
                .font(.caption)
                .foregroundColor(.orange)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(
            habit.isDoneToday
            ? Color.green.opacity(0.1)
            : Color(uiColor: .secondarySystemBackground)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(habit.isDoneToday ? Color.green : .clear, lineWidth: 2)
        )
        .cornerRadius(16)
        .onTapGesture(perform: onTap)
    }
}

#Preview {
    Ring(progress: 0.7, color: .blue)
}
