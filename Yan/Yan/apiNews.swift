//
//  apiNews.swift
//  Yan
//
//  Created by Ivakhnenko Denis on 20.05.2025.
//

import UIKit


class apiNews {
    
    static let shared = apiNews()
    
    private init(){}
    
    func fetchNews (complition: @escaping (Result<DataNews,Error>) -> ()) {
        let q = UserDefaults.standard.string(forKey: "reguest") ?? "bitcoin"
        let url = fetchUrl(url: "/everything?q=\(q)")
        print(url)
        URLSession.shared.dataTask(with: url){ data,responce,error in
            guard let data = data else {
                print("error dataTask")
                return}
            
            let dataDecoder = try? JSONDecoder().decode(DataNews.self, from: data)
           
            guard let data = dataDecoder else {
                print("Decoded error")
                return}
            
            complition(.success(data))

        }.resume()
        
        
    }
    
    
    private func fetchUrl(url:String) -> URL {
        let mainStringUrl = "https://newsapi.org/v2"
        
        let key = "&apiKey=f065d6dfc0714908ae051e72a449e02d"
        
        return URL(string:mainStringUrl + url + key)!
        
    }
    
    
}
