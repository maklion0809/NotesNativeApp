//
//  CreatorFolderViewController.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit

protocol CreatorFolderViewInterface: AnyObject {
    func resignAllResponders()
}

final class CreatorFolderViewController: UIViewController, CreatorFolderViewInterface {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let textFieldHeight: CGFloat = 50
        static let stackViewIndent: CGFloat = 10
        static let textFieldCornerRadius: CGFloat = 10
        static let textFieldBorderWidth: CGFloat = 1
        static let stackViewSpacing: CGFloat = 50
    }
    
    // MARK: - Variable
    
    var presenter: CreatorFolderPresenter?
    
    // MARK: - UI element
    
    private lazy var saveBarButton: UIBarButtonItem = {
        let saveButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(wasSaveButtonTapped(_:)))
        saveButtonItem.tintColor = UIColor.orange
        
        return saveButtonItem
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Configuration.stackViewSpacing
        
        return stackView
    }()
    
    private lazy var folderNameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter folder name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .white
        textField.layer.borderWidth = Configuration.textFieldBorderWidth
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = Configuration.textFieldCornerRadius
        
        return textField
    }()
    
    private lazy var folderDescriptionTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter folder description", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .white
        textField.layer.borderWidth = Configuration.textFieldBorderWidth
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = Configuration.textFieldCornerRadius
        
        return textField
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSubview()
        setupConstraint()
    }
    
    // MARK: - CreatorFolderViewInterface
    
    func resignAllResponders() {
        view.endEditing(true)
    }
    
    // MARK: - Setting up the navigation
    
    private func setupNavigation() {
        title = "Create folder"
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        stackView.addArrangedSubview(folderNameTextField)
        folderNameTextField.delegate = self
        stackView.addArrangedSubview(folderDescriptionTextField)
        folderDescriptionTextField.delegate = self
        view.addSubview(stackView)
        presenter?.delegate = self
        guard let folder = presenter?.config() else { return }
        folderNameTextField.text = folder.name
        folderDescriptionTextField.text = folder.folderDescription
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Configuration.stackViewIndent),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Configuration.stackViewIndent),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Configuration.stackViewIndent)
        ])
        folderNameTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
        folderDescriptionTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
    }
    
    // MARK: - UIAction
    
    @objc private func wasSaveButtonTapped(_ sender: UITabBarItem) {
        presenter?.handleSaveButtonAction()
    }
}

// MARK: - UITextFieldDelegate

extension CreatorFolderViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case folderNameTextField:
            presenter?.nameDidChange(with: textField.text)
        case folderDescriptionTextField:
            presenter?.folderDescriptionDidChange(with: textField.text)
        default: break
        }
    }
}
