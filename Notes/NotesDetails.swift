//
//  NotesDetails.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI

extension Image {
    func data(url: URL) ->  Self {
        if let data = try? Data(contentsOf:url){
            return Image(uiImage:UIImage(data:data)!)
                .resizable()
        }
        return self
            .resizable()
    }
}

func formatDate(time: String) -> String {
    let date = Date(timeIntervalSince1970: Double(time)!)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd,yyyy"
    return dateFormatter.string(from: date)
}

struct NotesDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var notes : Notes
    

    
    var body: some View {
        GeometryReader { geometry in
        ScrollView() {
            VStack(alignment: .leading) {
                if notes.image != nil {
                    Image("person.fill")
                        .data(url: URL(fileURLWithPath: notes.image!))
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width)
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
                }.frame(width: geometry.size.width * 0.9, alignment: .center)
                .padding([.leading,.trailing], geometry.size.width * 0.05)
            }
        }.navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .resizable()
                .renderingMode(.original)
                .aspectRatio(contentMode: .fit)
                .background(RoundedRectangle(cornerRadius: 6).frame(width: 32, height: 32, alignment: .center).cornerRadius(3))
                .foregroundColor(.gray)
                .padding()
        })
        }
    }
}


