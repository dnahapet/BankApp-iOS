//
//  AddAccountViewModel.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-11-30.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    let name: String = ""
    let accountType: AccountType = .checking
    let balance: String = ""
    @Published var errorMessage: String = ""
}

extension AddAccountViewModel {
    private var isNameValid: Bool {
        !name.isEmpty
    }

    private var isBalanceValid: Bool {
        guard let accountBalance = Double(balance) else {
            return false
        }

        return accountBalance <= 0 ? false : true
    }

    func isValid() -> Bool {
        var errors = [String]()

        if !isNameValid {
            errors.append("Name is not found")
        }

        if !isBalanceValid {
            errors.append("Balance is not found")
        }

        if !errors.isEmpty {
            self.errorMessage = errors.joined(separator: "\n")
            return false
        }

        return true
    }
}

extension AddAccountViewModel {

    func createAccount(completion: @escaping (Bool) -> Void) {
        if !isValid() {
            return completion(false)
        }

        let createAccountReq = CreateAccountRequest(name: name, accountType: accountType.rawValue, balance: Double(balance)!)

        AccountService.shared.createAccount(createAccountRequest: createAccountReq) { result in
            
        }
    }
}
