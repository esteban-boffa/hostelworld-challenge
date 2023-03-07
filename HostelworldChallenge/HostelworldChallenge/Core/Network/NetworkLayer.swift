//
//  NetworkLayer.swift
//  HostelworldChallenge
//
//  Created by Esteban Boffa on 06/03/2023.
//

import Foundation
import UIKit

struct NetworkLayer {
    static func request<T: Codable>(router: ApiRouter, completion: @escaping (Result<T, Error>) -> ()) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        let url = components.url

        guard let url else { return }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: .default)

        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            guard
                error == nil,
                let data,
                let response = response as? HTTPURLResponse
            else { return }
            guard (200...299).contains(response.statusCode) else {
                var message = ""
                do {
                    let responseData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                    if let responseMessage = responseData?["message"] as? String {
                        message = responseMessage
                    }
                } catch let error as NSError {
                    print(error)
                }
                print(message)
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let responseObject = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }

    static func request(imageUrl: String, success: ((UIImage) -> Void)?) {
            guard let url = URL(string: imageUrl) else { return }
            let cache = URLCache.shared
            let request = URLRequest(url: url)
            if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
                success?(image)
                #if DEBUG
                print("Retrieve image from Cache")
                #endif
            } else {
                let session = URLSession(configuration: .default)
                session.dataTask(with: request, completionHandler: { data, response, error in
                    if
                        let data = data,
                        let response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300,
                        let image = UIImage(data: data)
                    {
                        let cachedData = CachedURLResponse(response: response, data: data)
                        cache.storeCachedResponse(cachedData, for: request)
                        #if DEBUG
                        print("Retrieve image from Network")
                        #endif
                        success?(image)
                    }
                }).resume()
            }
        }
}
