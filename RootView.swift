import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            DailyView()
                .tabItem { Label("Daily", systemImage: "checklist") }

            JournalView()
                .tabItem { Label("Journal", systemImage: "book") }

            CapitalView()
                .tabItem { Label("Capital", systemImage: "chart.line.uptrend.xyaxis") }

            ShortsView()
                .tabItem { Label("Shorts", systemImage: "arrow.down.right") }

            WeeklyView()
                .tabItem { Label("Weekly", systemImage: "calendar") }

            SettingsView()
                .tabItem { Label("Settings", systemImage: "gearshape") }
        }
    }
}
