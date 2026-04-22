//
//  HabitView.swift
//  HabitTracker
//
//  Created by RASHID on 22/04/2026.
//

import SwiftUI

struct HabitView: View {
    @StateObject var vm = HabitViewModel()
    @State private var showAdd = false
    let cols = [GridItem(.flexible()), GridItem(.flexible())]

    var progress: Double {
        vm.habits.isEmpty ? 0 : Double(vm.doneCount) / Double(vm.habits.count)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Summary row
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Today").font(.title2).bold()
                            Text("\(vm.doneCount) of \(vm.habits.count) done").foregroundColor(.secondary)
                        }
                        Spacer()
                        Ring(progress: progress, color: .green).frame(width: 56, height: 56)
                    }.padding()

                    LazyVGrid(columns: cols, spacing: 14) {
                        ForEach(vm.habits) { h in
                            HabitCard(habit: h) {
                                withAnimation(.easeInOut(duration: 0.3)) {
                                    vm.toggle(h)
                                }
                            }
                        }
                    }.padding(.horizontal)
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") { showAdd = true }
                }
            }
            .sheet(isPresented: $showAdd) { AddHabitView(vm: vm) }
        }
    }
}

#Preview {
    HabitView()
}
