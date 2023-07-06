//
//  AccountSummaryViewModel.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-07-05.
//

import Foundation

class AccountSummaryViewModel: ObservableObject {
    private var _accountsModels: [Account] = [Account]()
    @Published var accounts: [AccountViewModel] = [AccountViewModel]()

    var total: Double {
        self._accountsModels.map({$0.balance}).reduce(0, +)
    }

    func getAllAccounts() {
        AccountService.shared.getAllAccounts { result in
            switch result {
                case .success(let accounts):
                    if let accounts = accounts {
                        self._accountsModels = accounts

                        DispatchQueue.main.async {
                            self.accounts = accounts.map(AccountViewModel.init)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
            }
        }
    }
}

class AccountViewModel {
    let account: Account

    init(account: Account) {
        self.account = account
    }

    var name: String {
        self.account.name
    }

    var accountId: String {
        self.account.id
    }

    var accountType: String {
        self.account.accountType.title
    }

    var balance: String {
        self.account.balance.formatAsCurrency()
    }
}
