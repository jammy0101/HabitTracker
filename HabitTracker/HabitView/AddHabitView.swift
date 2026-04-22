//
//  AddHabitView.swift
//  HabitTracker
//
//  Created by RASHID on 22/04/2026.
//

import SwiftUI

import SwiftUI

struct AddHabitView: View {
    @ObservedObject var vm: HabitViewModel
    @Environment(\.dismiss) var dismiss
    let emojis = ["🔥","💪","📚","🧠","🏃‍♂️"]
    @State private var name: String = ""
    @State private var emoji: String = "🔥"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                
                // Habit Name
                TextField("Habit name", text: $name)
                    .textFieldStyle(.roundedBorder)
                
                // Emoji
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(emojis, id: \.self) { e in
                            Text(e)
                                .font(.largeTitle)
                                .padding(10)
                                .background(emoji == e ? Color.green.opacity(0.2) : Color.clear)
                                .cornerRadius(10)
                                .onTapGesture {
                                    emoji = e
                                }
                        }
                    }
                }
                
                Spacer()
                
                // Save Button
                Button {
                    guard !name.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                    
                    vm.add(name: name, emoji: emoji)
                    dismiss()
                    
                } label: {
                    Text("Save Habit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("Add Habit")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddHabitView(vm: HabitViewModel())
}
