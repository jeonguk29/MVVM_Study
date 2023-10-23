//
//  ViewController.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    var viewModel = MusicViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        // 기존에는 데이터 변경이 완료된 후, 클로저에서 어떤 일을 할지 정의 (할당) 했지만 이제는 아래와 같이해줘야함
        self.viewModel.music.나중에호출될수있는함수 = { [weak self] music in
            // 클래스로 감싸진 내부에 있는 음악 데이터가 바뀔때마다 내부에서 클로저를 호출함
            DispatchQueue.main.async {
                self?.albumNameLabel.text = music.albumName
                self?.songNameLabel.text = music.songName
                self?.artistNameLabel.text = music.artistName
            }
        }
        
        // RxSwift에서는 이렇게 구현함 아에 메서드를 따로 구현해서 사용 일반적으로 이렇게 사용됨 한번 거쳐서 사용하는 식으로(코드는 같지만 )
//        self.viewModel.music.바인딩하기 { [weak self] music in
//            //music은 클래스로 감쌓여진 데이터 타입이라고 했음
//            DispatchQueue.main.async {
//                self?.albumNameLabel.text = music.albumName
//                self?.songNameLabel.text = music.songName
//                self?.artistNameLabel.text = music.artistName
//            }
//        }
        
        /*
         이런게 바인딩 핵심 개념임 데이터가 바뀔때 View까지 자동으로 바뀌는거를 보여주고 싶을때
         해당 데이터에 뷰를 묶는것 위처럼 작성된걸 뷰를 묶는다고 함
         뭔가 클래스로 감쌌는데 그 클래스로 감싸진 그런 데이터가 바뀔 때마다 어떤 클로저를 호출을
         하고 싶어서 그 호출되는 클로저를 요렇게 또 묶어다 놓는다는 뭐 요런 개념이라고 생각하시면 됨 
         */
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        viewModel.handleStartButtonTapped()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        viewModel.handleStopButtonTapped()
    }
    
}

