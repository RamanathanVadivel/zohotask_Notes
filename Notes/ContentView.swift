//
//  ContentView.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI
import ChameleonFramework


struct FloatingMenu: View {
    var body: some View {
        NavigationLink(destination: CreateNotes()) {
        Image(systemName: "plus.circle.fill")
            .renderingMode(.original)
            .resizable()
            .foregroundColor(.black)
            .frame(width: 60, height: 60)
        }
    }
}

struct ContentView: View {
    
    @State var notes : [Notes] = []
    @State var count = 0
    
    private func fetchNotesList() {
        self.notes = CoreDataManager.shared.getAllNotes() ?? notes
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
            VStack{
                ZStack {
                    VStack {
//                            ForEach(notes, id:\.id) { note in
//                                if note.image == nil {
//                                    VStack(alignment: .leading, spacing: 10){
//                                        Text(note.title ?? "")
//                                            .font(.headline)
//                                        Text(formatDate(time: note.time ?? ""))
//                                            .font(.body)
//                                            .foregroundColor(.gray)
//                                    }
//                                    .background(RoundedRectangle(cornerRadius: 6).frame(width: geometry.size.width * 0.4, alignment: .center).cornerRadius(3))
//                                } else {
//                                    VStack(alignment: .leading, spacing: 10){
//                                        Text(note.title ?? "")
//                                            .font(.headline)
//                                        Text(formatDate(time: note.time ?? ""))
//                                            .font(.body)
//                                            .foregroundColor(.gray)
//                                    }
//                                    .background(RoundedRectangle(cornerRadius: 6).frame(width: geometry.size.width * 0.8, alignment: .center).cornerRadius(3))
//                                }
//                                NavigationLink(destination: NotesDetails(notes: note)) {
//                                    EmptyView()
//                                }.opacity(0.0)
//                            }
                        
                        List {
                            ForEach(notes, id:\.id) { note in
                                NavigationLink(destination: NotesDetails(notes: note)) {
                                    Text(note.title ?? "")
                                }
                            }
                        }
                        Spacer()
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
            }
            .onAppear(perform: fetchNotesList)
            .navigationBarItems(
                leading: Text("Notes")
                    .font(.title)
                    .bold())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
