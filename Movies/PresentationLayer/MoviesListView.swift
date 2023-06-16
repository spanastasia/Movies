import SwiftUI

struct MoviesListView: View {
    @ObservedObject var movieData = MovieData()
    @State private var selectedMovie: Movie?
    
    @State private var selectedFilter: MovieFilterCriteria = .all
    @State private var selectedSort: MovieSortCriteria = .none
    
    private var filteredMovies: [Movie] {
        var filteredMovies = movieData.movies
        
        // Apply filtering based on the selected filter option
        filteredMovies = movieFilterUseCase.filterMovies(filteredMovies, with: selectedFilter)
        
        // Apply sorting based on the selected sort option
        filteredMovies = movieSortUseCase.sortMovies(filteredMovies, by: selectedSort)
        
        return filteredMovies
    }
    
    // Inject the MovieFilterUseCase and MovieSortUseCase
    @StateObject private var movieFilterUseCase = MovieFilterUseCase()
    @StateObject private var movieSortUseCase = MovieSortUseCase()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Filter", selection: $selectedFilter) {
                    Text("All").tag(MovieFilterCriteria.all)
                    Text("Price < $500").tag(MovieFilterCriteria.priceLessThan(500))
                    Text("Price >= $500").tag(MovieFilterCriteria.priceGreaterThanEqual(500))
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                
                Picker("Sort", selection: $selectedSort) {
                    Text("None").tag(MovieSortCriteria.none)
                    Text("Price").tag(MovieSortCriteria.price)
                    Text("Name").tag(MovieSortCriteria.name)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal)
                List(filteredMovies) { movie in
                    Button(action: {
                        selectedMovie = movie
                    }) {
                        HStack {
                            Text(movie.name)
                            Spacer()
                            Text("Price: $\(movie.price)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .navigationTitle("Movies Shop")
                .sheet(item: $selectedMovie) { movie in
                    MovieDetailsView(movie: movie)
                }
            }
        }
        .onAppear {
            movieData.fetchMovies()
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
