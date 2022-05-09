//
//  CreatorNoteViewController.swift
//  Task12StorageMethods(main)
//
//  Created by Tymofii (Work) on 28.10.2021.
//

import UIKit

protocol CreatorNoteViewInterface: AnyObject {
    func resignAllResponders()
}

final class CreatorNoteViewController: UIViewController, CreatorNoteViewInterface {
    
    // MARK: - Configuration
    
    private enum Configuration {
        static let textFieldHeight: CGFloat = 50
        static let stackViewIndent: CGFloat = 10
        static let textFieldCornerRadius: CGFloat = 10
        static let textFieldBorderWidth: CGFloat = 1
        static let stackViewSpacing: CGFloat = 10
    }
    
    // MARK: - Variable
    
    var presenter: CreatorNotePresenter?
    
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
    
    private lazy var noteNameTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter note name", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.textColor = .white
        textField.layer.borderWidth = Configuration.textFieldBorderWidth
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = Configuration.textFieldCornerRadius
        
        return textField
    }()
    
    private lazy var noteContentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .black
        textView.textColor = .white
        textView.layer.borderWidth = Configuration.textFieldBorderWidth
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.cornerRadius = Configuration.textFieldCornerRadius
        
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSubview()
        setupConstraint()
        setupNotificationCenter()
    }
    
    // MARK: - CreatorNoteViewInterface
    
    func resignAllResponders() {
        view.endEditing(true)
    }
    
    // MARK: - Setting up the navigation
    
    private func setupNavigation() {
        title = "Create note"
        navigationController?.navigationBar.barStyle = UIBarStyle.black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = saveBarButton
    }
    
    // MARK: - Setting up the subview
    
    private func setupSubview() {
        stackView.addArrangedSubview(noteNameTextField)
        noteNameTextField.delegate = self
        stackView.addArrangedSubview(noteContentTextView)
        noteContentTextView.delegate = self
        view.addSubview(stackView)
        presenter?.delegate = self
        guard let note = presenter?.config() else { return }
        noteNameTextField.text = note.name
        noteContentTextView.text = note.stringContent
    }
    
    // MARK: - Setting up the constraint
    
    private func setupConstraint() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Configuration.stackViewIndent),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Configuration.stackViewIndent),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Configuration.stackViewIndent),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Configuration.stackViewIndent)
        ])
        noteNameTextField.heightAnchor.constraint(equalToConstant: Configuration.textFieldHeight).isActive = true
    }
    
    // MARK: - Setting up the NotificationCenter
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    
    // MARK: - UIAction
    
    @objc private func wasSaveButtonTapped(_ sender: UITabBarItem) {
        presenter?.handleSaveButtonAction()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo, let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {return}
        
        noteContentTextView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: keyboardSize.height - Configuration.textFieldHeight + Configuration.stackViewSpacing, right: .zero)
        noteContentTextView.scrollRangeToVisible(noteContentTextView.selectedRange)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        noteContentTextView.contentInset = UIEdgeInsets.zero
        noteContentTextView.scrollIndicatorInsets = noteContentTextView.contentInset
        noteContentTextView.scrollRangeToVisible(noteContentTextView.selectedRange)
    }
}


// MARK: - UITextFieldDelegate

extension CreatorNoteViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case noteNameTextField:
            presenter?.nameDidChange(with: textField.text)
        default: break
        }
    }
}

// MARK: - UITextViewDelegate

extension CreatorNoteViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        switch textView {
        case noteContentTextView:
            presenter?.stringContentDidChange(with: textView.text)
        default: break
        }
    }
}
