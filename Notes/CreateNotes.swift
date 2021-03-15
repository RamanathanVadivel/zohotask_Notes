//
//  CreateNotes.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI
import Foundation

struct CreateNotes: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var titleField : String = "Title"
    @State private var bodyField : String = "Type Something..."
    @State var dynamicTitleHeight : CGFloat = 100
    @State var defaultTitleHeight : CGFloat = 100
    @State var dynamicBodyHeight : CGFloat = 35
    @State var defaultBodyHeight : CGFloat = 35
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            MultilineTextField("Title", text: self.$titleField, dynamicHeight: self.$dynamicTitleHeight , defaultHeight: self.$defaultTitleHeight)
            MultilineTextField("Type Something...", text: self.$bodyField, dynamicHeight: self.$dynamicBodyHeight , defaultHeight: self.$defaultBodyHeight)
            Spacer()
        }.padding().navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .background(RoundedRectangle(cornerRadius: 6).frame(width: 32, height: 32, alignment: .center)
                                    .cornerRadius(3))
                    .foregroundColor(.gray)
                    .padding()
            },trailing: HStack {
                Image(systemName: "paperclip")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .background(RoundedRectangle(cornerRadius: 6).frame(width: 32, height: 32, alignment: .center)
                                    .cornerRadius(3))
                    .foregroundColor(.gray)
                    .padding()
                Spacer()
                Button(action: {
                    let notes = NotesModel(id: "19", title: titleField, time: "\(Date().timeIntervalSince1970)", body: bodyField, image: nil)
                    CoreDataManager.shared.saveNotes(notesModelArray: [notes])
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(width: 72)
                        .background(RoundedRectangle(cornerRadius: 6).frame(width: 96, height: 32, alignment: .center)
                                        .cornerRadius(15))
                        .foregroundColor(.gray)
                        .padding()
                }
            })
    }
}

