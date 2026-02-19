import SwiftUI

@main
struct EliteManifestApp: App {
    @StateObject private var store = AppStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .onAppear { store.maybeDailyReset() }
        }
    }
}
