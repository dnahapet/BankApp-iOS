//
//  AccountService.swift
//  BankApp
//
//  Created by Davit Nahapetyan on 2023-07-04.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case badDecoding
    case noData
}

class AccountService {
    private init() {}

    static let shared = AccountService()

    func getAllAccounts(completion: @escaping (Result<[Account]?, NetworkError>) -> Void) {
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }

            if let accounts = try? JSONDecoder().decode([Account].self, from: data) {
                print("Accounts: \(accounts)")
                completion(.success(accounts))
            }
            else {
                print("Failure")
                completion(.failure(.badDecoding))
            }
        }.resume()
    }
}
