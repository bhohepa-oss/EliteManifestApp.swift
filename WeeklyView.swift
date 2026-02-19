import SwiftUI

struct WeeklyView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Timing") {
                    Text("Onsite 7:30–16:30 → Train at home 30–45 mins (suggest 17:15–18:00).")
                }

                day("Monday — Trend continuation",
                    trade: ["Trade with trend", "VWAP hold + pullback entries", "Stops by structure"],
                    workout: ["Push-ups 4×max", "Pike push-ups 3×10", "Dips 3×8–12", "Plank 3×60s"])

                day("Tuesday — Breakdown & retest",
                    trade: ["Support breaks only", "Enter failed retest", "Avoid shorting into support"],
                    workout: ["Pull-ups 4×max", "Towel hangs 3×30–60s", "Inverted rows 3×12", "Dead hangs 3 rounds"])

                day("Wednesday — Catalyst day (A+ only)",
                    trade: ["Plan first", "Reduce size in high volatility", "No impulsive adds"],
                    workout: ["Hanging knee raises 4×12", "Side plank 3×45s/side", "Bird-dogs 3×15", "Loaded carry (grip) 3 rounds"])

                day("Thursday — Reversal/exhaustion",
                    trade: ["Overextension + divergence", "Confirm structure flip", "No guessing tops"],
                    workout: ["Clap push-ups 3×8", "Jump squats 4×12", "Burpees 3×12", "Mountain climbers 3×40s"])

                day("Friday — Risk reduction + audit",
                    trade: ["Smaller size", "Best setups only", "Weekly stats review"],
                    workout: ["Slow tempo push-ups 3×max", "Long dead hang challenge", "Shoulder mobility 10 min", "Hip/T-spine mobility 10 min"])
            }
            .navigationTitle("Weekly")
        }
    }

    private func day(_ title: String, trade: [String], workout: [String]) -> some View {
        Section(title) {
            Text("Trading focus:\n• " + trade.joined(separator: "\n• "))
            Text("Workout (30–45 min):\n• " + workout.joined(separator: "\n• "))
        }
    }
}
