////
////  NetworkDataFetcher.swift
////  FriendsVK
////
////  Created by Tatsiana on 03.05.2020.
////  Copyright © 2020 Tatsiana. All rights reserved.
////
//
//import Foundation
//import VK_ios_sdk
//
//protocol DataFetcher {
//    func getFriends(response: @escaping (FriendsResponse?) -> Void)
//    func getUser(response: @escaping (UserResponse?) -> Void)
//}
//
//final class NetworkDataFetcher: DataFetcher {
//    let networking: Networking
//    
//    init(networking: Networking) {
//        self.networking = networking
//    }
//    func getFriends(response: @escaping (FriendsResponse?) -> Void) {
//        let params = ["fields" : "friends"]
//        networking.request(path: API.friends, params: params, completion: { (data, error) in
//        if let error = error {
//            print("Error received requesting data: \(error.localizedDescription)")
//            response(nil)
//            }
//            
//            let decoded = self.decodeJSON(type: FriendsResponseWrapped.self, from: data)
//            response(decoded?.response)
//        })
//    }
//    
//    func getUser(response: @escaping (UserResponse?) -> Void) {
//        guard let userId = VKSdk.accessToken()?.userId else { return }
//        let params = ["user_ids": userId, "fields": "photo_100"]
//        networking.request(path: API.user, params: params, completion: { (data, error) in
//            if let error = error {
//                print("Error received requesting data: \(error.localizedDescription)")
//                response(nil)
//            }
//            
//            let decoded = self.decodeJSON(type: UserResponseWrapped.self, from: data)
//            response(decoded?.response.first)
//        })
//    }
//    
//    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
//        return response
//    }
//}
