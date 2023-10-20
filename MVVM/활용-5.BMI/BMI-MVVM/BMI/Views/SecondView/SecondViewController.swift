//
//  SecondViewController.swift
//  BMI
//
//  Created by Allen H on 2021/12/12.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 BMI를 저장하기 위한 변수
    var viewModel: BMIViewModel
    
    // (스토리보드) 커스텀 생성자 ⭐️⭐️⭐️
    // - 생성자를 새롭게 구현을 했는데 이렇게 생성자를 새롭게 구현을 했을 때는
    // 스토리보드에서 인스턴스를 생성할때 이 메서드를 호출을 할 수가 없어요
    // 뭔가 특별한 기법을 통해서 이 직접적으로 이 뷰 모델이 들어가는 생성자를 호출하려면
    /*
     뷰 모델에서 사용한것 처럼 이러한 방법으로 호출 해야함
     
     .instantiateViewController(identifier: "SecondViewController", creator: { coder in
         SecondViewController(coder: coder, viewModel: self) })
     
     이렇게 해야 외부에서 데이터를 주입 시켜줄수 있음 
     */
    init(coder: NSCoder, viewModel: BMIViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)!
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }
    
    func setupUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        backButton.layer.cornerRadius = 5
    }
    
    func configureUI() {
        // ViewModel이 가지고 있는 BMI 데이터
        bmiNumberLabel.text = viewModel.bmiNumberString
        bmiNumberLabel.backgroundColor = viewModel.bmiColor
        adviceLabel.text = viewModel.bmiAdviceString
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        self.viewModel.resetBMI()
        self.dismiss(animated: true, completion: nil)
    }

}
