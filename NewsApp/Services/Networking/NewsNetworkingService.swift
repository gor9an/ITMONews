//
//  DefaultNetworkingService.swift
//  NewsApp
//
//  Created by Andrey Gordienko on 21.03.2025.
//

import Foundation
import Alamofire

final class NewsNetworkingService {
    static let shared = NewsNetworkingService()
    private init() {}

    func fetch() -> [News] {
        let headers: HTTPHeaders = [
            "Authorization" : "X-Api-Key " + NetworkingConstants.apiToken.rawValue
        ]

        let url = "\(NetworkingConstants.baseURL.rawValue)\(NetworkingConstants.topHeadlines.rawValue)"

        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let params : [String : String] = ["country": "us"]

        var news = [News]()

        AF.request(url, method: .get, parameters: params, headers: headers)
            .responseDecodable(of: Articles.self) { response in
                switch response.result {
                case .success(let items):

                    news = items.articles.compactMap {$0}

                case .failure(let error):
                    print(error)
                }
            }
    }
}
