//
//  MovieImageView.swift
//  Movies
//
//  Created by Anastasiia Spiridonova on 16.06.2023.
//

import SwiftUI

struct MovieImageView: View {
    let url: String
    @ObservedObject private var imageLoader = ImageLoader()
    
    var body: some View {
        Image(uiImage: imageLoader.image ?? UIImage(systemName: "photo")!)
            .resizable()
            .scaledToFit()
            .clipped()
            .onAppear {
                imageLoader.loadImage(from: url)
            }
    }
}

struct MovieImageView_Previews: PreviewProvider {
    static var previews: some View {
        MovieImageView(url: "imageURL")
    }
}
