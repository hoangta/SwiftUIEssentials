//
//  Text.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - Text only
struct Text1: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
    }
}

#Preview("Text1") {
    Text1()
}

// MARK: - Text with font modifier
struct Text2: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .font(.system(size: 20, weight: .bold))
    }
}

#Preview("Text2") {
    Text2()
}

// MARK: - Text with background modifier
struct Text3: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .background(Color.black)
    }
}

#Preview("Text3") {
    Text3()
        .foregroundStyle(Color.white)
}

// MARK: - Text with multiple background modifiers
struct Text4: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .padding()
            .background(Color.black)
            .padding()
            .background(Color.blue)
            .padding()
            .background(Color.green)
    }
}

#Preview("Text4") {
    Text4()
        .foregroundStyle(Color.white)
}

// MARK: - Text with overlapping modifiers
struct Text5: View {
    var body: some View {
        Text("Hi MappleLabs! ♥️")
            .font(.system(size: 20, weight: .bold))
            .foregroundStyle(Color.red)
            .font(.system(size: 120, weight: .thin))
            .foregroundStyle(Color.blue)

    }
}

#Preview("Text5") {
    Text5()
}

// MARK: - Text with overlapping modifiers 2
struct Text6: View {
    var body: some View {
        VStack {
            Text("Hi MappleLabs! ♥️")
                .bold(false)
            Text("Hi again! ❤️")
                .italic()
        }
        .bold()
    }
}

#Preview("Text6") {
    Text6()
}
