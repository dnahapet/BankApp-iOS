//
//  AccountSummaryScreen.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-07-05.
//

import SwiftUI

struct AccountSummaryScreen: View {
    @ObservedObject var accountSummaryVM: AccountSummaryViewModel = AccountSummaryViewModel()

    var body: some View {
        VStack {
            GeometryReader { g in
                VStack {
                    AccountListView(accounts: self.accountSummaryVM.accounts)
                        .frame(height: g.size.height/2)
                    Text("\(self.accountSummaryVM.total.formatAsCurrency())")
                    Spacer()
                }
            }
        }
        .onAppear {
            self.accountSummaryVM.getAllAccounts()
        }
        .navigationTitle("Account Summary")
        .embedInNavigationView()
    }
}

struct AccountSummaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AccountSummaryScreen()
    }
}
