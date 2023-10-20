//
//  RPSViewModel.swift
//  RPSGame
//
//  Created by Allen H on 2022/10/13.
//

import UIKit

/*
 MVVM의 확실한 장점
 이 MVVM 패턴의 장점이 명확하게 드러날 수도 있는데 어떤 점이냐면요.
 뷰 모델이 있는데 어떤 회사에서 가위바위보 게임을 업데이트를 하려는 거예요
 그래서 화면을 완전히 바꿀 수도 있습니다
 화면을 완전히 바꿀 수도 있는데 어쨌든 이런 로직들은 완전히 분리가 되어 있기 때문에 뭔가
 화면에 대한 그런 UI 같은 것들을 업데이트를 할 때는 이미 로직이 다 분리가 되어 있기
 때문에 훨씬 더 편하게 유지보수 같은 거를 하실 수도 있어요
 */
class RPSViewModel {
    
    // 의존성 주입이 가능 하도록
    let rpsManager: RPSManagerProtocol  // = RPSManager()
    
    // 뷰를 위한 데이터 ⭐️⭐️
    private var result: String = "선택하세요" {
        didSet {
            onCompleted(result) // 값이 들어오면 클로저를 호출
        }
    }
    
    private var comChoice: Rps = Rps.ready
    private var myChoice: Rps = Rps.ready
    
    // Output
    var resultString: String {
        return result
    }
    
    var computerRPSimage: UIImage {
        return comChoice.rpsInfo.image
    }
    
    var computerRPStext: String {
        return comChoice.rpsInfo.name
    }
    
    var userRPSimage: UIImage {
        return myChoice.rpsInfo.image
    }
    
    var userRPStext: String {
        return myChoice.rpsInfo.name
    }
    
    var onCompleted: (String) -> Void = { _ in } // 값이 들어온 시점 구현 
    
    
    
    // 의존성 주입할 수 있도록
    // - 프로토콜 타입으로 선언 
    init(rpsManager: RPSManagerProtocol) {
        self.rpsManager = rpsManager
    }
    
    
    // Input
    func reset() {
        comChoice = Rps.ready
        myChoice = Rps.ready
        result = "선택하세요"
    }
    
    func rpsButtonTapped() {
        comChoice = Rps.allCases[Int.random(in: 1...3)]
    }
    
    func userGetSelected(title: String) {
        myChoice = selectedRPS(withString: title)
    }
    
    func selectButtonTapped() {
        result = rpsManager.getRpsResult(comChoice: comChoice, myChoice: myChoice)
    }
    
    // Logic
    private func selectedRPS(withString name: String) -> Rps {
        switch name {
        case "가위":
            return Rps.scissors
        case "바위":
            return Rps.rock
        case "보":
            return Rps.paper
        default:
            return Rps.ready
        }
    }

}
