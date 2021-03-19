//
//  ContentViewModel.swift
//  Notes
//
//  Created by Mac HD on 15/03/21.
//

import Foundation
import Combine


class ContentViewModel : ObservableObject {
    
    let didChange = PassthroughSubject<ContentViewModel,Never>()
    
    @Published var notes : [Notes] = [] {
        didSet {
            didChange.send(self)
        }
    }
    
    func fetchNotesList() {
        DispatchQueue.main.async {
            self.notes = CoreDataManager.shared.getAllNotes()
        }
    }
    
    func getAllNotesFromURL() {
        NotesService.shared.performRequest(completion: { data in
            if data != nil {
                #if DEBUG
                print("Success")
                #endif
                self.fetchNotesList()
            }
        })
    }
    
}
