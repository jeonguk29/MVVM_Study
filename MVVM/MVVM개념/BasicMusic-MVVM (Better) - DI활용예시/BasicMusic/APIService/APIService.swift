//
//  APIService.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation
import UIKit

protocol NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> Void)
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> Void)
}

// 일부러 싱글톤으로 안 만듦
// - 프로토콜 채택해서 만듬
// - 실제로 이렇게 만들면 의존성 주입으로 뷰모델에 전달 가능함 
class APIService: NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                completion(.success(musicData.results))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = imageURL,
              let url = URL(string: urlString)  else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
                return
            }
        }
    }
}

// 의존성 주입이 필요한 이유
// 프로토콜을 만들고 => 프로토콜을 채택해 가지고 만든 구체화된 모델이 NetworkType 추상화 된 모델에 의존하게 만들고
// 그리고 이 추상화 된 모델을 실제로 뷰 모델을 만들때 주입을 해주면서 의존성 주입을 활용할 수 있는 것임 
class TestService: NetworkType {
    func fetchMusic(completion: @escaping (Result<[Music], NetworkError>) -> Void) {
        let urlString = "https://itunes.apple.com/search?media=music&term=jazz"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completion(.failure(.networkingError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(.dataError))
                return
            }
            
            do {
                let musicData = try JSONDecoder().decode(MusicData.self, from: safeData)
                completion(.success(musicData.results))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    func loadImage(imageURL: String?, completion: @escaping (UIImage?) -> Void) {
        guard let urlString = imageURL,
              let url = URL(string: urlString)  else {
            completion(nil)
            return
        }
        
        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            DispatchQueue.main.async {
                completion(image)
                return
            }
        }
    }
}
