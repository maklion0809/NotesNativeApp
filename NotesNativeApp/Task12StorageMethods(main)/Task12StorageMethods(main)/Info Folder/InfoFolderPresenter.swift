//
//  InfoFolderPresenter.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import Foundation

final class InfoFolderPresenter {
    weak var coordinatorDelegate: FolderCoordinatorDelegate?
    private let model: InfoFolderModel
    private let dateConverter = DateConverter()
    private let database: Database

    init(model: InfoFolderModel, database: Database) {
        self.model = model
        self.database = database
    }
    
    var numberOfRowsModifications: Int? {
        model.folder.modifications?.count
    }
    
    var numberOfSection: Int {
        model.titleHeader.count
    }
    
    func handleUpdateFolderButtonAction() {
        coordinatorDelegate?.userInitiatedCreatorFolder(folder: model.folder, state: .update)
    }
    
    func titleHeader(at section: Int) -> String? {
        guard model.titleHeader.count > section else { return nil }
        return model.titleHeader[section]
    }
    
    func bodyContent(at indexPath: IndexPath) -> String? {
        switch indexPath.section {
        case .zero:
            return model.folder.name
        case 1:
            return model.folder.folderDescription
        case 2:
            return dateConverter.numberAndMounth(date: model.folder.creationDate ?? Date())
        default:
            guard let modification = model.folder.modifications?.allObjects as? [Modification], let date = modification[indexPath.item].date else { return nil }
            return  dateConverter.numberAndMounth(date: date) + " " + dateConverter.timeString(from: date)
        }
    }
}
