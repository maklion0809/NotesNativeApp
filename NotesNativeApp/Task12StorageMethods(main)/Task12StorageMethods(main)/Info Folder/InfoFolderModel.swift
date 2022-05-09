//
//  InfoFolderModel.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import Foundation

final class InfoFolderModel {
    let folder: Folder
    let titleHeader = ["Name folder:", "Folder description:", "Date of creation:", "Modification dates:"]
    
    init(folder: Folder) {
        self.folder = folder
    }
}
