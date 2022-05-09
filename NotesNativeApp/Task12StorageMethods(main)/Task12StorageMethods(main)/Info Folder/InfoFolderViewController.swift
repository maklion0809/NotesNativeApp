//
//  InfoFolderViewController.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit

final class InfoFolderViewController: UIViewController {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let cellIdentifier = "NoteCell"
        static let folderInfoNumberOfSections = 3
        static let folderInfoNumberOfRows = 1
    }
    
    // MARK: - Variable
    
    var presenter: InfoFolderPresenter?
    
    // MARK: - UI element
    
    private lazy var editBarButton: UIBarButtonItem = {
        let saveButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(wasEditButtonTapped(_:)))
        saveButtonItem.tintColor = UIColor.orange
        
        return saveButtonItem
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .black
        return tableView
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
        title = "Info"
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = editBarButton
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Configuration.cellIdentifier)
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    // MARK: - UIAction
    
    @objc private func wasEditButtonTapped(_ sender: UITabBarItem) {
        presenter?.handleUpdateFolderButtonAction()
    }
}

// MARK: - UITableViewDataSource

extension InfoFolderViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        presenter?.numberOfSection ?? .zero
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case .zero..<Configuration.folderInfoNumberOfSections:
            return Configuration.folderInfoNumberOfRows
        default:
            return presenter?.numberOfRowsModifications ?? .zero
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Configuration.cellIdentifier) else { return UITableViewCell()}
        cell.textLabel?.text = presenter?.bodyContent(at: indexPath)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.titleHeader(at: section)
    }
}
