//
//  Container.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - VStack
struct Container1: View {
    var body: some View {
        VStack {
            Text("Hi MappleLabs!")
            Button("Hit me hard for 🌟") {
                print("🌟🌟🌟")
            }
        }
    }
}

struct ContainerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.white)
            .padding()
            .background(Color.black)
            .clipShape(.buttonBorder)
            .opacity(configuration.isPressed ? 0.25 : 1)
    }
}
extension ButtonStyle where Self == ContainerButtonStyle {
    static var container: ContainerButtonStyle { .init() }
}

#Preview("Container1") {
    Container1()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - Multiple stacks
struct Container2: View {
    var body: some View {
        HStack {
            Color.black // yes, it's a view
                .frame(width: 5, height: 90)

            VStack {
                Text("Hi MappleLabs!")
                Button("Hit me hard for 🌟") {
                    print("🌟🌟🌟")
                }
            }
        }
    }
}

#Preview("Container2") {
    Container2()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - Random container view
struct Quote {
    let title: String
    let author: String
}

extension Quote: View {
    var body: some View {
        VStack(alignment: .trailing) {
            Text(title)
            Text(author)
        }
    }
}

struct Container2p5: View {
    var body: some View {
        Quote(title: "Hi MappleLabs!", author: "Dev")
    }
}

#Preview("Container2.5") {
    Container2p5()
}

// MARK: - ZStack
struct Container3: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(width: 220, height: 50)
                .clipShape(.rect(cornerRadius: 12))
            Text("Hit me hard for nothing!")
                .foregroundStyle(.white)
        }
    }
}

#Preview("Container3") {
    Container3()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - ZStack - the total size
struct Container3p1: View {
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black
                .frame(width: 220, height: 50)
                .clipShape(.rect(cornerRadius: 12))
            Text("Hit me hard for nothing!")
                .foregroundStyle(.white)
        }
        .frame(width: 100)
        .clipped()
    }
}

#Preview("Container3p1") {
    Container3p1()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - ZStack - the twisted size
struct Container3p2: View {
    var body: some View {
        ZStack {
            Color.black
                .frame(width: 220, height: 50)
                .clipShape(.rect(cornerRadius: 12))
            Text("Hit me hard for nothing!")
                .foregroundStyle(.white)
        }
        .clipped() // No effect
        .frame(width: 100, height: 120)
        .clipped()
        .background(Color.gray)
    }
}

#Preview("Container3p2") {
    Container3p2()
        .foregroundStyle(.primary)
}

// MARK: - frame - the invisible container!
struct Container4: View {
    var body: some View {
        Text("This is MappleLabs!")
            .frame(maxWidth: .infinity, alignment: .trailing)
            .border(.black)
    }
}

#Preview("Container4") {
    Container4()
        .foregroundStyle(.primary)
}

// MARK: - the view itself is the container
struct Container5: View {
    private struct WholeScreenText: View {
        var body: some View {
            Text("This is MappleLabs!")
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.cyan)
        }
    }

    var body: some View {
        WholeScreenText()
            .overlay(alignment: .bottom) {
                Button("Hit me hard from the bottom for 🌈") {
                    print("🌈🌈🌈")
                }
            }
            .background(alignment: .top) { // This is behind the cyan background
                Button("Can you hit me ?") {
                    print("Hit cdm chứ dc ?!")
                }
            }
    }
}

#Preview("Container5") {
    Container5()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - the lazy ones
struct Container6: View {
    let data = 1..<100
    let colors: [Color] = [.red, .green, .blue, .black, .cyan]

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(data, id: \.self) { index in
                    Text(String(index))
                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .center)
                        .background(colors[index % 5])
                        .onAppear {
                            print(index, "just appears")
                        }
                        .onDisappear {
                            print(index, "just disappears")
                        }
                }
            }
        }
    }
}

#Preview("Container6") {
    Container6()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

// MARK: - the table ones
struct Container7: View {
    var body: some View {
        Grid {
            GridRow {
                Text("1")
                Text("2")
                Text("3")
            }
            GridRow {
                Text("4")
                Text("5")
                    .gridCellColumns(2) // Grid documentation nha
            }
        }
    }
}

#Preview("Container7") {
    Container7()
        .foregroundStyle(.primary)
}

// MARK: - the lazy table ones
struct Container8: View {
    let data = 1..<100
    let colors: [Color] = [.red, .green, .blue, .black, .cyan]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: .fourColumns) {
                ForEach(data, id: \.self) { item in
                    Text(String(item))
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .background(colors[item % 5])
                }
            }
        }
    }
}

private extension Array where Element == GridItem {
    static let fourColumns: [GridItem] = [
        GridItem(.flexible(minimum: 80, maximum: .infinity)),
        GridItem(.flexible(minimum: 80, maximum: .infinity)),
        GridItem(.flexible(minimum: 80, maximum: .infinity)),
        GridItem(.flexible(minimum: 80, maximum: .infinity))
    ]
}

#Preview("Container8") {
    Container8()
        .foregroundStyle(.primary)
}

// MARK: - the most powerful/abused one
struct Container9: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Text("Hi MappleLabs! ♥️")
                Text("Hi again! 🤬")
                    .offset(x: 50, y: 50)

                Text("Hello again! 🤬")
                    .position(
                        x: geometry.frame(in: .local).midX,
                        y: geometry.frame(in: .local).midY
                    )

                Text("No! 🤬")
                    .position(
                        x: geometry.frame(in: .global).midX,
                        y: geometry.frame(in: .global).midY
                    )
                    .onAppear {
                        print("local", geometry.frame(in: .local))
                        print("global", geometry.frame(in: .global))
                    }
            }
            .frame(height: 300)
            .background { Color.cyan }

            Spacer()
        }
    }
}

#Preview("Container9") {
    Container9()
        .foregroundStyle(.primary)
}
