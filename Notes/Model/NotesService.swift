//
//  NotesService.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import Foundation

struct NotesService {
    
    static let shared = NotesService()
    
    func performRequest(completion:@escaping (_ data : [NotesModel]?)->()) {
        if let url = URL(string: K.notesURL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(nil)
                    return
                }
                if let safeData = data {
                    if let notes = self.parseJSON(safeData) {
                        CoreDataManager.shared.saveNotes(notesModelArray: notes)
                        completion(notes)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ notesData: Data) -> [NotesModel]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([NotesModel].self, from: notesData)
            print("*** Notes json Response \(decodedData)")
            return decodedData
        } catch {
            return nil
        }
    }
}


