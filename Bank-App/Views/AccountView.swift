//
//  AccountView.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-07-05.
//

import SwiftUI

struct AccountView: View {
    let accounts: [AccountViewModel]

    var body: some View {
        List(self.accounts, id:\.accountId) { account in
            AccountCell(account: account)
        }
    }
}

struct AccountCell: View {
    let account: AccountViewModel

    var body: some View {
        HStack {
            VStack (alignment: .leading) {
                Text(self.account.name)
                    .font(.title)
                Text(self.account.accountType)
                    .opacity(0.5)
            }
            Spacer()
            Text(self.account.balance)
                .foregroundColor(.green)
        }
    }
}
