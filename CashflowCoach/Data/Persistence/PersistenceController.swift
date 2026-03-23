import Foundation
import SwiftData

// MARK: - Versioned Schema

enum AppSchema {
    enum V1: VersionedSchema {
        static var versionIdentifier: Schema.Version { .init(1, 0, 0) }

        static var models: [any PersistentModel.Type] {
            [
                UserProfile.self,
                CashAccount.self,
                IncomeSchedule.self,
                RecurringObligation.self,
                LedgerEntry.self,
                ForecastSnapshot.self,
                Scenario.self,
                ReminderPreference.self,
            ]
        }
    }
}

// MARK: - Migration Plan

enum AppMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] { [AppSchema.V1.self] }
    static var stages: [MigrationStage] { [] }
}

// MARK: - Container Factory

enum PersistenceController {
    static func makeContainer() throws -> ModelContainer {
        let schema = Schema(versionedSchema: AppSchema.V1.self)
        return try ModelContainer(
            for: schema,
            migrationPlan: AppMigrationPlan.self,
            configurations: ModelConfiguration(schema: schema)
        )
    }

    static func makeInMemoryContainer() throws -> ModelContainer {
        let schema = Schema(versionedSchema: AppSchema.V1.self)
        let config = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )
        return try ModelContainer(
            for: schema,
            migrationPlan: AppMigrationPlan.self,
            configurations: config
        )
    }
}
