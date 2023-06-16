import Foundation

enum MovieFilterCriteria: Hashable {
    case all
    case priceLessThan(Int)
    case priceGreaterThanEqual(Int)
    // Add more filtering options as needed
}

class MovieFilterUseCase: ObservableObject {
    func filterMovies(_ movies: [Movie], with criteria: MovieFilterCriteria) -> [Movie] {
        var filteredMovies = movies

        switch criteria {
        case .all:
            // No filtering required, return all movies
            break
        case .priceLessThan(let price):
            filteredMovies = filteredMovies.filter { $0.price < price }
        case .priceGreaterThanEqual(let price):
            filteredMovies = filteredMovies.filter { $0.price >= price }
        // Add more filtering options as needed
        }

        return filteredMovies
    }
}
