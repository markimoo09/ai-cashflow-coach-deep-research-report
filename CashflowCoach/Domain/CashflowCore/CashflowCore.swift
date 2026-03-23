import Foundation

// MARK: - Domain Enums

enum AccountType: String, Codable, CaseIterable, Sendable, Hashable {
    case checking, savings, credit, cash, investment
}

enum Frequency: String, Codable, CaseIterable, Sendable, Hashable {
    case weekly, biweekly, semiMonthly, monthly, quarterly, annually, custom
}

enum EntryType: String, Codable, CaseIterable, Sendable, Hashable {
    case income, expense, transfer, adjustment
}

enum ReminderType: String, Codable, CaseIterable, Sendable, Hashable {
    case paymentDue, lowBalance, forecastReady, upcomingExpense
}

// MARK: - DTOs (value types for safe cross-boundary data transfer)

struct UserProfileDTO: Sendable, Identifiable {
    let id: UUID
    var name: String
    var createdAt: Date
    var onboardingCompleted: Bool
}

struct CashAccountDTO: Sendable, Identifiable {
    let id: UUID
    var name: String
    var accountType: AccountType
    var balanceCents: Int
    var currencyCode: String
    var institution: String
    var isActive: Bool
    var createdAt: Date
    var sortOrder: Int
}

struct IncomeScheduleDTO: Sendable, Identifiable {
    let id: UUID
    var name: String
    var amountCents: Int
    var frequency: Frequency
    var customFrequencyDays: Int
    var nextPayDate: Date
    var isActive: Bool
    var createdAt: Date
    var accountID: UUID?
}

struct RecurringObligationDTO: Sendable, Identifiable {
    let id: UUID
    var name: String
    var amountCents: Int
    var frequency: Frequency
    var customFrequencyDays: Int
    var nextDueDate: Date
    var category: String
    var isFixed: Bool
    var isActive: Bool
    var createdAt: Date
    var accountID: UUID?
}

struct LedgerEntryDTO: Sendable, Identifiable {
    let id: UUID
    var amountCents: Int
    var date: Date
    var note: String
    var category: String
    var entryType: EntryType
    var createdAt: Date
    var accountID: UUID?
}

struct ForecastSnapshotDTO: Sendable, Identifiable {
    let id: UUID
    var snapshotDate: Date
    var projectedBalanceCents: Int
    var horizonDays: Int
    var generatedAt: Date
    var scenarioID: UUID?
}

struct ScenarioDTO: Sendable, Identifiable {
    let id: UUID
    var name: String
    var scenarioDescription: String
    var createdAt: Date
    var isActive: Bool
}

struct ReminderPreferenceDTO: Sendable, Identifiable {
    let id: UUID
    var reminderType: ReminderType
    var daysBeforeEvent: Int
    var isEnabled: Bool
    var obligationID: UUID?
}

// MARK: - Repository Protocols

@MainActor
protocol UserProfileRepository: AnyObject {
    func fetchProfile() throws -> UserProfileDTO?
    func upsert(_ dto: UserProfileDTO) throws
}

@MainActor
protocol CashAccountRepository: AnyObject {
    func fetchAll() throws -> [CashAccountDTO]
    func fetchActive() throws -> [CashAccountDTO]
    func fetch(id: UUID) throws -> CashAccountDTO?
    func upsert(_ dto: CashAccountDTO) throws
    func delete(id: UUID) throws
}

@MainActor
protocol IncomeScheduleRepository: AnyObject {
    func fetchAll() throws -> [IncomeScheduleDTO]
    func fetchActive() throws -> [IncomeScheduleDTO]
    func upsert(_ dto: IncomeScheduleDTO) throws
    func delete(id: UUID) throws
}

@MainActor
protocol RecurringObligationRepository: AnyObject {
    func fetchAll() throws -> [RecurringObligationDTO]
    func fetchActive() throws -> [RecurringObligationDTO]
    func fetch(id: UUID) throws -> RecurringObligationDTO?
    func upsert(_ dto: RecurringObligationDTO) throws
    func delete(id: UUID) throws
}

@MainActor
protocol LedgerEntryRepository: AnyObject {
    func fetchAll() throws -> [LedgerEntryDTO]
    func fetchForAccount(id: UUID) throws -> [LedgerEntryDTO]
    func fetchInRange(from startDate: Date, to endDate: Date) throws -> [LedgerEntryDTO]
    func upsert(_ dto: LedgerEntryDTO) throws
    func delete(id: UUID) throws
}

@MainActor
protocol ForecastSnapshotRepository: AnyObject {
    func fetchLatest(limit: Int) throws -> [ForecastSnapshotDTO]
    func fetchForScenario(id: UUID) throws -> [ForecastSnapshotDTO]
    func insert(_ dto: ForecastSnapshotDTO) throws
    func deleteAll() throws
}

@MainActor
protocol ScenarioRepository: AnyObject {
    func fetchAll() throws -> [ScenarioDTO]
    func fetchActive() throws -> [ScenarioDTO]
    func upsert(_ dto: ScenarioDTO) throws
    func delete(id: UUID) throws
}

@MainActor
protocol ReminderPreferenceRepository: AnyObject {
    func fetchAll() throws -> [ReminderPreferenceDTO]
    func fetchEnabled() throws -> [ReminderPreferenceDTO]
    func upsert(_ dto: ReminderPreferenceDTO) throws
    func delete(id: UUID) throws
}
