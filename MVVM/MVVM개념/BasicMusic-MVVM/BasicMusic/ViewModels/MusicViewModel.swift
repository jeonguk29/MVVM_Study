//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

/*
 일반적으로 뷰모델(Model + Controller)은 구조체가 아닌 클래스로 만듬
 
 뷰모델이 데이터를 가지며
 해당 모델에게 필요한 로직을 구현
 
 뷰를 위한 데이터 (Output)를 만들어야함
 컨트롤러(MVVM에서 View역할)에게 뿌려주기 위해
 */
class MusicViewModel {
    
    // 핵심 데이터(모델) ⭐️⭐️⭐️ (뷰모델이 가지고 있음)
    var music: Music? {
        didSet {
            // 값이 변경된다면 클로저 호출
            onCompleted(music) // 클로저에게 시점을 알려주는 것임 (music 데이터가 생긴 시점이다.)
        }
    }
    
    // 뷰를 위한 데이터 (Output)
    var albumNameString: String? {
        return music?.albumName
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var artistNameString: String? {
        return music?.artistName
    }
    
    var onCompleted: (Music?) -> Void = { _ in }
    // 함수를 담을 수 있는 변수 생성
    
    // Input (데이터를 변하게 하기 위한 로직)
    // - 사용자가 어떠한 입력을 했을때 데이터가 변해야 한다면
    //  - 현제 네트워킹 로직 호출
    func handleButtonTapped() {
        fetchMusic { [weak self] result in
            switch result {
                case .success(let music):
                    // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                    self?.music = music // 데이터를 잘 받아아오면 뷰모델이 가지는 데이터가 변경될것임
                case .failure(let error):
                    switch error {
                        case .dataError:
                            print("데이터 에러")
                        case .networkingError:
                            print("네트워킹 에러")
                        case .parseError:
                            print("파싱 에러")
                    }
            }
        }
    }
    
    
    // Logic (기타 순수 로직 등)
    func fetchMusic(completion: @escaping (Result<Music?, NetworkError>) -> Void) {
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
                let music = musicData.results.first
                completion(.success(music))
            } catch {
                completion(.failure(.parseError))
            }
        }.resume()
    }
    
    
//    func getDetailViewModel() -> DetailViewModel {
//        let detailVM = DetailViewModel() // 다음화면 생성후
//
//        detailVM.music = self.music       // 데이터를 전달하고
//        detailVM.imageURL = self.music?.imageUrl
//
//        return detailVM // 다음 화면 리턴 
//    }

}
