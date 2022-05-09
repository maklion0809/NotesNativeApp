//
//  CreatorNoteModel.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import Foundation

final class CreatorNoteModel {
    var name: String?
    var stringContent: String?
    let folder: Folder
    var note: Note?
    
    init (folder: Folder) {
        self.folder = folder
    }
}
