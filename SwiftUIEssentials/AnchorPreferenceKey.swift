//
//  PreferenceKey.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - AnchorPreference - example
struct UIKitLayout: View {
    @State private var selected = 0

    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { item in
                    Text("Item \(item)")
                        .padding()
                        .frame(width: geometry.size.width / 3)
                        .onTapGesture {
                            withAnimation {
                                selected = item
                            }
                        }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay {
                Rectangle()
                    .stroke(lineWidth: 5)
                    .frame(width: geometry.size.width / 3, height: 45)
                    .offset(x: (geometry.size.width / 3) * CGFloat(selected) - (geometry.size.width / 3) )
            }
        }
        .padding()
    }
}

#Preview("UIKitLayout") {
    UIKitLayout()
}

struct NamespaceLayout: View {
    @Namespace var namespace
    @State private var selected = 0

    var body: some View {
        HStack {
            ForEach(0..<3, id: \.self) { item in
                Text("Item \(item)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .onTapGesture {
                        withAnimation {
                            selected = item
                        }
                    }
                    .overlay {
                        if selected == item {
                            Rectangle().stroke(lineWidth: 5)
                                .matchedGeometryEffect(id: "item", in: namespace)
                        }
                    }
            }
        }
        .padding()
    }
}

#Preview("NamespaceLayout") {
    NamespaceLayout()
}

struct PreferenceKeyLayout: View {
    @State private var selected = 0

    var body: some View {
        HStack {
            ForEach(0..<3, id: \.self) { item in
                Text("Item \(item)")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .anchorPreference(key: ItemPreferenceKey.self, value: .bounds) { bounds in
                        [item: bounds]
                    }
                    .onTapGesture {
                        withAnimation {
                            selected = item
                        }
                    }
            }
        }
        .overlayPreferenceValue(ItemPreferenceKey.self) { value in
            if let anchor = value[selected] {
                GeometryReader { geometry in
                    let bounds = geometry[anchor]
                    Rectangle().stroke(lineWidth: 5)
                        .frame(width: bounds.width, height: bounds.height)
                        .offset(x: bounds.minX)
                }
            }
        }
        .padding()
    }

    struct ItemPreferenceKey: PreferenceKey {
        typealias Value = [Int: Anchor<CGRect>]

        static var defaultValue: Value { [:] }

        static func reduce(value: inout Value, nextValue: () -> Value) {
            nextValue().forEach { k, v in
                value[k] = v
            }
        }
    }

    /*
    struct ItemPreferenceKey: PreferenceKey {
        typealias Value = [(Int, Anchor<CGRect>)]

        static var defaultValue: Value { [] }

        static func reduce(value: inout Value, nextValue: () -> Value) {
            value = value + nextValue()
        }
    }
     */
}

#Preview("PreferenceKeyLayout") {
    PreferenceKeyLayout()
}

// MARK: - AnchorPreference - A use case
extension View {
    func onOffsetYChange(bindTo offsetY: Binding<CGFloat>) -> some View {
        modifier(OnOffsetYChangeModifier(offsetY: offsetY))
    }
}

private struct OnOffsetYChangeModifier: ViewModifier {
    @Binding var offsetY: CGFloat

    func body(content: Content) -> some View {
        content
            .background(GeometryReader { geometry in
                Color.clear
                    .preference(
                        key: PreferenceKey.self,
                        value: geometry.frame(in: .scrollView).origin.y
                    )
            })
            .onPreferenceChange(PreferenceKey.self) { offsetY = $0 }
    }
}

extension OnOffsetYChangeModifier {
    struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: CGFloat { .zero }
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
    }
}

#Preview("AnchorPreference") {
    struct Preview: View {
        @State private var offsetY: CGFloat = 0

        var body: some View {
            ScrollView {
                Text("Hi MappleLabs! ♥️")
                    .foregroundStyle(Color.white)
                    .onOffsetYChange(bindTo: $offsetY)
            }
            .frame(maxWidth: .infinity)
            .background(alignment: .top) {
                Image(.coverSafe)
                    .resizable()
                    .frame(height: 150)
                    .topBouncing(offsetY: offsetY)
                    .ignoresSafeArea()
            }
            .background(Color.black)
        }
    }
    return Preview()
}

extension View {
    func topBouncing(offsetY: CGFloat) -> some View {
        modifier(TopBouncingModifier(offsetY: offsetY))
    }
}

private struct TopBouncingModifier: ViewModifier {
    let offsetY: CGFloat
    private var scaleFactor: CGFloat { max(1, 1 + (offsetY / 320)) }

    func body(content: Content) -> some View {
        content
            .scaleEffect(
                x: scaleFactor,
                y: scaleFactor,
                anchor: .top
            )
    }
}
