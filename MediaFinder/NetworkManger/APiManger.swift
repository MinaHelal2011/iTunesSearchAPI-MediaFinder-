//
//  APiManger.swift
//  MediaFinder
//
//  Created by Mina Helal on 3/30/20.
//  Copyright © 2020 Mina Hilal. All rights reserved.
//

import Foundation
import Alamofire

struct ItunesSearchApi {
    static func loadMedia(_ criteria: String,_ media: MediaType,completion: @escaping (_ error: Error?, _ results: [Media]?) -> Void) {
        AF.request(Urls.base, method: HTTPMethod.get, parameters: [paramters.term: criteria, paramters.media: media], encoding: URLEncoding.default, headers: nil).response { response in
            guard response.error == nil else {
                print(response.error!)
                print("Faild errror")
                completion(response.error, nil)
                return
            }
            guard let data = response.data else {
                print("didnot get any data from API")
                return
            }
            do{
                let decode = JSONDecoder()
                let respondDataArr = try decode.decode(ResponseResult.self, from: data)
                completion(nil, respondDataArr.results as? [Media])
            } catch let error {
                print(error)
            }
        }
    }
}

