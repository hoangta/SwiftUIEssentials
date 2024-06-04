//
//  Environment.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - Environment
struct Environment1: View {
    @Environment(\.today) private var today

    struct SubView: View {
        @Environment(\.today) private var today

        var body: some View {
            Text(today.formatted())
        }
    }

    var body: some View {
        VStack {
            Text(today.formatted())

            SubView()
                .environment(\.today, today.advanced(by: 3600))
        }
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

#Preview("Environment1") {
    Environment1()
        .foregroundStyle(.primary) // There is some hidden @Environment(\.foregroundStyle) private var foregroundStyle
        .buttonStyle(.container) // There is some hidden @Environment(\.buttonStyle) private var buttonStyle
}

// MARK: - Action Environment
struct Environment2: View {
    @State private var alert: AlertInfo?

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
            SubView()
        }
        .environment(\.showAlert, { message in
            alert = AlertInfo(title: "Sao mày?", message: message)
        })
        .alert(item: $alert) { info in
            Alert(title: Text(info.title), message: Text(info.message))
        }
    }

    struct AlertInfo: Identifiable {
        let id: UUID = UUID()
        let title: String
        let message: String
    }

    struct SubView: View {
        @Environment(\.showAlert) private var showAlert

        var body: some View {
            Button("Táp me là có chuyện! 👊") {
                showAlert("aghrrr")
            }
        }
    }
}

private extension EnvironmentValues {
    private struct ShowAlertKey: EnvironmentKey {
        static let defaultValue: (String) -> Void = { _ in }
    }

    var showAlert: (String) -> Void {
        get { self[ShowAlertKey.self] }
        set { self[ShowAlertKey.self] = newValue }
    }
}

#Preview("Environment2") {
    Environment2()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}
