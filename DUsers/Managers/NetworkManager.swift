//
//  NetworkManager.swift
//  DUsers
//
//  Created by Shira Janach on 19/05/2021.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://dummyapi.io/data/api/user"
    let cache = NSCache<NSString, UIImage>()
    
    private init(){}

    func getUsers(page: Int, completed: @escaping(Result<[User], DUError>) -> Void)  {
        let  endpoint = baseURL + "?limit=10"
        getDate(urlString: endpoint) { result in
            
            switch result {
            case .success(let data):
                do{
                    let usersData = try JSONDecoder().decode(UsersData.self, from: data)
                    completed(.success(usersData.data))
                } catch {
                    completed(.failure(.invalidData))
                }
                 
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getPosts(userId: String, page: Int, completed: @escaping(Result<[Post], DUError>) -> Void)  {
        let endpoint = baseURL + "/" + userId + "/post?limit=10"
        getDate(urlString: endpoint) { result in
            
            switch result {
            case .success(let data):
                
                do{
                    let decoder   = JSONDecoder()
                    let postData  = try decoder.decode(PostData.self, from: data)
                    completed(.success(postData.data))
                } catch {
                    completed(.failure(.invalidData))
                }
                 
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        getDate(urlString: urlString) { result in
            switch result {
            case .success(let data):
                guard let image = UIImage(data: data) else { return }
                
                self.cache.setObject(image, forKey: cacheKey)
                completed(image)
                
            case .failure:
                return
            }
        }
    }
    
    
    func getDate(urlString: String, completed: @escaping(Result<Data, DUError>) -> Void)  {
       
        guard let url = URL(string: urlString) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("lTE5abbDxdjGplutvTuc", forHTTPHeaderField: "app-id")
        
        let task = URLSession.shared.dataTask(with: request){ data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            completed(.success(data))
        }
        task.resume()
    }
}
