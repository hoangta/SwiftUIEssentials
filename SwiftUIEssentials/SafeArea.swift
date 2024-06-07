//
//  SafeArea.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 6/6/24.
//

import SwiftUI

// MARK: - Respect the area
struct SafeAreaView1: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
            Spacer()
            TextField("Enter something..", text: $text)
        }
        .padding()
    }
}

#Preview("SafeAreaView1") {
    SafeAreaView1()
}

// MARK: - Disrespect the area
struct SafeAreaView2: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
            Spacer()
            TextField("Enter something..", text: $text)
        }
        .padding()
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview("SafeAreaView2") {
    SafeAreaView2()
}

// MARK: - Disrespect the area but not sir 🔑board
struct SafeAreaView3: View {
    @State private var text = ""

    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
            Spacer()
            TextField("Enter something..", text: $text)
        }
        .padding()
        .ignoresSafeArea(.container, edges: .bottom)
    }
}

#Preview("SafeAreaView3") {
    SafeAreaView3()
}

// MARK: - Disrespect the area but not sir 🔑board
struct SafeAreaView4: View {
    @State private var text = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack {
                    ForEach(0..<25, id: \.self) { value in
                        Rectangle()
                            .fill(Color(
                                red: Double.random(in: 0..<1),
                                green: Double.random(in: 0..<1),
                                blue: Double.random(in: 0..<1))
                            )
                            .frame(maxWidth: .infinity, minHeight: 75)
                    }
                }
                .padding()
            }
            // .clipped()
            TextField("Enter something..", text: $text)
        }
        .safeAreaInset(edge: .bottom, spacing: 0) {
            Button(action: {}) {
                Text("Submit")
                    .foregroundStyle(.white)
                    .bold()
                    .frame(maxWidth: .infinity, minHeight: 80)
                    .background(Color.red.opacity(0.75))
            }
        }
    }
}

#Preview("SafeAreaView4") {
    SafeAreaView4()
}
