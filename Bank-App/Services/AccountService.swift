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

    func createAccount(createAccountRequest: CreateAccountRequest, completion: @escaping (Result<CreateAccountResponse, NetworkError>) -> Void) {

        guard let url = URL.urlForCreateAccounts() else {
            return completion(.failure(.badUrl))
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try? JSONEncoder().encode(createAccountRequest)

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }

            if let createAccountResponse = try? JSONDecoder().decode(CreateAccountResponse.self, from: data) {
                completion(.success(createAccountResponse))
            }
            else {
                completion(.failure(.badDecoding))
            }
        }.resume()
    }

    func getAllAccounts(completion: @escaping (Result<[Account]?, NetworkError>) -> Void) {
        guard let url = URL.urlForAccounts() else {
            return completion(.failure(.badUrl))
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }

            if let accounts = try? JSONDecoder().decode([Account].self, from: data) {
                completion(.success(accounts))
            }
            else {
                completion(.failure(.badDecoding))
            }
        }.resume()
    }
}
