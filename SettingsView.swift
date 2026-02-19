import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: AppStore

    var body: some View {
        NavigationView {
            List {
                Section("Daily reset") {
                    Button("Reset Daily Checklist Now") {
                        store.manualDailyReset()
                    }
                }

                Section("Backup") {
                    Text("Export/Import (Files app) can be added next.\nTell me and I’ll plug it in.")
                        .foregroundColor(.secondary)
                }

                Section("Disclaimer") {
                    Text("Educational planning software, not financial advice. Trading involves risk.")
                        .foregroundColor(.secondary)
                }

                Section("Build") {
                    Text("v \(store.state.version) • \(Date().formatted(date: .abbreviated, time: .omitted))")
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}
