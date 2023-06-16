import SwiftUI

class MovieDetailsData: ObservableObject {
    @Published var movieDetails: MovieDetails?
    
    func fetchMovieDetails(movieID: String) {
        let movieDetailsURLString = "https://us-central1-temporary-692af.cloudfunctions.net/movieDetails?id=\(movieID)"
        
        guard let movieDetailsURL = URL(string: movieDetailsURLString) else {
            print("Invalid URL")
            return
        }
        
        let networkManager = NetworkManager()
        networkManager.fetchData(from: movieDetailsURL) { [weak self] (result: Result<MovieDetails, NetworkError>) in
            switch result {
            case .success(let details):
                DispatchQueue.main.async {
                    self?.movieDetails = details
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
