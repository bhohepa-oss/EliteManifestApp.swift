import SwiftUI

struct CapitalView: View {
    @EnvironmentObject var store: AppStore
    @State private var newLabel = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section("Settings") {
                        TextField("Starting capital (AUD)", value: $store.state.capital.startCapital, format: .number)
                            .keyboardType(.decimalPad)

                        Picker("Mode", selection: $store.state.capital.mode) {
                            ForEach(CapitalMode.allCases) { Text($0.label).tag($0) }
                        }

                        Picker("Projection helper", selection: $store.state.capital.helper) {
                            ForEach(CapitalHelper.allCases) { Text($0.label).tag($0) }
                        }

                        Button("Save + Recalculate") {
                            store.recalcCapital()
                        }
                    }

                    Section("Rows") {
                        Button("Add Row") {
                            store.state.capital.rows.append(CapitalRow())
                            store.recalcCapital()
                        }

                        ForEach(store.state.capital.rows) { row in
                            VStack(alignment: .leading, spacing: 8) {
                                DatePicker("Date", selection: binding(row.id).date, displayedComponents: .date)

                                TextField("Label", text: binding(row.id).label)
                                    .textFieldStyle(.roundedBorder)

                                TextField(store.state.capital.mode == .pct ? "Return (%)" : "PnL (AUD)",
                                          value: binding(row.id).ret,
                                          format: .number)
                                    .keyboardType(.decimalPad)
                                    .textFieldStyle(.roundedBorder)

                                HStack {
                                    Text("Before: \((row.before ?? store.state.capital.startCapital).aud)")
                                    Spacer()
                                    Text("After: \((row.after ?? 0).aud)")
                                }
                                .font(.caption)
                                .foregroundColor(.secondary)

                                Button(role: .destructive) {
                                    store.state.capital.rows.removeAll { $0.id == row.id }
                                    store.recalcCapital()
                                } label: { Text("Delete Row") }
                                .buttonStyle(.bordered)
                            }
                        }
                    }

                    Section("Summary") {
                        Text(store.capitalSummary())
                    }
                }
            }
            .navigationTitle("Capital")
            .onChange(of: store.state.capital.startCapital) { _ in store.recalcCapital() }
        }
    }

    private func binding(_ id: UUID) -> Binding<CapitalRow> {
        Binding(
            get: { store.state.capital.rows.first(where: { $0.id == id }) ?? CapitalRow() },
            set: { newValue in
                if let idx = store.state.capital.rows.firstIndex(where: { $0.id == id }) {
                    store.state.capital.rows[idx] = newValue
                    store.recalcCapital()
                }
            }
        )
    }
}
