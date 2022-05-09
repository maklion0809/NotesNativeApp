//
//  Note+CoreDataProperties.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var stringContent: String?
    @NSManaged public var folder: Folder?

}

extension Note : Identifiable {

}
