//
//  Folder+CoreDataProperties.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var folderDescription: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: NSSet?
    @NSManaged public var modifications: NSSet?

}

// MARK: Generated accessors for notes
extension Folder {

    @objc(addNotesObject:)
    @NSManaged public func addToNotes(_ value: Note)

    @objc(removeNotesObject:)
    @NSManaged public func removeFromNotes(_ value: Note)

    @objc(addNotes:)
    @NSManaged public func addToNotes(_ values: NSSet)

    @objc(removeNotes:)
    @NSManaged public func removeFromNotes(_ values: NSSet)

}

// MARK: Generated accessors for modifications
extension Folder {

    @objc(addModificationsObject:)
    @NSManaged public func addToModifications(_ value: Modification)

    @objc(removeModificationsObject:)
    @NSManaged public func removeFromModifications(_ value: Modification)

    @objc(addModifications:)
    @NSManaged public func addToModifications(_ values: NSSet)

    @objc(removeModifications:)
    @NSManaged public func removeFromModifications(_ values: NSSet)

}

extension Folder : Identifiable {

}
