import SwiftUI

struct ShortsView: View {
    var body: some View {
        NavigationView {
            List {
                Section("Non-negotiables") {
                    Text("• Min 2:1 reward:risk\n• Max 1–2% risk per trade\n• Respect daily loss limit\n• No averaging into losers\n• No revenge trades")
                }

                Section("Gap Fade") {
                    Text("Trigger: opening range fails + volume confirms fade.\nEntry: breakdown + failed retest.\nStop: above gap high/wick.\nTargets: VWAP → prior close → liquidity zone.")
                }

                Section("VWAP Rejection") {
                    Text("Trigger: push above VWAP → rejection → close below with volume.\nEntry: lower high after rejection.\nStop: above rejection high.\nTargets: prior low → support.")
                }

                Section("Liquidity Sweep") {
                    Text("Trigger: wick through key level → sharp rejection → lower high.\nEntry: break of micro-support.\nStop: above sweep wick.\nTargets: range mid → range low.")
                }

                Section("Momentum Divergence") {
                    Text("Use only with structure break + failed retest.\nStop: above last swing high.\nDo not short divergence alone.")
                }
            }
            .navigationTitle("Short Playbooks")
        }
    }
}
