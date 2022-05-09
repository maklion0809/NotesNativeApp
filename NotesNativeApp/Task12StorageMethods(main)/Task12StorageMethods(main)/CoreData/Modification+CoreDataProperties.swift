//
//  Modification+CoreDataProperties.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//
//

import Foundation
import CoreData


extension Modification {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Modification> {
        return NSFetchRequest<Modification>(entityName: "Modification")
    }

    @NSManaged public var date: Date?
    @NSManaged public var folder: Folder?

}

extension Modification : Identifiable {

}
