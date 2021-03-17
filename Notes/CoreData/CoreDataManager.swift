//
//  CoreDataManager.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import SwiftUI
import UIKit
import CoreData
import ChameleonFramework


private func getContext() -> NSManagedObjectContext {
    let appDelegate: AppDelegate
    if Thread.current.isMainThread {
        appDelegate = UIApplication.shared.delegate as! AppDelegate
    } else {
        appDelegate = DispatchQueue.main.sync {
            return UIApplication.shared.delegate as! AppDelegate
        }
    }
    return appDelegate.persistentContainer.viewContext
}

class CoreDataManager {
    static let shared = CoreDataManager(moc:getContext())
    var moc : NSManagedObjectContext
    
    private init(moc : NSManagedObjectContext) {
        self.moc = moc
    }
    
    func getAllNotes() -> [Notes] {
        var allNotes = [Notes]()
        let notesRequest : NSFetchRequest<Notes> = Notes.fetchRequest()
        notesRequest.sortDescriptors = [NSSortDescriptor(key: "time", ascending: true)]
        do
        {
            let notesRequest = try self.moc.fetch(notesRequest)
            #if DEBUG
            print("*** getAllNotesInDB \(notesRequest)")
            #endif
            allNotes = notesRequest
        } catch let error {
            #if DEBUG
            print("*** getAllNotesInDB \(error)")
            #endif
        }
        return allNotes
    }
    
    func getNotesById(_ id : String) -> Notes? {
        let notesDetailsRequest : NSFetchRequest<Notes> = Notes.fetchRequest()
        notesDetailsRequest.returnsObjectsAsFaults = false
        notesDetailsRequest.predicate = NSPredicate(format: "id = %@", id)
        do
        {
            let notesRequestByID = try self.moc.fetch(notesDetailsRequest)
            #if DEBUG
            print("*** getNotesByIdInDB \(notesRequestByID)")
            #endif
            return notesRequestByID.first
        } catch let error {
            #if DEBUG
            print("*** getNotesByIdInDB \(error)")
            #endif
        }
        return nil
    }
    
    func saveNotes(notesModelArray:[NotesModel]) {
        for notesModel in notesModelArray {
            if getNotesById(notesModel.id ?? "0") == nil {
                let notes = Notes(context:self.moc)
                notes.id = notesModel.id
                notes.title = notesModel.title
                notes.time = notesModel.time
                notes.body = notesModel.body
                notes.image = notesModel.image
                notes.imagedata = notesModel.imagedata
                notes.color = UIColor.randomFlat().hexValue()
            }
        }
        saveManagedObjectContext()
        #if DEBUG
        print("*** Notes Saved in DB")
        #endif
    }
    
    func saveManagedObjectContext(completion:(()->())? = nil) {
        DispatchQueue.global(qos: .background).async {
            self.moc.performAndWait {
                try? self.moc.save()
                if completion != nil {
                    DispatchQueue.main.async {
                        completion!()
                    }
                }
            }
        }
    }
}
