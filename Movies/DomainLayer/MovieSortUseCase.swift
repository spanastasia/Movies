import Foundation

enum MovieSortCriteria: String, CaseIterable {
    case none = "None"
    case price = "Price"
    case name = "Name"
}

class MovieSortUseCase: ObservableObject {
    func sortMovies(_ movies: [Movie], by criteria: MovieSortCriteria) -> [Movie] {
        switch criteria {
        case .none:
            return movies
        case .price:
            return movies.sorted { $0.price < $1.price }
        case .name:
            return movies.sorted { $0.name < $1.name }
        }
    }
}
