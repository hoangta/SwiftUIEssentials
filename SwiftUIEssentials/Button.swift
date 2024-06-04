//
//  Button.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI

// MARK: - Button only
struct Button1: View {
    var body: some View {
        Button("Táp me for ♥️") {
            print("♥️")
        }

        /*
        Button(action: {
            print("♥️")
        }, label: {
            Text("Táp me for ♥️")
        })
         */
    }
}

#Preview("Button1") {
    Button1()
}

// MARK: -  Button with styled label
struct Button2: View {
    var body: some View {
        Button(action: {
            print("♥️")
        }, label: {
            Text("Táp me for ♥️")
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.black)
                .clipShape(.buttonBorder)
                // .cornerRadius(8) ⤴
                // .clipShape(.rect(cornerRadius: 8)) ⤴
        })
    }
}

#Preview("Button2") {
    Button2()
}

// MARK: - Reuse button with styled label using new button view
struct Button3: View {
    var body: some View {
        VStack {
            TápButton(
                action: { print("♥️") },
                title: "Táp me for ♥️"
            )
            TápButton(
                action: { print("🦴") },
                title: "Táp me for 🦴"
            )
        }
    }

    struct TápButton: View {
        let action: () -> Void
        let title: String

        var body: some View {
            Button(action: action, label: {
                Text(title)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.black)
                    .clipShape(.buttonBorder)
            })
        }
    }
}

#Preview("Button3") {
    Button3()
}

// MARK: - Reuse button with styled label using button style
struct Button4: View {
    var body: some View {
        VStack {
            Button("Táp me for ♥️") {
                print("♥️")
            }
            Button("Táp me for 🦴") {
                print("🦴")
            }
        }
        .buttonStyle(TápStyle())
    }

    struct TápStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.black)
                .clipShape(.buttonBorder)
                .opacity(configuration.isPressed ? 0.25 : 1)
        }
    }
}

#Preview("Button4") {
    Button4()
}

// MARK: - Reuse button with styled label using constructor
struct Button5: View {
    enum Treat: String {
        case heart = "♥️", bone = "🦴"
    }

    var body: some View {
        VStack {
            Button(.heart)
            Button(.bone)
        }
    }

    struct TreatView: View {
        let treat: Treat

        var body: some View {
            Text(treat.rawValue)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.black)
                .clipShape(.buttonBorder)
        }
    }
}

private extension Button where Label == Button5.TreatView {
    init(_ treat: Button5.Treat) {
        self.init(action: { print(treat.rawValue) }, label: {
            Button5.TreatView(treat: treat)
        })
    }
}

#Preview("Button5") {
    Button5()
}
