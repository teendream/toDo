//
//  MainBuilder.swift
//  DemoToDo
//
//  Created by Azizbek Abdulkhakimov on 10/01/24.
//

import UIKit

protocol MainBuilderProtocol {
    func build() -> UIViewController
}

class MainBuilder: MainBuilderProtocol {
    func build() -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController, dataManager: DataManager())
        viewController.presenter = presenter
        return viewController
    }
}
