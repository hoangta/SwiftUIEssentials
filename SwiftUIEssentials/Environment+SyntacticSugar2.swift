//
//  Environment+SyntacticSugar.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics

// MARK: - Environment with syntactic sugar
extension View {
    func firebaseConfiguration() -> some View {
        modifier(FirebaseConfigurationModifier())
    }
}

private struct FirebaseConfigurationModifier: ViewModifier {
    @Environment(\.firebase) var firebase

    func body(content: Content) -> some View {
        content
            .task {
                firebase.configure()
            }
    }
}

protocol FirebaseService {
    func configure()
    func logEvent(_ event: AnalyticsEvent)
}

enum AnalyticsEvent: String {
    case event1
    case event2
}

final class FirebaseManager: FirebaseService {
    static let shared = FirebaseManager()

    func configure() {
        FirebaseApp.configure()
    }

    func logEvent(_ event: AnalyticsEvent) {
        Analytics.logEvent(event.rawValue, parameters: nil)
    }
}

private final class FirebasePreview: FirebaseService {
    func configure() {
        print("Did configure phaibay!")
    }

    func logEvent(_ event: AnalyticsEvent) {
        print("Did log event \(event)")
    }
}

extension EnvironmentValues {
    private struct FirebaseKey: EnvironmentKey {
        static let defaultValue: FirebaseService = isPreview ? FirebasePreview() : FirebaseManager.shared
    }

    var firebase: FirebaseService {
        get { self[FirebaseKey.self] }
        set { self[FirebaseKey.self] = newValue }
    }
}

let isPreview = ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"

#Preview("Firebase Configuration") {
    struct Preview: View {
        @State private var showsOther = false

        var body: some View {
            Text("The app")
                .firebaseConfiguration()

            if showsOther {
                Text("Other")

            }
            Button("Show other") {
                showsOther = true
            }
        }
    }

    return Preview()
}

// MARK: - More awesome modifiers
extension View {
    func analyticsEventOnTap(_ event: AnalyticsEvent) -> some View {
        modifier(AnalyticsEventOnTapModifier(event: event))
    }

    func analyticsEventOnAppear(_ event: AnalyticsEvent) -> some View {
        modifier(AnalyticsEventOnAppearModifier(event: event))
    }
}

private struct AnalyticsEventOnTapModifier: ViewModifier {
    @Environment(\.firebase) var firebase
    let event: AnalyticsEvent

    func body(content: Content) -> some View {
        content.simultaneousGesture(TapGesture().onEnded {
            firebase.logEvent(event)
        })
    }
}

private struct AnalyticsEventOnAppearModifier: ViewModifier {
    @Environment(\.firebase) var firebase
    let event: AnalyticsEvent

    func body(content: Content) -> some View {
        content.onAppear {
            firebase.logEvent(event)
        }
    }
}

#Preview("Analytic Events") {
    struct Preview: View {
        @State private var showsOther = false

        var body: some View {
            VStack {
                Text("The app")
                    .analyticsEventOnAppear(.event1)

                Button("Do something") {
                    print("Did something!")
                }
                .analyticsEventOnTap(.event2)
            }

        }
    }

    return Preview()
}
