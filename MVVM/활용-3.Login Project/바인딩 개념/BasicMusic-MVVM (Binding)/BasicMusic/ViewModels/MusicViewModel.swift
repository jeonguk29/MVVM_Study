//
//  MusicViewModel.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import Foundation

class MusicViewModel {
    
    var timer: Timer?
    
    // 핵심 데이터(모델) ⭐️⭐️⭐️ (뷰모델이 가지고 있음)
    var music: 클래스로감싸진데이터<Music> = 클래스로감싸진데이터(Music(songName: nil, artistName: nil, albumName: nil, imageUrl: nil))
    // - 음악 데이터 변경될때마다 뷰에서 UI를 다시 그려줄수 있도록 만들기 여기에다 didSet을 붙이지 않음
    // - Music라는 데이터를 클래스로 감싼다고 생각하자 기존에 제네릭 데이터에 삽입하는 거임 일단 초기화 위해 아무것도 설정되지않은 음악데이터 전달 안에서 로직을 처리할 것임
    
    
    // Input
    func handleStartButtonTapped() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fetchNewMusic), userInfo: nil, repeats: true)
    }
    
    func handleStopButtonTapped() {
        timer?.invalidate()
        timer = nil
    }
    
    // Logic
    // 타이머에 의해 실행되는 함수
    @objc func fetchNewMusic() {
        // 네트워킹은 싱글톤으로 구현
        APIService.shared.fetchMusic { [weak self] result in
            switch result {
                case .success(let musics):
                    // 데이터 생성 완료 (API를 통해 다운로드 -> 파싱 완료된)
                    // 음악 데이터를 랜덤으로 ⭐️⭐️⭐️
                    let randomMusic = musics.randomElement()!
                    self?.music.데이터값 = randomMusic // 랜덤 뮤직을 클래스로 감싼 데이터안에 넣어줌
                                                    // - 넣어줄때마다 내부의 클로저가 호출됨
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
    
    deinit {
        timer = nil
    }
}
