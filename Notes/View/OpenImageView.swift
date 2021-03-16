//
//  OpenImageView.swift
//  Notes
//
//  Created by Mac HD on 16/03/21.
//

import SwiftUI

struct OpenImageView: View {
    @Environment(\.presentationMode) var presentationMode : Binding<PresentationMode>
    @State var urlString: String?
    @State var imageData : Data?
    var image: some View {
        if let nsData = imageData, let uiImage = UIImage(data: nsData as Data) {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
            )
        }
        return AnyView(EmptyView())
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if urlString != nil {
                RemoteImage(url: urlString!)
                    .scaledToFit()
            } else {
                image
                    .scaledToFit()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(K.backButton)
                .renderingMode(.original)
                .resizable()
                .frame(width: 48, height: 48)
        })
        
    }
}
