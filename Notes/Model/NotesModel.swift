//
//  NotesModel.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import CoreData
import UIKit

struct NotesModel: Codable {
    let id: String?
    let title: String?
    let time: String?
    let body: String?
    let image: String?
    let imagedata: Data?
}

