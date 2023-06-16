import SwiftUI

struct PlaceholderImageView: View {
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.gray)
    }
}

struct PlaceholderImageView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderImageView()
    }
}
