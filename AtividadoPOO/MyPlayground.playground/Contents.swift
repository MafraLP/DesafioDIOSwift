import UIKit

enum AccountType {
    case current
    case saving
}

class BankAccount {
    var balance: Double
    var number: Int
    var type: AccountType
    var transactionHistory: [String]
    
    init(number: Int, openingBalance: Double, type: AccountType) {
        self.number = number
        self.balance = openingBalance
        self.type = type
        self.transactionHistory = []
    }
    
    func deposit(value: Double) {
        balance += value
        transactionHistory.append("Depósito de \(value)")
    }
    
    func withdraw(value: Double) {
        if value <= balance {
            balance -= value
            transactionHistory.append("Saque de \(value)")
        } else {
            transactionHistory.append("Tentativa de saque de \(value) - saldo insuficiente")
        }
    }
    
    
    func filterTransactions(predicate: (String) -> Bool) -> [String] {
        return transactionHistory.filter(predicate)
    }
}


struct Bank {
    var accounts: [BankAccount] = []
    
    mutating func addAccount(_ account: BankAccount) {
        accounts.append(account)
    }
    
    func transferAsync(from account1: inout BankAccount, to account2: inout BankAccount, value: Double) async -> Bool {
        if account1.balance >= value {
            account1.withdraw(value: value)
            account2.deposit(value: value)
            return true
        } else {
            return false
        }
    }
}


var acc1 = BankAccount(number: 1, openingBalance: 900.0, type: .current)
acc1.deposit(value: 500.0)
acc1.withdraw(value: 200.0)

let transactions = acc1.filterTransactions { $0.contains("Saque") }
print("Transações de saque: \(transactions)")



var acc2 = BankAccount(number: 2, openingBalance: 2000.0, type: .saving)
var bank = Bank()
bank.addAccount(acc1)
bank.addAccount(acc2)

Task {
    let success = await bank.transferAsync(from: &acc1, to: &acc2, value: 300)
    if success {
       print("Transferência concluída com sucesso")
    } else {
       print("Transferência não foi concluída")
    }
}

acc1.balance
