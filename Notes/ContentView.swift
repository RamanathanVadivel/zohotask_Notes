//
//  ContentView.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI

struct ContentView: View {
    
    @State var notes : [Notes] = []
    
    private func fetchNotesList() {
        self.notes = CoreDataManager.shared.getAllNotes() ?? notes
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(notes, id:\.id) { note in
                        NavigationLink(destination: NotesDetails(notes: note)) {
                            Text(note.title ?? "")
                        }
                    }
                }
                Spacer()
            }.onAppear(perform: fetchNotesList)
            .navigationBarItems(
                leading: Text("Notes")
                    .font(.title)
                    .bold(),
                trailing: NavigationLink(destination: CreateNotes()) {
                    Image(systemName: "plus")
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .background(RoundedRectangle(cornerRadius: 6).frame(width: 32, height: 32, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                    .cornerRadius(3))
                    .foregroundColor(.gray)
                    .padding()
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
