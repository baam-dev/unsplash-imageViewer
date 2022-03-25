//
//  NetworkService.swift
//  imageApi
//
//  Created by Amir Bakhshi on 2022-03-23.
//

import Foundation

class NetworkService {
    static let instance = NetworkService()
    var page = 1
    
    func sendRequest(keyword: String, completion: @escaping(Result<[JsonResult]?, NetworkError>) -> Void) {
        let apiKey = "tYfYoUXHNfDpZQFA-DIifgLw_WLIDgimfCrpI8FUP5E"
        let perPage = "30"
        let url = "https://api.unsplash.com/search/photos?page=\(page)&per_page=\(perPage)&query=\(keyword)&client_id=\(apiKey)"
        
        guard let urlStr = URL(string: url) else { return }
        let task = URLSession.shared.dataTask(with: urlStr) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(NetworkError.network(string: "Error making api call. \(error.debugDescription)")))
                 return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(APIResponse.self, from: data)
                self.page += 1
                completion(.success(result.results))
                
            } catch {
                completion(.failure(NetworkError.jsonParsing(string: "Error decoding json response. \(error)")))
            }
        }
        task.resume()
    }
}
