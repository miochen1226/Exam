//
//  RootPageModule.swift
//  Exam
//
//  Created by mio on 2023/10/5.
//

import Foundation
import Cleanse

class RootPageModule : Module {
    let viewController:UIViewController
    let articlesInteractor:ArticlesInteractor
    let articlesCoordinator:ArticlesCoordinator
    
    static func configure(binder: Binder<Unscoped>) {
        binder.bind(ArticlesInteractor.self).to{ () -> ArticlesInteractor in
            ArticlesInteractor(articleDataProviderProperties: ArticleDataProviderProperties(articleApi: NewsArticleApi(), articleDataBase: RealmDataBase()))
        }
        
        binder.bind(ArticlesCoordinator.self).to{ () -> ArticlesCoordinator in
            ArticlesCoordinator()
        }
    }
    
    init(interactor:ArticlesInteractor,coordinator:ArticlesCoordinator) {
        self.articlesInteractor = interactor
        self.articlesCoordinator = coordinator
        viewController = ArticlesViewController.init(viewModel: ArticlesViewModel(interactor: interactor, coordinator: coordinator, title: "NEWS"))
    }
}
