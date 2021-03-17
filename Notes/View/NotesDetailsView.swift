//
//  NotesDetailsView.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI


struct NotesDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var notes : Notes
    var image: some View {
        if let nsData = notes.imagedata, let uiImage = UIImage(data: nsData as Data) {
            return AnyView(Image(uiImage: uiImage)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth/2)
            )
        }
        return AnyView(EmptyView())
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                if notes.image != nil {
                    NavigationLink(destination: OpenImageView(urlString: notes.image!)) {
                        RemoteImage(url: notes.image!)
                    }
                    .animation(Animation.easeInOut(duration: 3.0))
                    .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth/2)
                } else if notes.imagedata != nil {
                    NavigationLink(destination: OpenImageView(imageData: notes.imagedata)) {
                        image
                    }
                    .animation(Animation.easeInOut(duration: 3.0))
                }
                VStack(alignment: .leading, spacing: CGFloat(20)) {
                    Text(notes.title ?? K.defaultTitle)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .fixedSize(horizontal: false, vertical: true)
                        .lineSpacing(2)
                    Text(formatDate(time: notes.time ?? K.currentTime))
                        .font(.headline)
                        .foregroundColor(.gray)
                    Text(notes.body ?? K.defaultBody)
                        .font(.headline)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.white)
                        .lineSpacing(8)
                    
                    Spacer()
                }.frame(width: UIScreen.screenWidth * 0.9, alignment: .leading)
                .padding([.leading,.trailing], UIScreen.screenWidth * 0.05)
            }
        }.navigationBarBackButtonHidden(true)
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


