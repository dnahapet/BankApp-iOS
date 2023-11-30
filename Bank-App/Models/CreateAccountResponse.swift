//
//  CreateAccountResponse.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-11-30.
//

import Foundation

struct CreateAccountResponse: Codable {
    let result: Bool
    let error: NetworkError
}
