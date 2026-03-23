import Foundation
import SwiftData

// MARK: - DTO Mappers

extension UserProfile {
    func toDTO() -> UserProfileDTO {
        .init(id: id, name: name, createdAt: createdAt, onboardingCompleted: onboardingCompleted)
    }

    func apply(_ dto: UserProfileDTO) {
        name = dto.name
        onboardingCompleted = dto.onboardingCompleted
    }
}

extension CashAccount {
    func toDTO() -> CashAccountDTO {
        .init(
            id: id,
            name: name,
            accountType: AccountType(rawValue: accountTypeRaw) ?? .checking,
            balanceCents: balanceCents,
            currencyCode: currencyCode,
            institution: institution,
            isActive: isActive,
            createdAt: createdAt,
            sortOrder: sortOrder
        )
    }

    func apply(_ dto: CashAccountDTO) {
        name = dto.name
        accountTypeRaw = dto.accountType.rawValue
        balanceCents = dto.balanceCents
        currencyCode = dto.currencyCode
        institution = dto.institution
        isActive = dto.isActive
        sortOrder = dto.sortOrder
    }

    static func from(_ dto: CashAccountDTO) -> CashAccount {
        .init(
            id: dto.id,
            name: dto.name,
            accountTypeRaw: dto.accountType.rawValue,
            balanceCents: dto.balanceCents,
            currencyCode: dto.currencyCode,
            institution: dto.institution,
            isActive: dto.isActive,
            createdAt: dto.createdAt,
            sortOrder: dto.sortOrder
        )
    }
}

extension IncomeSchedule {
    func toDTO() -> IncomeScheduleDTO {
        .init(
            id: id,
            name: name,
            amountCents: amountCents,
            frequency: Frequency(rawValue: frequencyRaw) ?? .monthly,
            customFrequencyDays: customFrequencyDays,
            nextPayDate: nextPayDate,
            isActive: isActive,
            createdAt: createdAt,
            accountID: accountID
        )
    }

    func apply(_ dto: IncomeScheduleDTO) {
        name = dto.name
        amountCents = dto.amountCents
        frequencyRaw = dto.frequency.rawValue
        customFrequencyDays = dto.customFrequencyDays
        nextPayDate = dto.nextPayDate
        isActive = dto.isActive
        accountID = dto.accountID
    }

    static func from(_ dto: IncomeScheduleDTO) -> IncomeSchedule {
        .init(
            id: dto.id,
            name: dto.name,
            amountCents: dto.amountCents,
            frequencyRaw: dto.frequency.rawValue,
            customFrequencyDays: dto.customFrequencyDays,
            nextPayDate: dto.nextPayDate,
            isActive: dto.isActive,
            createdAt: dto.createdAt,
            accountID: dto.accountID
        )
    }
}

extension RecurringObligation {
    func toDTO() -> RecurringObligationDTO {
        .init(
            id: id,
            name: name,
            amountCents: amountCents,
            frequency: Frequency(rawValue: frequencyRaw) ?? .monthly,
            customFrequencyDays: customFrequencyDays,
            nextDueDate: nextDueDate,
            category: category,
            isFixed: isFixed,
            isActive: isActive,
            createdAt: createdAt,
            accountID: accountID
        )
    }

    func apply(_ dto: RecurringObligationDTO) {
        name = dto.name
        amountCents = dto.amountCents
        frequencyRaw = dto.frequency.rawValue
        customFrequencyDays = dto.customFrequencyDays
        nextDueDate = dto.nextDueDate
        category = dto.category
        isFixed = dto.isFixed
        isActive = dto.isActive
        accountID = dto.accountID
    }

    static func from(_ dto: RecurringObligationDTO) -> RecurringObligation {
        .init(
            id: dto.id,
            name: dto.name,
            amountCents: dto.amountCents,
            frequencyRaw: dto.frequency.rawValue,
            customFrequencyDays: dto.customFrequencyDays,
            nextDueDate: dto.nextDueDate,
            category: dto.category,
            isFixed: dto.isFixed,
            isActive: dto.isActive,
            createdAt: dto.createdAt,
            accountID: dto.accountID
        )
    }
}

extension LedgerEntry {
    func toDTO() -> LedgerEntryDTO {
        .init(
            id: id,
            amountCents: amountCents,
            date: date,
            note: note,
            category: category,
            entryType: EntryType(rawValue: entryTypeRaw) ?? .expense,
            createdAt: createdAt,
            accountID: account?.id
        )
    }

    func apply(_ dto: LedgerEntryDTO) {
        amountCents = dto.amountCents
        date = dto.date
        note = dto.note
        category = dto.category
        entryTypeRaw = dto.entryType.rawValue
    }

    static func from(_ dto: LedgerEntryDTO) -> LedgerEntry {
        .init(
            id: dto.id,
            amountCents: dto.amountCents,
            date: dto.date,
            note: dto.note,
            category: dto.category,
            entryTypeRaw: dto.entryType.rawValue,
            createdAt: dto.createdAt
        )
    }
}

extension ForecastSnapshot {
    func toDTO() -> ForecastSnapshotDTO {
        .init(
            id: id,
            snapshotDate: snapshotDate,
            projectedBalanceCents: projectedBalanceCents,
            horizonDays: horizonDays,
            generatedAt: generatedAt,
            scenarioID: scenarioID
        )
    }

    static func from(_ dto: ForecastSnapshotDTO) -> ForecastSnapshot {
        .init(
            id: dto.id,
            snapshotDate: dto.snapshotDate,
            projectedBalanceCents: dto.projectedBalanceCents,
            horizonDays: dto.horizonDays,
            generatedAt: dto.generatedAt,
            scenarioID: dto.scenarioID
        )
    }
}

extension Scenario {
    func toDTO() -> ScenarioDTO {
        .init(id: id, name: name, scenarioDescription: scenarioDescription, createdAt: createdAt, isActive: isActive)
    }

    func apply(_ dto: ScenarioDTO) {
        name = dto.name
        scenarioDescription = dto.scenarioDescription
        isActive = dto.isActive
    }

    static func from(_ dto: ScenarioDTO) -> Scenario {
        .init(id: dto.id, name: dto.name, scenarioDescription: dto.scenarioDescription,
              createdAt: dto.createdAt, isActive: dto.isActive)
    }
}

extension ReminderPreference {
    func toDTO() -> ReminderPreferenceDTO {
        .init(
            id: id,
            reminderType: ReminderType(rawValue: reminderTypeRaw) ?? .paymentDue,
            daysBeforeEvent: daysBeforeEvent,
            isEnabled: isEnabled,
            obligationID: obligationID
        )
    }

    func apply(_ dto: ReminderPreferenceDTO) {
        reminderTypeRaw = dto.reminderType.rawValue
        daysBeforeEvent = dto.daysBeforeEvent
        isEnabled = dto.isEnabled
        obligationID = dto.obligationID
    }

    static func from(_ dto: ReminderPreferenceDTO) -> ReminderPreference {
        .init(
            id: dto.id,
            reminderTypeRaw: dto.reminderType.rawValue,
            daysBeforeEvent: dto.daysBeforeEvent,
            isEnabled: dto.isEnabled,
            obligationID: dto.obligationID
        )
    }
}

// MARK: - UserProfile Repository

@MainActor
final class SwiftDataUserProfileRepository: UserProfileRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchProfile() throws -> UserProfileDTO? {
        try context.fetch(FetchDescriptor<UserProfile>()).first?.toDTO()
    }

    func upsert(_ dto: UserProfileDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<UserProfile>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(UserProfile(id: dto.id, name: dto.name,
                                       createdAt: dto.createdAt, onboardingCompleted: dto.onboardingCompleted))
        }
        try context.save()
    }
}

// MARK: - CashAccount Repository

@MainActor
final class SwiftDataCashAccountRepository: CashAccountRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [CashAccountDTO] {
        let descriptor = FetchDescriptor<CashAccount>(sortBy: [SortDescriptor(\.sortOrder)])
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchActive() throws -> [CashAccountDTO] {
        let descriptor = FetchDescriptor<CashAccount>(
            predicate: #Predicate { $0.isActive },
            sortBy: [SortDescriptor(\.sortOrder)]
        )
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetch(id: UUID) throws -> CashAccountDTO? {
        let descriptor = FetchDescriptor<CashAccount>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first?.toDTO()
    }

    func upsert(_ dto: CashAccountDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<CashAccount>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(CashAccount.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let descriptor = FetchDescriptor<CashAccount>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}

// MARK: - IncomeSchedule Repository

@MainActor
final class SwiftDataIncomeScheduleRepository: IncomeScheduleRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [IncomeScheduleDTO] {
        let descriptor = FetchDescriptor<IncomeSchedule>(sortBy: [SortDescriptor(\.name)])
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchActive() throws -> [IncomeScheduleDTO] {
        let descriptor = FetchDescriptor<IncomeSchedule>(predicate: #Predicate { $0.isActive })
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func upsert(_ dto: IncomeScheduleDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<IncomeSchedule>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(IncomeSchedule.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let id = id
        let descriptor = FetchDescriptor<IncomeSchedule>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}

// MARK: - RecurringObligation Repository

@MainActor
final class SwiftDataRecurringObligationRepository: RecurringObligationRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [RecurringObligationDTO] {
        let descriptor = FetchDescriptor<RecurringObligation>(sortBy: [SortDescriptor(\.nextDueDate)])
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchActive() throws -> [RecurringObligationDTO] {
        let descriptor = FetchDescriptor<RecurringObligation>(predicate: #Predicate { $0.isActive })
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetch(id: UUID) throws -> RecurringObligationDTO? {
        let descriptor = FetchDescriptor<RecurringObligation>(predicate: #Predicate { $0.id == id })
        return try context.fetch(descriptor).first?.toDTO()
    }

    func upsert(_ dto: RecurringObligationDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<RecurringObligation>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(RecurringObligation.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let id = id
        let descriptor = FetchDescriptor<RecurringObligation>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}

// MARK: - LedgerEntry Repository

@MainActor
final class SwiftDataLedgerEntryRepository: LedgerEntryRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [LedgerEntryDTO] {
        let descriptor = FetchDescriptor<LedgerEntry>(sortBy: [SortDescriptor(\.date, order: .reverse)])
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchForAccount(id accountID: UUID) throws -> [LedgerEntryDTO] {
        let descriptor = FetchDescriptor<LedgerEntry>(
            predicate: #Predicate { $0.account?.id == accountID },
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchInRange(from startDate: Date, to endDate: Date) throws -> [LedgerEntryDTO] {
        let descriptor = FetchDescriptor<LedgerEntry>(
            predicate: #Predicate { $0.date >= startDate && $0.date <= endDate },
            sortBy: [SortDescriptor(\.date)]
        )
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func upsert(_ dto: LedgerEntryDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<LedgerEntry>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(LedgerEntry.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let id = id
        let descriptor = FetchDescriptor<LedgerEntry>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}

// MARK: - ForecastSnapshot Repository

@MainActor
final class SwiftDataForecastSnapshotRepository: ForecastSnapshotRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchLatest(limit: Int) throws -> [ForecastSnapshotDTO] {
        var descriptor = FetchDescriptor<ForecastSnapshot>(
            sortBy: [SortDescriptor(\.generatedAt, order: .reverse)]
        )
        descriptor.fetchLimit = limit
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchForScenario(id scenarioID: UUID) throws -> [ForecastSnapshotDTO] {
        let descriptor = FetchDescriptor<ForecastSnapshot>(
            predicate: #Predicate { $0.scenarioID == scenarioID }
        )
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func insert(_ dto: ForecastSnapshotDTO) throws {
        context.insert(ForecastSnapshot.from(dto))
        try context.save()
    }

    func deleteAll() throws {
        try context.delete(model: ForecastSnapshot.self)
        try context.save()
    }
}

// MARK: - Scenario Repository

@MainActor
final class SwiftDataScenarioRepository: ScenarioRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [ScenarioDTO] {
        let descriptor = FetchDescriptor<Scenario>(sortBy: [SortDescriptor(\.createdAt, order: .reverse)])
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func fetchActive() throws -> [ScenarioDTO] {
        let descriptor = FetchDescriptor<Scenario>(predicate: #Predicate { $0.isActive })
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func upsert(_ dto: ScenarioDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<Scenario>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(Scenario.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let id = id
        let descriptor = FetchDescriptor<Scenario>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}

// MARK: - ReminderPreference Repository

@MainActor
final class SwiftDataReminderPreferenceRepository: ReminderPreferenceRepository {
    private let context: ModelContext

    init(context: ModelContext) { self.context = context }

    func fetchAll() throws -> [ReminderPreferenceDTO] {
        try context.fetch(FetchDescriptor<ReminderPreference>()).map { $0.toDTO() }
    }

    func fetchEnabled() throws -> [ReminderPreferenceDTO] {
        let descriptor = FetchDescriptor<ReminderPreference>(predicate: #Predicate { $0.isEnabled })
        return try context.fetch(descriptor).map { $0.toDTO() }
    }

    func upsert(_ dto: ReminderPreferenceDTO) throws {
        let id = dto.id
        let descriptor = FetchDescriptor<ReminderPreference>(predicate: #Predicate { $0.id == id })
        if let existing = try context.fetch(descriptor).first {
            existing.apply(dto)
        } else {
            context.insert(ReminderPreference.from(dto))
        }
        try context.save()
    }

    func delete(id: UUID) throws {
        let id = id
        let descriptor = FetchDescriptor<ReminderPreference>(predicate: #Predicate { $0.id == id })
        if let model = try context.fetch(descriptor).first {
            context.delete(model)
            try context.save()
        }
    }
}
