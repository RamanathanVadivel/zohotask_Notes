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
    
    @Published var viewUpdater = false
    
    func fetchNotesList() {
        self.notes = CoreDataManager.shared.getAllNotes()
    }
    
    func getAllNotesFromURL(completion:@escaping () -> ()) {
        NotesService.shared.performRequest(completion: { data in
            if data != nil {
                print("Success")
            }
            completion()
        })
    }
    
}
