import Foundation

struct MovieDetails: Decodable {
    let image: String
    let meta: String
    let name: String
    let price: Int
    let rating: String
    let synopsis: String
}
