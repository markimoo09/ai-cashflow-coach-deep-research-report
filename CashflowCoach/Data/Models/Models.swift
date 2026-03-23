import Foundation
import SwiftData

// MARK: - UserProfile

@Model
final class UserProfile {
    @Attribute(.unique) var id: UUID
    var name: String
    var createdAt: Date
    var onboardingCompleted: Bool

    init(
        id: UUID = UUID(),
        name: String,
        createdAt: Date = .now,
        onboardingCompleted: Bool = false
    ) {
        self.id = id
        self.name = name
        self.createdAt = createdAt
        self.onboardingCompleted = onboardingCompleted
    }
}

// MARK: - CashAccount

@Model
final class CashAccount {
    @Attribute(.unique) var id: UUID
    var name: String
    var accountTypeRaw: String
    var balanceCents: Int
    var currencyCode: String
    var institution: String
    var isActive: Bool
    var createdAt: Date
    var sortOrder: Int

    @Relationship(deleteRule: .nullify, inverse: \LedgerEntry.account)
    var ledgerEntries: [LedgerEntry] = []

    init(
        id: UUID = UUID(),
        name: String,
        accountTypeRaw: String,
        balanceCents: Int = 0,
        currencyCode: String = "USD",
        institution: String = "",
        isActive: Bool = true,
        createdAt: Date = .now,
        sortOrder: Int = 0
    ) {
        self.id = id
        self.name = name
        self.accountTypeRaw = accountTypeRaw
        self.balanceCents = balanceCents
        self.currencyCode = currencyCode
        self.institution = institution
        self.isActive = isActive
        self.createdAt = createdAt
        self.sortOrder = sortOrder
    }
}

// MARK: - IncomeSchedule

@Model
final class IncomeSchedule {
    @Attribute(.unique) var id: UUID
    var name: String
    var amountCents: Int
    var frequencyRaw: String
    var customFrequencyDays: Int
    var nextPayDate: Date
    var isActive: Bool
    var createdAt: Date
    var accountID: UUID?

    init(
        id: UUID = UUID(),
        name: String,
        amountCents: Int,
        frequencyRaw: String = Frequency.monthly.rawValue,
        customFrequencyDays: Int = 0,
        nextPayDate: Date = .now,
        isActive: Bool = true,
        createdAt: Date = .now,
        accountID: UUID? = nil
    ) {
        self.id = id
        self.name = name
        self.amountCents = amountCents
        self.frequencyRaw = frequencyRaw
        self.customFrequencyDays = customFrequencyDays
        self.nextPayDate = nextPayDate
        self.isActive = isActive
        self.createdAt = createdAt
        self.accountID = accountID
    }
}

// MARK: - RecurringObligation

@Model
final class RecurringObligation {
    @Attribute(.unique) var id: UUID
    var name: String
    var amountCents: Int
    var frequencyRaw: String
    var customFrequencyDays: Int
    var nextDueDate: Date
    var category: String
    var isFixed: Bool
    var isActive: Bool
    var createdAt: Date
    var accountID: UUID?

    // swiftlint:disable:next function_body_length
    init(
        id: UUID = UUID(),
        name: String,
        amountCents: Int,
        frequencyRaw: String = Frequency.monthly.rawValue,
        customFrequencyDays: Int = 0,
        nextDueDate: Date = .now,
        category: String = "",
        isFixed: Bool = true,
        isActive: Bool = true,
        createdAt: Date = .now,
        accountID: UUID? = nil
    ) {
        self.id = id
        self.name = name
        self.amountCents = amountCents
        self.frequencyRaw = frequencyRaw
        self.customFrequencyDays = customFrequencyDays
        self.nextDueDate = nextDueDate
        self.category = category
        self.isFixed = isFixed
        self.isActive = isActive
        self.createdAt = createdAt
        self.accountID = accountID
    }
}

// MARK: - LedgerEntry

@Model
final class LedgerEntry {
    @Attribute(.unique) var id: UUID
    var amountCents: Int
    var date: Date
    var note: String
    var category: String
    var entryTypeRaw: String
    var createdAt: Date
    var account: CashAccount?

    init(
        id: UUID = UUID(),
        amountCents: Int,
        date: Date = .now,
        note: String = "",
        category: String = "",
        entryTypeRaw: String = EntryType.expense.rawValue,
        createdAt: Date = .now,
        account: CashAccount? = nil
    ) {
        self.id = id
        self.amountCents = amountCents
        self.date = date
        self.note = note
        self.category = category
        self.entryTypeRaw = entryTypeRaw
        self.createdAt = createdAt
        self.account = account
    }
}

// MARK: - ForecastSnapshot

@Model
final class ForecastSnapshot {
    @Attribute(.unique) var id: UUID
    var snapshotDate: Date
    var projectedBalanceCents: Int
    var horizonDays: Int
    var generatedAt: Date
    var scenarioID: UUID?

    init(
        id: UUID = UUID(),
        snapshotDate: Date = .now,
        projectedBalanceCents: Int,
        horizonDays: Int = 30,
        generatedAt: Date = .now,
        scenarioID: UUID? = nil
    ) {
        self.id = id
        self.snapshotDate = snapshotDate
        self.projectedBalanceCents = projectedBalanceCents
        self.horizonDays = horizonDays
        self.generatedAt = generatedAt
        self.scenarioID = scenarioID
    }
}

// MARK: - Scenario

@Model
final class Scenario {
    @Attribute(.unique) var id: UUID
    var name: String
    var scenarioDescription: String
    var createdAt: Date
    var isActive: Bool

    init(
        id: UUID = UUID(),
        name: String,
        scenarioDescription: String = "",
        createdAt: Date = .now,
        isActive: Bool = true
    ) {
        self.id = id
        self.name = name
        self.scenarioDescription = scenarioDescription
        self.createdAt = createdAt
        self.isActive = isActive
    }
}

// MARK: - ReminderPreference

@Model
final class ReminderPreference {
    @Attribute(.unique) var id: UUID
    var reminderTypeRaw: String
    var daysBeforeEvent: Int
    var isEnabled: Bool
    var obligationID: UUID?

    init(
        id: UUID = UUID(),
        reminderTypeRaw: String = ReminderType.paymentDue.rawValue,
        daysBeforeEvent: Int = 3,
        isEnabled: Bool = true,
        obligationID: UUID? = nil
    ) {
        self.id = id
        self.reminderTypeRaw = reminderTypeRaw
        self.daysBeforeEvent = daysBeforeEvent
        self.isEnabled = isEnabled
        self.obligationID = obligationID
    }
}
