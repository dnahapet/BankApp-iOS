//
//  Account.swift
//  BankApp
//
//  Created by Davit Nahapetyan on 2023-07-04.
//

import Foundation

enum AccountType: String, Codable, CaseIterable {
    case checking
    case saving
}

extension AccountType {
    var title: String {
        switch self {
        case .checking:
            return "Checking"
        case .saving:
            return "Saving"
        }
    }
}

struct Account: Codable {
    let id: String
    let name: String
    let accountType: AccountType
    let balance: Double
}
