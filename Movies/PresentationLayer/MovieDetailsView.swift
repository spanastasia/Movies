import SwiftUI

struct MovieDetailsView: View {
    let movie: Movie
    @ObservedObject var movieDetailsData = MovieDetailsData()
    
    var body: some View {
        VStack(spacing: 16) {
            if let imageURL = movieDetailsData.movieDetails?.image {
                MovieImageView(url: imageURL)
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
            } else {
                PlaceholderImageView()
                    .frame(height: 200)
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(movie.name)
                    .font(.title)
                    .bold()
                
                Text("Price: $\(movie.price)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                ScrollView {
                    Text(movieDetailsData.movieDetails?.synopsis ?? "")
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal)
                }
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            movieDetailsData.fetchMovieDetails(movieID: movie.id)
        }
        .navigationTitle("Movie Details")
    }
}
