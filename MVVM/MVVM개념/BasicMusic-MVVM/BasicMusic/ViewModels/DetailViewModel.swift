//
//  DetailViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit


class DetailViewModel {
    
    var music: Music?
    
    var imageURL: String? { // 이것도 모델로 봐도 됨 
        didSet {
            loadImage() // 이전화면에서 데이터 받으면 네트워킹 시작
        }
    }
    
    // 뷰를 위한 데이터 (Output)
    var albumImage: UIImage? {
        didSet {
            onCompleted(albumImage)
        }
    }
    
    var songNameString: String? {
        return music?.songName
    }
    
    var onCompleted: (UIImage?) -> Void = { _ in }
    
    
    // Input (데이터를 변하게 하기 위한 로직)
    
    
    
    
    // Logic (기타 순수 로직 등)
    func loadImage() {
        guard let urlString = self.imageURL,
              let url = URL(string: urlString)  else { return }
        
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.albumImage = image
            }
        }
    }
    
}
