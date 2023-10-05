//
//  ArticlesCoordinator.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import UIKit
import Foundation

protocol ArticlesCoordinatorProtocol {
    func present(articleModel: ArticleModel)
    func dismiss()
}

final class ArticlesCoordinator: ArticlesCoordinatorProtocol {
    weak var navigationController: UINavigationController?

    func present(articleModel: ArticleModel) {
        //TODO Enter ArticleDetail page
    }
    
    func dismiss() {
        //TODO leave current page
    }
}
