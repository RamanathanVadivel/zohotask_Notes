//
//  CreateNotesViewModel.swift
//  Notes
//
//  Created by Mac HD on 15/03/21.
//

import Foundation
import Combine


class CreateNotesViewModel : ObservableObject {
    
    func saveNotes(_ notes: NotesModel,completion:()->()) {
        CoreDataManager.shared.saveNotes(notesModelArray: [notes])
        completion()
    }
    
}
