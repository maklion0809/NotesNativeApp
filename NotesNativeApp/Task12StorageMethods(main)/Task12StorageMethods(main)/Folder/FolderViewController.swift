//
//  FolderViewController.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 27.10.2021.
//

import UIKit
import CoreData

final class FolderViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let cellIdentifier = "FolderCell"
    }
    
    // MARK: - Variable
    
    var presenter: FolderPresenter?
    
    // MARK: - UI element
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Configuration.cellIdentifier)
        return tableView
    }()
    
    private lazy var addBarButton: UIBarButtonItem = {
        let addButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill.badge.plus"), style: .plain, target: self, action: #selector(wasAddButtonTapped(_:)))
        addButtonItem.tintColor = UIColor.orange
        return addButtonItem
    }()
    
    private lazy var sortBarButton: UIBarButtonItem = {
        let sortButtonItem = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(wasSortButtonTapped(_:)))
        sortButtonItem.tintColor = UIColor.orange
        return sortButtonItem
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSubview()
        setupConstraint()
    }
    
    // MARK: - Setting up the navigation
    
    private func setupNavigation() {
        title = "Folders"
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItems = [addBarButton, sortBarButton]
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        presenter?.handleCoreData()
        presenter?.fetchResultController.delegate = self
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UIAction
    
    @objc private func wasAddButtonTapped(_ sender: UITabBarItem) {
        presenter?.handleCreatorFolderButtonAction()
    }
    
    @objc private func wasSortButtonTapped(_ sender: UITabBarItem) {
        let alert = UIAlertController(title: "Sorting folders", message: "Sort by category", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Sort by name descending", style: .default, handler: { action in
            self.presenter?.handleSortItems(by: "name", ascending: false)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Sort by date descending", style: .default, handler: { action in
            self.presenter?.handleSortItems(by: "creationDate", ascending: false)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Sort by name ascending", style: .default, handler: { action in
            self.presenter?.handleSortItems(by: "name", ascending: true)
            self.tableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "Sort by date ascending", style: .default, handler: { action in
            self.presenter?.handleSortItems(by: "creationDate", ascending: true)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension FolderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSections ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfRows(in: section) ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let folder = presenter?.getObject(at: indexPath) else { return UITableViewCell()}
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: Configuration.cellIdentifier)
        cell.textLabel?.text = folder.name
        cell.detailTextLabel?.text = folder.folderDescription
        cell.accessoryType = .detailButton
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .lightGray
        cell.tintColor = .white
        cell.backgroundColor = .black
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension FolderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let folder = presenter?.getObject(at: indexPath) else { return }
        presenter?.handleNoteButtonAction(folder: folder)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        guard let folder = presenter?.getObject(at: indexPath) else { return }
        presenter?.handleInfoFolderButtonAction(folder: folder)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let folder = presenter?.getObject(at: indexPath) else { return }
            presenter?.handleDeleteItem(folder: folder)
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension FolderViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { return }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        default:
            print("default")
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
