//
//  State.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - State
struct State1: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count += 1
            }
            if count > 0 {
                Text("\(count) 🏀")
            }
        }
    }
}

#Preview("State1") {
    State1()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - Binding
struct State2: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            TápButton(count: $count) // state's projected value
            if count > 0 {
                Text("\(count) 🏀")
            }
        }
    }

    struct TápButton: View {
        @Binding var count: Int

        var body: some View {
            Button("Touch me gennitally for 🏀") {
                count += 1
            }
        }
    }
}

#Preview("State2") {
    State2()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - Custom Binding
struct State2p1: View {
    @State private var count = 0

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            TápButton(count: .init(get: {
                count
            }, set: { value in
                count = value * 2
            }))
            if count > 0 {
                Text("\(count) 🏀")
            }
        }
    }

    struct TápButton: View {
        @Binding var count: Int

        var body: some View {
            Button("Touch me gennitally for 🏀") {
                count += 1
            }
        }
    }
}

#Preview("State2p1") {
    State2p1()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - State is for value types
struct State3: View {
    struct Value {
        var value: Int
    }
    @State private var count = Value(value: 0)

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count.value += 1
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }
}

#Preview("State3") {
    State3()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - State is not for reference types
struct State3p1: View {
    class Value {
        var value: Int

        init(value: Int) {
            self.value = value
        }
    }

    @State private var count = Value(value: 0)

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count.value += 1
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }
}

#Preview("State3p1") {
    State3p1()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - State is not for reference types but I hate value types
struct State3p2: View {
    class Value {
        var value: Int

        init(value: Int) {
            self.value = value
        }
    }

    @State private var count = Value(value: 0)

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count = Value(value: count.value + 1)
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }
}

#Preview("State3p2") {
    State3p2()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - StateObject
// StateObject is best choice for designing view model.
struct State4: View {
    class Value: ObservableObject {
        @Published var value: Int = 0
    }

    @StateObject private var count = Value()

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count.value += 1
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }
}

#Preview("State4") {
    State4()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - ObservedObject
struct State5: View {
    struct TápView: View {
        class Value: ObservableObject {
            @Published var value: Int = 0
        }

        @ObservedObject private var count = Value()

        var body: some View {
            Button("Touch me gennitally for 🏀") {
                count.value += 1
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }

    @State private var random = Int.random(in: 0..<100)

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Do not touch me!") {
                random = Int.random(in: 0..<100)
            }
            Text("\(random)")
            TápView()
        }
    }
}

#Preview("State5") {
    State5()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - iOS 17: Observable for state
struct State6: View {
    @Observable
    class Value {
        var value: Int = 0
    }

    @State private var count = Value()

    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Touch me gennitally for 🏀") {
                count.value += 1
            }
            if count.value > 0 {
                Text("\(count.value) 🏀")
            }
        }
    }
}

#Preview("State6") {
    State6()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}
