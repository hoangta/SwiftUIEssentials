//
//  PreferenceKey.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - PreferenceKey 1
struct PreferenceKey1: View {
    @State private var loveCount = 0

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
                .preference(key: LoveKey.self, value: 3)

            Text("The day is just beautifil, isn't it?")
                .preference(key: LoveKey.self, value: 8)

            Text("\(loveCount) ♥️")
        }
        .onPreferenceChange(LoveKey.self, perform: { value in
            loveCount = value
        })
    }

    struct LoveKey: PreferenceKey {
        static var defaultValue: Int { 0 }

        static func reduce(value: inout Int, nextValue: () -> Int) {
            print(value, nextValue())
            value *= nextValue()
        }
    }
}

#Preview("PreferenceKey1") {
    PreferenceKey1()
}

// MARK: - PreferenceKey 2
struct PreferenceKey2: View {
    @State private var loveCount = 0

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
                .preference(key: LoveKey.self, value: 3)
            VStack {
                Text("The day is just beautifil, isn't it?")
                    .preference(key: LoveKey.self, value: 8)
                Text("And you, you just made it better 🌟")
                    .preference(key: LoveKey.self, value: 11)
            }
            Text("\(loveCount) ♥️")
        }
        .onPreferenceChange(LoveKey.self, perform: { value in
            print(value)
            loveCount = value
        })
    }

    struct LoveKey: PreferenceKey {
        static var defaultValue: Int { 0 }

        static func reduce(value: inout Int, nextValue: () -> Int) {
            print(value, nextValue())
            value *= nextValue()
        }
    }
}

#Preview("PreferenceKey2") {
    PreferenceKey2()
}

// MARK: - PreferenceKey - A real use case
struct PreferenceKey3: View {
    @State private var showsFloatButton = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("Hi MappleLabs! ♥️")
                NavigationLink {
                    Text("Hi again!")
                        .preference(key: ShowFloatButtonKey.self, value: true)
                } label: {
                    Text("Go to hi again!")
                }
                NavigationLink {
                    Text("Cúcdeekoo!")
                        .preference(key: ShowFloatButtonKey.self, value: false)
                } label: {
                    Text("Go to Cúcdeekoo!")
                }
            }
        }
        .onPreferenceChange(ShowFloatButtonKey.self) { value in
            print(value)
            showsFloatButton = value
        }
        .overlay(alignment: .bottomTrailing) {
            if showsFloatButton {
                Image(systemName: "plus")
                    .padding()
                    .foregroundStyle(Color.white)
                    .background { Color.black }
                    .clipShape(.capsule)
                    .padding(.horizontal)
            }
        }
    }

    struct ShowFloatButtonKey: PreferenceKey {
        static var defaultValue: Bool { true }

        static func reduce(value: inout Bool, nextValue: () -> Bool) {
            value = value && nextValue()
        }
    }
}

#Preview("PreferenceKey3") {
    PreferenceKey3()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - PreferenceKey - An actual real use case
struct PreferenceKey4: View {
    @State private var showsFloatButton = true

    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("Hi MappleLabs! ♥️")
                NavigationLink {
                    Text("Hi again!")
                } label: {
                    Text("Go to hi again!")
                }
                NavigationLink {
                    Text("Cúcdeekoo!")
                        .hideFloatButton()
                } label: {
                    Text("Go to Cúcdeekoo!")
                }
            }
        }
        .floatButton {
            Image(systemName: "plus")
                .padding()
                .foregroundStyle(Color.white)
                .background { Color.black }
                .clipShape(.capsule)
                .padding(.horizontal)
        }
    }
}

extension View {
    func hideFloatButton() -> some View {
        preference(key: ShowFloatButtonKey.self, value: false)
    }

    func floatButton<Label: View>(@ViewBuilder label: @escaping () -> Label) -> some View {
        modifier(FloatButtonModifier(label: label))
    }
}

private struct ShowFloatButtonKey: PreferenceKey {
    static var defaultValue: Bool { true }

    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = value && nextValue()
    }
}

private struct FloatButtonModifier<Label: View>: ViewModifier {
    @State private var showsFloatButton = true
    let label: () -> Label

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(ShowFloatButtonKey.self) { value in
                showsFloatButton = value
            }
            .overlay(alignment: .bottomTrailing) {
                if showsFloatButton {
                    label()
                }
            }
    }
}

#Preview("PreferenceKey4") {
    PreferenceKey4()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}
