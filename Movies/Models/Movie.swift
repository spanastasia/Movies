import Foundation

struct Movie: Identifiable, Decodable {
    let id: String
    let name: String
    let price: Int
}
