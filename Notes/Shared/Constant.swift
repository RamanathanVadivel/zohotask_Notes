//
//  Constant.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import Foundation
import SwiftUI

// MARK: - Contants

struct K {
    static let notesURL = "https://raw.githubusercontent.com/RishabhRaghunath/JustATest/master/posts"
    static let defaultImage = "photo"
    static let errorImage = "multiply.circle"
    static let backButton = "arrow"
    static let attachImage = "attachImage_black"
    static let imageAttached = "attachImage_green"
    static let floatingPlusIcon = "floating_plus"
    static let appTitle_Notes = "Notes"
    static let refreshButton = "Click Refresh"
    static let noNotesAvailable = "No Notes Added yet... "
    static let defaultBackgroundColor = "#EDA87E"
    static let titlePlaceholder = "Title"
    static let bodyPlaceholder = "Type Something..."
    static let saveButton = "Save"
    static let saveButtonBackgroundColor = "#3B3B3B"
    static let currentTime = "\(Date().timeIntervalSince1970)"
    static let defaultTitle = "*** Error to load Title of Notes"
    static let defaultBody = "*** Error to load Body of Notes"
    static let pleaseWait = "Please wait..."
}


// MARK: - Floating Menu

struct FloatingMenu: View {
    var body: some View {
        NavigationLink(destination: CreateNotesView(createNotesViewModel: CreateNotesViewModel())) {
            Image(K.floatingPlusIcon)
                .renderingMode(.original)
                .resizable()
                .frame(width: 100, height: 100)
        }
    }
}

// MARK: - Convert TimeStamp to Date Format

func formatDate(time: String) -> String {
    let date = Date(timeIntervalSince1970: Double(time)!)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM dd,yyyy"
    return dateFormatter.string(from: date)
}

