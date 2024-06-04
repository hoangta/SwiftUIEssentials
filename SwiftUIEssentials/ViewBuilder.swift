//
//  ViewBuilder.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// Reference: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/opaquetypes/
struct ViewBuilderView1: View {
    let flag = false

    var body: some View {
        VStack {
            Button("Test") {
                let aStack = VStack {
                    Text("Mot")
                    Text("Hi")
                    Text("Bar")
                }
                print(type(of: aStack))
                print(content1)
                print(content2)
                print(content3)
                print(contentX)
            }
        }
    }

    var content1: some View {
        Text("Content 1")
    }

    @ViewBuilder
    var content2: some View {
        Text("Content 2")
        Text("Content 2")
    }

    @ViewBuilder
    var content3: some View {
        if flag {
            Text("Content 3 true")
        } else {
            Text("Content 3 false")
        }
    }

    var contentX: any View {
        if flag {
            Text("Content 3 true")
        } else {
            Image(systemName: "xmark")
        }
    }
}

#Preview("ViewBuilderView1") {
    ViewBuilderView1()
}

struct ViewBuilderView2<Label: View>: View {
    @ViewBuilder let label: () -> Label

    var body: some View {
        label()
    }
}

#Preview("ViewBuilderView2") {
    ViewBuilderView2 {
        if true {
            Text("Hi")
        }
    }
}
