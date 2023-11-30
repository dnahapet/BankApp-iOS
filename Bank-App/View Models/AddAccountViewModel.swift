//
//  AddAccountViewModel.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-11-30.
//

import Foundation

class AddAccountViewModel: ObservableObject {
    var name: String = ""
    var accountType: AccountType = .checking
    var balance: String = ""
    @Published var errorMessage: String = ""
}

extension AddAccountViewModel {
    private var isNameValid: Bool {
        !name.isEmpty
    }

    private var isBalanceValid: Bool {
        guard !balance.isEmpty, let accountBalance = Double(balance) else {
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
            DispatchQueue.main.async {
                self.errorMessage = errors.joined(separator: "\n")
            }
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
            switch result {
            case let .success(response):
                if response.result {
                    completion(true)
                }
                else {
                    DispatchQueue.main.async {
                        self.errorMessage = response.error
                    }
                    completion(false)
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                completion(false)
            }
        }
    }
}
