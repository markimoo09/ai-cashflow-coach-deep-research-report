import Foundation

// MARK: - CashflowCore Domain Layer
//
// This module owns business logic that is independent of any framework.
// No UIKit / SwiftUI imports belong here.
//
// Namespace: CashflowCore (folder boundary; expand into a local Swift package
// once the domain grows beyond a handful of types).

/// Placeholder domain type — replace with real models as domain is modelled.
struct Transaction: Identifiable, Sendable {
    let id: UUID
    let amount: Decimal
    let date: Date
    let note: String
}
