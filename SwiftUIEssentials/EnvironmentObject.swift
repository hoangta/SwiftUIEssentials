//
//  EnvironmentObject.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 4/6/24.
//

import SwiftUI
import Combine

// MARK: - EnvironmentObject
struct EnvironmentObjectView: View {
    @StateObject private var anEnvironment = AnEnvironment()

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("Hi MappleLabs! ♥️")
                if anEnvironment.value > 0 {
                    Text("\(anEnvironment.value) ♥️")
                }
                NavigationLink {
                    DetailView()
                } label: {
                    Text("Go to detail!")
                }
            }
        }
        .environmentObject(anEnvironment)
    }

    final class AnEnvironment: ObservableObject {
        @Published var value = 1
    }

    struct DetailView: View {
        var body: some View {
            NavigationLink {
                DetailDetailView()
            } label: {
                Text("Go to detail detail!")
            }
        }
    }

    struct DetailDetailView: View {
        @EnvironmentObject private var anEnvironment: AnEnvironment

        var body: some View {
            VStack {
                Button("Táp me for ♥️") {
                    anEnvironment.value += 1
                }
                if anEnvironment.value > 0 {
                    Text("\(anEnvironment.value) ♥️")
                }
            }
        }
    }

}

#Preview {
    EnvironmentObjectView()
        .buttonStyle(.container)
}

// MARK: - EnvironmentObject vs Environment
protocol AnEnvironmentObjectProtocol: AnyObject, ObservableObject {
    // @Published
    var value: Int { get } // property 'value' declared inside a protocol cannot have a wrapper
}

private final class AnEnvironmentObject: ObservableObject, AnEnvironmentObjectProtocol {
    @Published var value = 1
}

struct AnEnvironmentObjectView: View {
    // @EnvironmentObject private var object: AnEnvironmentObjectProtocol

    var body: some View {
        EmptyView()
    }
}

// MARK: - Environment vs EnvironmentObject
protocol AnEnvironmentProtocol {
    var value: AnyPublisher<Int, Never> { get }
}

private final class AnEnvironment: AnEnvironmentProtocol {
    private let valueSubject = PassthroughSubject<Int, Never>()
    var value: AnyPublisher<Int, Never> { valueSubject.eraseToAnyPublisher() }
}

private extension EnvironmentValues {
    private struct AnEnvironmentKey: EnvironmentKey {
        static let defaultValue = AnEnvironment()
    }

    var anEnvironment: AnEnvironment {
        get { self[AnEnvironmentKey.self] }
        set { self[AnEnvironmentKey.self] = newValue }
    }
}

struct AnEnvironmentView: View {
    @Environment(\.anEnvironment) private var anEnvironment
    @State private var value = 0

    var body: some View {
        EmptyView()
            .onReceive(anEnvironment.value) { value in
                self.value = value
            }
    }
}
