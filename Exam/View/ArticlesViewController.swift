//
//  ArticlesViewController.swift
//  Exam
//
//  Created by mio on 2023/10/4.
//

import UIKit
import RxSwift
import AlamofireImage

class ArticlesViewController: UIViewController {
    private var tableView: UITableView!
    private var viewModel: ArticlesViewModel
    let disposeBag = DisposeBag()
    
    init(viewModel: ArticlesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ArticlesViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        self.title = self.viewModel.title
        self.viewModel.dataSource.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
            let title:String = element.title ?? ""
            let urlToImage:String = element.urlToImage ?? ""
            cell.labelTitle.text = "\(title)"
            
            let url = URL(string: urlToImage)
            if url != nil {
                let placeholderImage = UIImage(named: "placeholder")!
                let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                    size: cell.ivImage.frame.size,
                    radius: 5.0
                )
                cell.ivImage.af.setImage(
                    withURL: url!,
                    placeholderImage: placeholderImage,
                    filter: filter,
                    imageTransition: .crossDissolve(0.2)
                )
            }
            return cell
        }
        .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        setupTableView()
        updateUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupNavigationItems() {
        let activityIndicator = UIActivityIndicatorView.init(style: .medium)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: activityIndicator)
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Clean", style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.rx.tap.subscribe(onNext: { [weak self] in
            self?.viewModel.cleanDatabase()
        }).disposed(by: disposeBag)
        
        viewModel.isFetching.subscribe(onNext: { element in
            if element == true {
                activityIndicator.startAnimating()
            }
            else {
                activityIndicator.stopAnimating()
            }
        }).disposed(by: disposeBag)
    }
    
    private func setupTableView() {
        self.tableView = UITableView(frame: self.view.frame, style:.plain)
        self.tableView.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        view.addSubview(self.tableView!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.frame = view.frame
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ArticlesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated:true)
        viewModel.enterArticle(dataIndex: indexPath.row)
    }
}
