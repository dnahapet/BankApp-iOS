//
//  CreateAccountRequest.swift
//  Bank-App
//
//  Created by Davit Nahapetyan on 2023-11-30.
//

import Foundation

struct CreateAccountRequest: Codable {
    let name: String
    let accountType: String
    let balance: Double
}
