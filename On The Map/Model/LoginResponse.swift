//
//  LoginResponse.swift
//  On The Map
//
//  Created by Simon Wells on 2020/8/11.
//  Copyright © 2020 Simon Wells. All rights reserved.
//

import Foundation

struct SessionResponse: Codable {
    let account: Account
    let session: Session

enum CodingKeys: String, CodingKey {
    case account
    case session
}

struct Account: Codable {
    let registered: Bool
    let key: String
}

    struct Session: Codable {
        let id: String
        let expiration: String
}
}
