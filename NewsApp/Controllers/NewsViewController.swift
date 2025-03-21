//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Andrey Gordienko on 21.03.2025.
//

import UIKit
import Alamofire

final class NewsViewController: UIViewController {
    lazy var tableView = UITableView()
    let cellReuseIdentifier = "NewsCell"
    var news = [News]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchNews()
        configureTableView()
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        self.tableView.register(NewsCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
    }
    
    private func fetchNews() {
        let headers: HTTPHeaders = [
            "Authorization" : "X-Api-Key " + NetworkingConstants.apiToken.rawValue
        ]
        
        let url = "\(NetworkingConstants.baseURL.rawValue)\(NetworkingConstants.topHeadlines.rawValue)"
        
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let params : [String : String] = ["country": "us"]
        
        AF.request(url, method: .get, parameters: params, headers: headers)
            .responseDecodable(of: Articles.self) { [weak self] response in
                guard let self else { return }

                switch response.result {
                case .success(let items):
                    
                    self.news = items.articles.compactMap {$0}
                    tableView.reloadData()

                case .failure(let error):
                    print(error)
                }
            }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? NewsCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(news: self.news[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.news.count
    }
}
