//
//  NetworkService.swift
//  FriendsVK
//
//  Created by Tatsiana on 02.05.2020.
//  Copyright © 2020 Tatsiana. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol Networking {
    func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {
     
    func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
        guard let token = VKSdk.accessToken()?.accessToken else { return }
        var allParams = params
        allParams["access_token"] = token
        allParams["v"] = API.version
        guard let url = self.url(from: path, params: allParams) else { return }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        print("URL is: \(url)")
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionTask {
        return URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        })
    }
    
    private func url(from path: String, params: [String: String]) -> URL? {
        var comp = URLComponents()
        comp.scheme = API.scheme
        comp.host = API.host
        comp.path = path
        comp.queryItems = params.map { URLQueryItem(name: $0, value: $1)}
        guard let url = comp.url else { return nil}
        return url
    }
}
