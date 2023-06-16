import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    func loadImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                print("Failed to load image: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            DispatchQueue.main.async { [weak self] in
                self?.image = UIImage(data: data)
            }
        }.resume()
    }
}
