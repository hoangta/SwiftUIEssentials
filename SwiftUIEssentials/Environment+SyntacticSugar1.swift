//
//  Environment+SyntacticSugar1.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 4/6/24.
//

import SwiftUI

extension View {
    func todayObserving() -> some View {
        modifier(TodayObservingModifier())
    }
}

private struct TodayObservingModifier: ViewModifier {
    @Environment(\.scenePhase) private var scenePhase
    @State private var today = Date.now

    func body(content: Content) -> some View {
        content
            .onChange(of: scenePhase) {
                if scenePhase == .active, !Calendar.current.isDateInToday(today) {
                    today = Date.now
                }
            }
            .onReceive(
                NotificationCenter.default
                    .publisher(for: UIApplication.significantTimeChangeNotification)
            ) { _ in
                today = Date.now.addingTimeInterval(5)
            }
            .environment(\.today, today)
    }
}

private extension EnvironmentValues {
    private struct TodayKey: EnvironmentKey {
        static let defaultValue = Date.now
    }

    var today: Date {
        get { self[TodayKey.self] }
        set { self[TodayKey.self] = newValue }
    }
}

/*
@main
private struct TestApp: App {
    var body: some Scene {
        WindowGroup {
            Text("No thanks.")
                .todayObserving()
        }
    }
}
*/
