import Foundation
import Testing
@testable import CashflowCoach

@Suite("CashflowCoach placeholder tests")
struct CashflowCoachTests {
    @Test("Transaction initialises with expected values")
    func transactionInit() {
        let id = UUID()
        let tx = Transaction(id: id, amount: 42.00, date: .now, note: "coffee")
        #expect(tx.id == id)
        #expect(tx.amount == 42.00)
        #expect(tx.note == "coffee")
    }
}
