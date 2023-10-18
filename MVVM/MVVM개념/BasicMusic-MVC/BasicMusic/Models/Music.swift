//
//  Music.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

struct MusicData: Codable {
    let resultCount: Int
    let results: [Music]
}

struct Music: Codable {
    let songName: String?
    let artistName: String?
    let albumName: String?
    let imageUrl: String?

    enum CodingKeys: String, CodingKey {
        case songName = "trackName"
        case artistName
        case albumName = "collectionName"
        case imageUrl = "artworkUrl100"
    }
}


enum NetworkError: Error {
    case networkingError
    case dataError
    case parseError
}

/*
 컨트롤러가 이 데이터 모델 소유를 하게 되는 거죠
 실제로 계층은 분리되어 있다고 하더라도
 코드는 따로 분리가 되어 있지만 실질적으로는 뷰 컨트롤러 내부에 위치하게 되는 그런 형태를
 많이 띕니다 
 */
