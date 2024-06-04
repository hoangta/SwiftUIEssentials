//
//  State+CoreData.swift
//  SwiftUIEssentials
//
//  Created by Hoang Ta on 3/6/24.
//

import SwiftUI
import SwiftData

// MARK: - Core data objects
struct CoreDataObjectState: View {
    struct ItemView: View {
        // @StateObject if using core data
        @Bindable var thing: Thing

        var body: some View {
            Text(thing.title)
                .padding()
                .onTapGesture {
                    thing.title = "Thing 3"
                }
        }
    }

    struct SomeListView: View {
        @State private var things: [Thing] = []

        var body: some View {
            VStack {
                ForEach(things) { thing in
                    ItemView(thing: thing)
                        .onAppear {
                            // ModelContext returns the same object if it is already fetch
                            print(Unmanaged.passUnretained(thing).toOpaque())
                        }
                }
            }
            .task {
                let fetch = FetchDescriptor<Thing>()
                things = (try? ModelContext.automatic.fetch(fetch)) ?? []
            }
        }
    }

    var body: some View {
        SomeListView()
            .background(Color.blue)

        SomeListView()
            .background(Color.green)
    }
}

#Preview("State7") {
    let context = ModelContext.automatic
    let thing1 = Thing(title: "Thing 1")
    context.insert(thing1)
    let thing2 = Thing(title: "Thing 2")
    context.insert(thing2)

    return CoreDataObjectState()
        .foregroundStyle(.primary)
        .buttonStyle(.container)
}

@Model
final class Thing {
    @Attribute(.unique) let id = UUID()
    var title: String

    init(title: String) {
        self.title = title
    }
}

extension ModelContext {
    static let models: [any PersistentModel.Type] = [
        Thing.self
    ]

    static let automatic: ModelContext = {
        let schema = Schema(models)
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            let modelContainer = try ModelContainer(for: schema, configurations: [config])
            return ModelContext(modelContainer)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

#Preview {
    CoreDataObjectState()
}
