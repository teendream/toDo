//
//  Presenter.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func updateView(with data: [String])
}

class MainPresenter: MainPresenterProtocol {
    weak var view: MainViewProtocol?
    var dataManager: DataManagerProtocol

    init(view: MainViewProtocol, dataManager: DataManagerProtocol) {
        self.view = view
        self.dataManager = dataManager
    }

    func viewLoaded() {
        updateToCurrent()
    }
    
    func updateToCurrent() {
        let data = dataManager.fetchTasks()
        let taskTitle: [String] = data?.compactMap { $0.title } ?? []
        
        view?.updateView(with: taskTitle.reversed())
    }
    
    func onAddTap(text: String?) {
        guard let text = text else { return }
        dataManager.createTask(taskName: text)
        updateToCurrent()
    }
    
    func onRemoveTap(text: String) {
        dataManager.removeTask(taskName: text)
        updateToCurrent()
    }
}
