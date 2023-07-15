//
//  AsynchImageViewer.swift
//  WeatherInfoApp
//
//  Created by dedeepya reddy salla on 29/06/23.
//

import SwiftUI

struct AsynchImageViewer: View {
    let imageUrlStr: String?
    @ObservedObject var imageLoader = ImageLoader()
    
    init(imageUrlStr: String) {
        self.imageUrlStr = imageUrlStr
        /*
         if imageLoader is declared as @Stateobject, getting below error
         err:
         Accessing StateObject's object without being installed on a View. This will create a new instance each time.
         */
        imageLoader.fetchImage(urlStr: imageUrlStr)
    }
    
    var body: some View {
        VStack {
            if let uiImage = imageLoader.uiImage {
                Image(uiImage: uiImage)
            } else {
                ProgressView()
            }
        }
        
        Button {
            imageLoader.fetchImage(urlStr: imageUrlStr ?? "")
        } label: {
            Text("calling again")
        }

    }
}

struct AsynchImageViewer_Previews: PreviewProvider {
    static let urlStr = "https://openweathermap.org/img/wn/02n@2x.png"
    static var previews: some View {
        AsynchImageViewer(imageUrlStr: urlStr)
    }
}


/*
 if url is not nil -- we display this view
 Then in its init - we call image api and till the data is received show progress bar
 */
