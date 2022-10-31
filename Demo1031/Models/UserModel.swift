//
//  UserModel.swift
//  Demo1031
//
//  Created by lean on 2022/10/31.
//

import Foundation

struct UserResponse: Codable{
    let data: Item
}
struct Item: Codable{
    let totalCount: Int?
    let items: [UserData]
}
struct UserData:Codable{
    let user: User
    let tags: [String]?
}
struct User: Codable{
    let nickName: String?
    let imageUrl: String?
}

