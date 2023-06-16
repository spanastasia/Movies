import SwiftUI

class MovieData: ObservableObject {
    @Published var movies: [Movie] = []
    
    func fetchMovies() {
        let moviesURL = URL(string: "https://us-central1-temporary-692af.cloudfunctions.net/movies")!
        let networkManager = NetworkManager()
        
        networkManager.fetchData(from: moviesURL) { [weak self] (result: Result<[Movie], NetworkError>) in
            switch result {
            case .success(let movies):
                DispatchQueue.main.async {
                    self?.movies = movies
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
