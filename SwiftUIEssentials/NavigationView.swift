//
//  NavigationView.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 6/6/24.
//

import SwiftUI

struct NavigationView1: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hi MappleLabs! ♥️")
                NavigationLink(destination: Text("Destination")) {
                    Text("Navigate")
                }
            }
            .bold()
            .foregroundStyle(Color.red)
        }
    }
}

#Preview("NavigationView1") {
    NavigationView1()
        .buttonStyle(.container)
}

struct NavigationView2: View {
    @State private var showsDestination = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Hi MappleLabs! ♥️")
                Button("Navigate", action: { showsDestination = true })

                NavigationLink(
                    destination: Text("Destination"),
                    isActive: $showsDestination,
                    label: {}
                )
            }
        }
    }
}

#Preview("NavigationView2") {
    NavigationView2()
        .buttonStyle(.container)
}

struct NavigationView3: View {
    @State private var navigationPath = NavigationPath()
    @State private var showsDestination = false
    @State private var destination: Int?

    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Text("Hi MappleLabs! ♥️")
                Button("Navigate 1", action: { showsDestination = true })
                Button("Navigate 2", action: { destination = 2 })
                Button("Navigate 3", action: { navigationPath.append("Final destination") })
            }
            .navigationDestination(isPresented: $showsDestination) {
                Text("Destination 1")
            }
            .navigationDestination(item: $destination) { v in
                Text("Destination \(v)")
            }
            .navigationDestination(for: String.self) { title in
                Text(title)
            }
        }
    }

    func fetchData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            showsDestination = true
        }
    }
}

#Preview("NavigationView3") {
    NavigationView3()
        .buttonStyle(.container)
}
