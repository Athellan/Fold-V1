//
//  UserModel.swift
//  Fold V1
//
//  Created by JB on 05/12/2022.
//

import Foundation

struct Response: Codable {
    let datas: Datas
}

struct Datas: Codable {
    let user: User
}

struct User: Codable {
    let _id: Int
    let username: String
    let password: String
}
