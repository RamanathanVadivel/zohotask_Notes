//
//  CreateNotesView.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI
import Foundation


struct CreateNotesView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var createNotesViewModel : CreateNotesViewModel
    @State private var titleField : String = "Title"
    @State private var bodyField : String = "Type Something..."
    @State private var dynamicTitleHeight : CGFloat = 50
    @State private var defaultTitleHeight : CGFloat = 50
    @State private var dynamicBodyHeight : CGFloat = 35
    @State private var defaultBodyHeight : CGFloat = 35
    @State private var isImageSelected : Bool = false
    @State private var isShowImagePicker : Bool = false
    @State var image : UIImage? = nil
    
    
    private func imagePickerDismissAction() {
        if (self.image != nil) {
            isImageSelected = true
        } else {
            isImageSelected = false
        }
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            MultilineTextField(K.titlePlaceholder, text: self.$titleField, dynamicHeight: self.$dynamicTitleHeight , defaultHeight: self.$defaultTitleHeight)
            MultilineTextField(K.bodyPlaceholder, text: self.$bodyField, dynamicHeight: self.$dynamicBodyHeight , defaultHeight: self.$defaultBodyHeight)
            Spacer()
        }
        .sheet(isPresented: self.$isShowImagePicker, onDismiss: self.imagePickerDismissAction) {
            ImagePicker(image: self.$image)
        }.padding().navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(K.backButton)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 48, height: 48)
            },trailing: HStack {
                Button(action: {
                    isShowImagePicker = true
                }){
                    Image(isImageSelected ? K.imageAttached : K.attachImage)
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                }
                Spacer()
                Button(action: {
                    let pickedImage = self.image?.jpegData(compressionQuality: 0.5)
                    let notes = NotesModel(id: UUID().uuidString, title: titleField, time: K.currentTime, body: bodyField, image: nil,imagedata: pickedImage)
                    createNotesViewModel.saveNotes(notes) {
                        self.presentationMode.wrappedValue.dismiss()                        
                    }
                }) {
                    Text(K.saveButton)
                        .foregroundColor(.white)
                        .frame(width: 72)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.init(hex: K.saveButtonBackgroundColor))
                                        .frame(width: 80, height: 48, alignment: .center)
                                        .cornerRadius(15)
                        )
                        .foregroundColor(.gray)
                }
            })
    }
}

