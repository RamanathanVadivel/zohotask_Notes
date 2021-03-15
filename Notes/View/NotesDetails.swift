//
//  NotesDetails.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI

struct NotesDetails: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var notes : Notes
    var image: some View {
        if let nsData = notes.imagedata, let uiImage = UIImage(data: nsData as Data) {
            return AnyView(Image(uiImage: uiImage)
                            .resizable()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth/2)
            )
        }
        return AnyView(EmptyView())
    }
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView() {
                VStack(alignment: .leading) {
                    if notes.image != nil {
                        RemoteImage(url: notes.image!)
                            .frame(width: geometry.size.width, height: geometry.size.width * 0.5)
                    } else if notes.imagedata != nil {
                        image
                    }
                    VStack(alignment: .leading, spacing: CGFloat(14)) {
                        Text(notes.title ?? "")
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                        Text(formatDate(time: notes.time ?? ""))
                            .font(.body)
                            .foregroundColor(.gray)
                        Text(notes.body ?? "")
                            .font(.headline)
                            .foregroundColor(.white)
                        Spacer()
                    }.frame(width: geometry.size.width * 0.9, alignment: .leading)
                    .padding([.leading,.trailing], geometry.size.width * 0.05)
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("arrow")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 48, height: 48)
            })
        }
    }
}


