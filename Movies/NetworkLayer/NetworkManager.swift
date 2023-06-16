import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class NetworkManager {
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed))
                print("Request failed with error: \(error)")
                return
            }
            
            guard let data = data else {
                completion(.failure(.requestFailed))
                print("No data received")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingFailed))
                print("Decoding failed with error: \(error)")
            }
        }.resume()
    }
}
