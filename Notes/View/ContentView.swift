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
                        .foregroundColor(Color.black)
                        .padding([.horizontal,.top])
                        .frame(width: UIScreen.screenWidth * 0.44, alignment: .leading)
                    Spacer()
                    Text(formatDate(time: contentViewModel.notes[index].time ?? K.currentTime))
                        .font(.body)
                        .foregroundColor(.gray)
                        .padding(.top, 10)
                        .padding([.horizontal,.bottom])
                        .frame(width: UIScreen.screenWidth * 0.4, alignment: .trailing)
                }.frame(width: UIScreen.screenWidth * 0.44, height:getHeight(index,isleftview), alignment: .leading)
                .background(RoundedRectangle(cornerRadius: 6)
                                .foregroundColor(Color.init(hex: contentViewModel.notes[index].color ?? K.defaultBackgroundColor))
                            
                )
            }
        }
    }
    
    fileprivate func getHeight(_ index: Int, _ view: Bool) -> CGFloat? {
        currentIndex = index
        if view {
            return (index % 2 == 0 ? 180 : 260)
        } else {
            return (index % 2 != 0 ? 180 : 260)
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
                    LoadingView(isShowLoader:$isShowLoader)
                }.onAppear(perform: contentViewModel.fetchNotesList)
            }.onAppear(){
                isShowLoader = true
                contentViewModel.getAllNotesFromURL{
                    isShowLoader = false
                    contentViewModel.fetchNotesList()
                }
            }
            .navigationBarItems(leading: Text(K.appTitle_Notes).font(.largeTitle).bold())
        }
    }
}
