import Foundation

struct ChecklistItem: Identifiable, Codable, Hashable {
    var id = UUID()
    var title: String
    var detail: String
    var done: Bool = false
}

enum Bias: String, Codable, CaseIterable, Identifiable {
    case neutral, bull, bear
    var id: String { rawValue }
    var label: String {
        switch self {
        case .neutral: return "Neutral"
        case .bull: return "Bull"
        case .bear: return "Bear"
        }
    }
}

struct DailyMeta: Codable {
    var bias: Bias = .neutral
    var thesis: String = ""
    var dailyLossLimit: Double? = nil
    var riskPerTradePct: Double = 1.0
    var focus: String = ""
}

struct JournalEntry: Identifiable, Codable {
    var id = UUID()
    var date: Date = Date()
    var asset: String = ""
    var setup: String = "Trend continuation"
    var entry: Double? = nil
    var stop: Double? = nil
    var exit: Double? = nil
    var sizeAUD: Double? = nil
    var rMultiple: Double? = nil
    var emotion: Int? = nil
    var grade: String = "A"
    var notes: String = ""
}

enum CapitalMode: String, Codable, CaseIterable, Identifiable {
    case pct, pnl
    var id: String { rawValue }
    var label: String {
        rawValue == "pct" ? "Percent return (%)" : "PnL amount ($)"
    }
}

enum CapitalHelper: String, Codable, CaseIterable, Identifiable {
    case none, daily1, weekly3, monthly10
    var id: String { rawValue }
    var label: String {
        switch self {
        case .none: return "None"
        case .daily1: return "1% per day"
        case .weekly3: return "3% per week"
        case .monthly10: return "10% per month"
        }
    }
    var defaultRet: Double? {
        switch self {
        case .none: return nil
        case .daily1: return 1
        case .weekly3: return 3
        case .monthly10: return 10
        }
    }
}

struct CapitalRow: Identifiable, Codable {
    var id = UUID()
    var date: Date = Date()
    var label: String = ""
    /// if mode == pct: percent return; if mode == pnl: AUD dollars
    var ret: Double? = nil

    // calculated
    var before: Double? = nil
    var after: Double? = nil
}

struct CapitalState: Codable {
    var startCapital: Double = 10_000
    var mode: CapitalMode = .pct
    var helper: CapitalHelper = .none
    var rows: [CapitalRow] = []
}

struct AppState: Codable {
    var version: String = "1.0.0"
    var lastDailyResetISO: String? = nil

    var dailyMeta: DailyMeta = DailyMeta()

    var premarket: [ChecklistItem] = [
        .init(title: "Global market review + macro catalyst", detail: "Futures, rates, commodities, key news"),
        .init(title: "BTC direction + risk regime", detail: "Risk-on/off, key level holds/fails"),
        .init(title: "Define bias", detail: "Bull / Bear / Neutral based on structure"),
        .init(title: "Mark key levels", detail: "Prior high/low, VWAP, major S/R, gaps"),
        .init(title: "Watchlist", detail: "3 primary + 3 secondary + 1 short candidate"),
        .init(title: "Write A+ trade plans", detail: "Entry / stop / targets / size"),
        .init(title: "Set limits", detail: "Daily loss limit + risk cap 1–2%/trade")
    ]

    var market: [ChecklistItem] = [
        .init(title: "Opening range patience", detail: "First 15–30 mins: watch, don’t force"),
        .init(title: "Confirmation only", detail: "Structure + volume + level alignment"),
        .init(title: "VWAP logic", detail: "Hold/reclaim vs rejection"),
        .init(title: "Move stop only by rules", detail: "Breakeven only after structure confirms"),
        .init(title: "Avoid chop", detail: "Midday: fewer trades, higher quality"),
        .init(title: "Close plan", detail: "Flat / hold / hedge decision is planned")
    ]

    var post: [ChecklistItem] = [
        .init(title: "Screenshot charts", detail: "Entry/exit + key levels"),
        .init(title: "Journal execution", detail: "Setup quality + grade + emotions + lesson"),
        .init(title: "Update capital tracker", detail: "PnL + R + drawdown tracking"),
        .init(title: "Plan tomorrow", detail: "Key levels + watchlist + focus rule")
    ]

    var spare: [ChecklistItem] = [
        .init(title: "Spare hour (before work)", detail: "Markets + thesis + plan check"),
        .init(title: "Spare hour (during work)", detail: "Review positions; no impulsive entries"),
        .init(title: "Spare hour (after work)", detail: "Journal + mobility OR strategy study")
    ]

    var journal: [JournalEntry] = []
    var capital: CapitalState = CapitalState()
}
