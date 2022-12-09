import Foundation

struct Response: Codable {
    let datas: Datas
}

struct Datas: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let username: String
    let password: String
}
