//
//  ContentView.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI
import UIKit
import ChameleonFramework

struct ContentView: View {
    
    @ObservedObject var contentViewModel : ContentViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing : 0){
                        ForEach(contentViewModel.notes, id:\.id) { note in
                            NavigationLink(destination: NotesDetailsView(notes: note)) {
                                VStack(alignment: .leading){
                                    Text(note.title ?? "")
                                        .font(.headline)
                                        .foregroundColor(Color.black)
                                        .padding([.horizontal,.top])
                                        .frame(width: note.image != nil || note.imagedata != nil ? UIScreen.screenWidth * 0.9 : UIScreen.screenWidth * 0.4, alignment: .leading)
                                    Text(formatDate(time: note.time ?? ""))
                                        .font(.body)
                                        .foregroundColor(.gray)
                                        .padding(.top, 10)
                                        .padding([.horizontal,.bottom])
                                        .frame(width: note.image != nil || note.imagedata != nil ? UIScreen.screenWidth * 0.9 : UIScreen.screenWidth * 0.4, alignment: .trailing)
                                }
                                .background(RoundedRectangle(cornerRadius: 6)
                                                .foregroundColor(Color.init(hex: note.color ?? "#9A58B5"))
                                                .frame(width: note.image != nil || note.imagedata != nil ? UIScreen.screenWidth * 0.9 : UIScreen.screenWidth * 0.4, alignment: .leading)
                                )
                                
                                .padding(.bottom, 10)
                            }
                        }
                        Spacer()
                    }
                }
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        FloatingMenu()
                            .padding()
                    }
                }
            }
            .onAppear(perform: contentViewModel.fetchNotesList)
            .navigationBarItems(leading: Text("Notes")
                    .font(.title)
                    .bold())
        }
    }
}
