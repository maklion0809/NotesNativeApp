//
//  NoteFlowCoordinator.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.11.2021.
//

import UIKit

protocol NoteCoordinatorDelegate: AnyObject {
    func userInitiatedCreatorNote(folder: Folder, note: Note?, state: State)
    func popViewController()
}

final class NoteFlowCoordinator: Coordinator {
    private let navigationController: UINavigationController
    private let dataBase: Database
    private let folder: Folder
    
    init(navigationController: UINavigationController, dataBase: Database, folder: Folder) {
        self.navigationController = navigationController
        self.dataBase = dataBase
        self.folder = folder
    }
    
    func start() {
        let controller = NoteViewController()
        let presenter = NotePresenter(model: NoteModel(folder: folder), database: dataBase)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
}

extension NoteFlowCoordinator: NoteCoordinatorDelegate {
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
    
    func userInitiatedCreatorNote(folder: Folder, note: Note?, state: State) {
        let controller = CreatorNoteViewController()
        let model = CreatorNoteModel(folder: folder)
        model.note = note
        let presenter = CreatorNotePresenter(model: model, database: dataBase, state: state)
        presenter.coordinatorDelegate = self
        controller.presenter = presenter
        navigationController.pushViewController(controller, animated: true)
    }
}
