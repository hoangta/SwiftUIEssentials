//
//  Modifier.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - Modifier without state
struct Modifier1: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .mappleText()
    }
}

private extension View {
    func mappleText() -> some View {
        font(.system(size: 20, weight: .bold))
            .foregroundStyle(Color.red)
            .padding()
            .background(Color.black)
            .clipShape(.capsule)
    }
}

#Preview("Modifier1") {
    Modifier1()
}

// MARK: - Modifier with state
struct Modifier2: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .modifier(MappleText(color: .blue))
    }
}

extension Modifier2 {
    struct MappleText: ViewModifier {
        let color: Color

        func body(content: Content) -> some View {
            content
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(color)
                .padding()
                .background(Color.black)
                .clipShape(.capsule)
        }
    }
}

#Preview("Modifier2") {
    Modifier2()
}

// MARK: - Modifier with syntactic sugar
struct Modifier3: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .mappleText(color: .green)
    }
}

extension View {
    func mappleText(color: Color) -> some View {
        modifier(Modifier2.MappleText(color: color))
    }
}

#Preview("Modifier3") {
    Modifier3()
}

// MARK: - Some modifiers - sheet
struct Modifier4: View {
    @State private var showsSheet = false

    enum Sheet: Identifiable {
        var id: Self { self }

        case greetings, cursings
    }
    @State private var sheet: Sheet?

    var body: some View {
        VStack(spacing: 25) {
            Text("Hi MappleLabs! ♥️")
                .onTapGesture {
                    showsSheet = true
                }
                .sheet(isPresented: $showsSheet) {
                    Text("Hi again! ♥️")
                }

            Text("Say hi! ♥️")
                .onTapGesture {
                    sheet = .greetings
                }

            Text("Say cc! 🤬")
                .onTapGesture {
                    sheet = .cursings
                }
        }
        .sheet(item: $sheet) { sheet in
            switch sheet {
            case .greetings: Text("Hi again! ♥️")
            case .cursings: Text("Hi cc! ♥️")
            }
        }
    }
}

#Preview("Modifier4") {
    Modifier4()
}

// MARK: - Some modifiers - matchedGeometryEffect
struct Modifier5: View {
    @Namespace private var namespace
    @State private var flag = true

    var body: some View {
        VStack(spacing: 25) {
            if flag {
                Text("Hi MappleLabs! ♥️")
                    .foregroundStyle(Color.white)
                    .padding()
                    .background { Color.black }
                    .cornerRadius(12)
                    .matchedGeometryEffect(id: "text", in: namespace)
                    .onTapGesture {
                        withAnimation {
                            flag.toggle()
                        }
                    }
            } 
            Spacer()
            if !flag {
                Text("Hi MappleLabs! ♥️")
                    .foregroundStyle(Color.black)
                    .padding()
                    .background { Color.black.opacity(0.2) }
                    .matchedGeometryEffect(id: "text", in: namespace)
                    .onTapGesture {
                        withAnimation {
                            flag.toggle()
                        }
                    }
            }
        }
    }
}

#Preview("Modifier5") {
    Modifier5()
}
