//
//  ContentView.swift
//  BankApp
//
//  Created by Davit on 4/07/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, World!")
            .onAppear {
                print("success")
                AccountService.shared.getAllAccounts { result in
                    switch result {
                    case .success(let accounts):
                        DispatchQueue.main.async {
                            print("Success: \(accounts!)")
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
