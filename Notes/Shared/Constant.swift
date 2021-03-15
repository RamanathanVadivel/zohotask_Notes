//
//  Constant.swift
//  Notes
//
//  Created by Mac HD on 13/03/21.
//

import Foundation
import SwiftUI
import UIKit
import CoreData

// MARK: - Contants



// MARK: - Floating Menu

struct FloatingMenu: View {
    var body: some View {
        NavigationLink(destination: CreateNotes()) {
            Image("floating_plus")
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

