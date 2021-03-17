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
    @State var isShowLoader : Bool = false
    
    fileprivate func MainView(isleftview: Bool) -> some View {
        return ForEach(isleftview ? 0..<contentViewModel.notes.count/2 : contentViewModel.notes.count/2..<contentViewModel.notes.count, id:\.self) { index in
            NavigationLink(destination: NotesDetailsView(notes: contentViewModel.notes[index])) {
                VStack(alignment: .leading){
                    Text(contentViewModel.notes[index].title ?? K.defaultTitle)
                        .font(.title3)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color(ContrastColorOf(UIColor.init(hexString: contentViewModel.notes[index].color!)!, returnFlat: true)))
                        .padding([.horizontal,.top])
                        .frame(width: UIScreen.screenWidth * 0.44, alignment: .leading)
                    Spacer()
                    Text(formatDate(time: contentViewModel.notes[index].time ?? K.currentTime))
                        .font(.body)
                        .foregroundColor(Color(ContrastColorOf(UIColor.init(hexString: contentViewModel.notes[index].color!)!, returnFlat: true))).opacity(0.5)
                        .padding(.top, 10)
                        .padding([.horizontal,.bottom])
                        .frame(width: UIScreen.screenWidth * 0.4, alignment: .trailing)
                }.frame(width: UIScreen.screenWidth * 0.44, alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 6)
                                .foregroundColor(Color.init(hex: contentViewModel.notes[index].color ?? K.defaultBackgroundColor))
                            
                )
            }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ScrollView(showsIndicators: false) {
                        HStack(spacing : 16) {
                            VStack{
                                MainView(isleftview: true)
                                Spacer()
                            }
                            VStack{
                                MainView(isleftview: false)
                                Spacer()
                            }
                        }.frame(width: UIScreen.screenWidth * 0.98, alignment: .center)
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
            }.onAppear(perform: contentViewModel.fetchNotesList)
            .navigationBarItems(leading: Text(K.appTitle_Notes).font(.largeTitle).bold())
        }
    }
}
