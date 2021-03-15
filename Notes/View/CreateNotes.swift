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
    @State private var dynamicTitleHeight : CGFloat = 100
    @State private var defaultTitleHeight : CGFloat = 100
    @State private var dynamicBodyHeight : CGFloat = 35
    @State private var defaultBodyHeight : CGFloat = 35
    @State private var isImageSelected : Bool = false
    @State private var isShowImagePicker : Bool = false
    @State var image : UIImage? = nil
    
    
    func imagePickerDismissAction() {
        if (self.image != nil) {
            isImageSelected = true
        } else {
            isImageSelected = false
        }
    }
    
    func saveInspectionDamageImage(image: UIImage, filePath : URL) {
        let data = image.jpegData(compressionQuality: 0.05) ?? image.pngData()
        
        DispatchQueue.global(qos: .background).async {
            try? data?.write(to: URL(fileURLWithPath: filePath.path))
        }
    }
    
    var body: some View {
        VStack(alignment:.leading, spacing: 10) {
            MultilineTextField("Title", text: self.$titleField, dynamicHeight: self.$dynamicTitleHeight , defaultHeight: self.$defaultTitleHeight)
            MultilineTextField("Type Something...", text: self.$bodyField, dynamicHeight: self.$dynamicBodyHeight , defaultHeight: self.$defaultBodyHeight)
            Spacer()
        }
        .sheet(isPresented: self.$isShowImagePicker, onDismiss: self.imagePickerDismissAction) {
            ImagePicker(image: self.$image)
        }.padding().navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image("arrow")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 48, height: 48)
            },trailing: HStack {
                Button(action: {
                    isShowImagePicker = true
                }){
                    Image(isImageSelected ? "attachImage_green" : "attachImage_black")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 48, height: 48)
                        .padding(.trailing)
                }
                Spacer()
                Button(action: {
                    let pickedImage = self.image?.jpegData(compressionQuality: 0.5)
                    let notes = NotesModel(id: UUID().uuidString, title: titleField, time: "\(Date().timeIntervalSince1970)", body: bodyField, image: nil,imagedata: pickedImage)
                    CoreDataManager.shared.saveNotes(notesModelArray: [notes])
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save")
                        .foregroundColor(.white)
                        .frame(width: 72)
                        .background(RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(Color.init(hex: "#3B3B3B"))
                                        .frame(width: 80, height: 48, alignment: .center)
                                        .cornerRadius(15)
                        )
                        .foregroundColor(.gray)
                }
            })
    }
}

