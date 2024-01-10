//
//  MainViewController.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import UIKit
import Stevia

protocol MainPresenterProtocol: AnyObject {
    func viewLoaded()
    func onAddTap(text: String?)
    func onRemoveTap(text: String)
}

class MainViewController: UIViewController, MainViewProtocol {
    var presenter: MainPresenterProtocol!
    
    var tableView = UITableView()
    
    var dataSource: [String] = []
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter task"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewLoaded()
        setup()
    }
    
    func setup() {
        self.title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.app"), style: .plain, target: self, action: #selector(onAddTap))
        view.backgroundColor = .white
        tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
        view.subviews(textField, tableView)
        tableView.delegate = self
        tableView.dataSource = self
        textField.delegate = self
        textField.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 246/255, alpha: 0.5)
        textField.layer.cornerRadius = 16
        
        textField
            .fillHorizontally(padding: 16)
            .height(56)
            .Top == view.safeAreaLayoutGuide.Top + 10
        
        tableView
            .fillHorizontally(padding: 16)
            .Top == textField.Bottom + 10
        
        tableView.Bottom == view.safeAreaLayoutGuide.Bottom - 10
    }
    
    @objc
    func onAddTap() {
        presenter.onAddTap(text: textField.text)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableCell
        cell.titleLabel.text = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
            self.presenter.onRemoveTap(text: self.dataSource[indexPath.row])
        }
        item.image = UIImage(named: "deleteIcon")
        
        let swipeActions = UISwipeActionsConfiguration(actions: [item])
        
        return swipeActions
    }
    
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func updateView(with data: [String]) {
        dataSource = data
        tableView.reloadData()
    }
}
