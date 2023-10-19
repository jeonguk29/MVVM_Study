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
    
    var viewModel: MusicViewModel!
    
    // var apiService = APIService()
    /*
     뷰 컨 안에다가 APIService() 같이 네트워킹 로직을 넣을 수 있음
     뷰컨이 API 서비스를 가지는 것임 이럴때 문제점은 API 서비스를 호출해가지고 데이터가 생기면
     데이터를 받았을떄 다시 해당 데이터를 뷰 모델한테 전달 해줘야함 , 데이터의 소유권은 일단 뷰 모델이 가지니까 그래서 이게 불편하기 때문에 API 서비스를 뷰 컨 안에다가 넣지 않고
     뷰 모델이 가지도록 합니다.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = MusicViewModel()
        
        // 데이터 변경이 완료된 후, 클로저에서 어떤 일을 할지 정의 (할당)
        self.viewModel.onCompleted = { [weak self] _ in
            DispatchQueue.main.async {
                self?.albumNameLabel.text = self?.viewModel.albumNameString
                self?.songNameLabel.text = self?.viewModel.songNameString
                self?.artistNameLabel.text = self?.viewModel.artistNameString
            }
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        viewModel.handleButtonTapped()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        guard viewModel.music != nil else { return }
        
        // 원칙 ========================================
        //다음 화면의 뷰컨트롤러가 가져야 하는 뷰모델 ⭐️
        let detailVM = DetailViewModel()
        
        //뷰모델이 가져야 하는 데이터 ⭐️
        detailVM.music = viewModel.music
        detailVM.imageURL = viewModel.music?.imageUrl
        
        
        // 일반적으로 ====================================
        //let detailVM = viewModel.getDetailViewModel()
        
        //다음 화면 뷰컨트롤러 ⭐️
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        //뷰모델 전달 ⭐️
        detailVC.viewModel = detailVM
        

        
        detailVC.modalPresentationStyle = .fullScreen
        self.present(detailVC, animated: true)
    }
}

