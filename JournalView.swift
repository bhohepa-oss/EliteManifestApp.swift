import SwiftUI

struct JournalView: View {
    @EnvironmentObject var store: AppStore
    @State private var search = ""
    @State private var draft = JournalEntry()

    private let setups = [
        "Trend continuation","Breakdown & retest","Gap fade","VWAP rejection","Liquidity sweep","Momentum divergence","Other"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    entryForm

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("History").font(.headline)
                            Spacer()
                            TextField("Search…", text: $search)
                                .textFieldStyle(.roundedBorder)
                                .frame(maxWidth: 220)
                        }

                        ForEach(filtered().reversed()) { e in
                            VStack(alignment: .leading, spacing: 6) {
                                HStack {
                                    Text("\(e.asset) • \(e.setup)").bold()
                                    Spacer()
                                    Text(e.date.formatted(date: .abbreviated, time: .omitted))
                                        .foregroundColor(.secondary)
                                }
                                Text("Entry \(fmt(e.entry)) • Stop \(fmt(e.stop)) • Exit \(fmt(e.exit)) • R \(fmt(e.rMultiple)) • Grade \(e.grade)")
                                    .font(.caption).foregroundColor(.secondary)
                                if !e.notes.isEmpty { Text(e.notes) }

                                Button(role: .destructive) {
                                    store.state.journal.removeAll { $0.id == e.id }
                                    store.save()
                                } label: {
                                    Text("Delete")
                                }
                                .buttonStyle(.bordered)
                            }
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 14))
                        }

                        if store.state.journal.isEmpty {
                            Text("No entries yet.").foregroundColor(.secondary)
                        }
                    }
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding()
            }
            .navigationTitle("Journal")
            .toolbar {
                Button("New") { draft = JournalEntry() }
            }
        }
    }

    private var entryForm: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("New Entry").font(.headline)

            DatePicker("Date", selection: $draft.date, displayedComponents: .date)

            TextField("Asset (BTC / ETH / SOL / XRP / ASX ticker)", text: $draft.asset)
                .textFieldStyle(.roundedBorder)

            Picker("Setup", selection: $draft.setup) {
                ForEach(setups, id: \.self) { Text($0).tag($0) }
            }

            HStack {
                numField("Entry", $draft.entry)
                numField("Stop", $draft.stop)
                numField("Exit", $draft.exit)
            }

            HStack {
                numField("Position size ($)", $draft.sizeAUD)
                numField("R multiple", $draft.rMultiple)
                TextField("Grade (A–F)", text: $draft.grade).textFieldStyle(.roundedBorder).frame(maxWidth: 110)
            }

            Stepper("Emotion (1–10): \(draft.emotion ?? 5)", value: Binding(
                get: { draft.emotion ?? 5 },
                set: { draft.emotion = $0 }
            ), in: 1...10)

            TextEditor(text: $draft.notes)
                .frame(height: 110)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray.opacity(0.25)))

            HStack {
                Button("Save") {
                    store.state.journal.append(draft)
                    store.save()
                    draft = JournalEntry()
                }
                .buttonStyle(.borderedProminent)

                Button("Clear") { draft = JournalEntry() }
                    .buttonStyle(.bordered)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }

    private func filtered() -> [JournalEntry] {
        let q = search.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if q.isEmpty { return store.state.journal }
        return store.state.journal.filter {
            $0.asset.lowercased().contains(q) ||
            $0.setup.lowercased().contains(q) ||
            $0.notes.lowercased().contains(q)
        }
    }

    private func numField(_ title: String, _ value: Binding<Double?>) -> some View {
        TextField(title, value: value, format: .number)
            .keyboardType(.decimalPad)
            .textFieldStyle(.roundedBorder)
    }

    private func fmt(_ v: Double?) -> String {
        guard let v else { return "—" }
        return String(format: "%.4f", v)
    }
}
