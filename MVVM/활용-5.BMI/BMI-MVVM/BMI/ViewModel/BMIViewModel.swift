//
//  BMIViewModel.swift
//  BMI
//
//  Created by Allen H on 2022/11/14.
//

import Foundation
import UIKit.UIColor

enum ValidationText: String {
    // 열거형으로 재대로 입력됬을때 아닐때 유효성을 검사 
    case right = "키와 몸무게를 입력하세요"
    case notRight = "키와 몸무게를 입력하셔야만 합니다!"
    
    var textColor: UIColor {
        switch self {
        case .right:
            return .black
        case .notRight:
            return .red
        }
    }
}

class BMIViewModel {
    
    var logicMananager: CalculatorType // 뷰모델이 BMICalculatorManager를 소유
    
    // 뷰를 위한 데이터
    private var mainText: ValidationText = .right
    
    private var heightString: String = ""
    private var weightString: String = ""
    
    private var bmi: BMI?
    
    //Output
    var mainTextString: String {
        return mainText.rawValue
    }
    
    var mainLabelTextColor: UIColor {
        return mainText.textColor
    }
    
    var bmiNumberString: String {
        return String(bmi?.value ?? 0.0)
    }
    
    var bmiAdviceString: String {
        return bmi?.advice ?? ""
    }
    
    var bmiColor: UIColor {
        return bmi?.matchColor ?? UIColor.white
    }
    
    
    init(logicMananager: CalculatorType) {
        self.logicMananager = logicMananager
    }
    
    //Input
    
    // 키랑 몸무게가 입력될때마다 호출 되는 메서드
    func setHeightString(_ height: String) {
        self.heightString = height
    }
    
    func setWeightString(_ weight: String) {
        self.weightString = weight
    }
    
    // ⭐️ 화면이동 로직 뷰 모델에서 구현함
    func handleButtonTapped(storyBoard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        if self.makeBMI() {
            heightString = ""
            weightString = ""
            goToNextVC(storyBoard: storyBoard, fromCurrentVC: fromCurrentVC, animated: animated)
        } else {
            print("다음화면으로 갈 수 없음")
        }
    }
    
    
    //Logic
    private func makeBMI() -> Bool {
        do {
            bmi = try logicMananager.calculateBMI(height: self.heightString, weight: self.weightString)
            return true
        } catch {
            let er = error as! CalculateError
            switch er {
                case .minusNumberError:
                    print("마이너스 숫자 입력")
                case .noNumberError:
                    print("숫자가 아닌 글자 입력")
                default:
                    break
            }
            mainText = .notRight
            return false
        }
    }
    
    func resetBMI() {
        heightString = ""
        weightString = ""
        
        bmi = nil
        mainText = .right
    }
    
    // 다음화면으로 이동 ⭐️
    // 뷰컨을 직접적으로 전달 받아서 present를 호출 할 것임
    private func goToNextVC(storyBoard: UIStoryboard?, fromCurrentVC: UIViewController, animated: Bool) {
        
        // 현제 두개의 뷰가 뷰모델 하나를 공유하고 있음 그냥 bim 데이터만 전달하면 되서
        // 아래처럼 새로 생성해서 전달한다면 해당 뷰모델은 우리가 계산한 bmi 데이터를 가지고 있는게 아님 새로운 bmi 데이터..
        //let bmiVM = BMIViewModel(logicMananager: self.logicMananager)
        
        // 스토리보드 생성 + 커스텀 생성자 ⭐️⭐️⭐️
        guard let secondVC = storyBoard?
            .instantiateViewController(identifier: "SecondViewController", creator: { coder in
                SecondViewController(coder: coder, viewModel: self) })
                // storyBoard 매개변수로 받은 이유는 뮤모델에서 스토리보드에 있는
                // SecondViewController를 직접적으로 인스턴스 생성하지 못해 전달 받은 것임 
                // self를 전달 즉 지금 자기자신 뷰 모델을 전달하여 공유하는 구조!
                // 클래스 타입이니까 힙에 있는 메모리 주소가 복사되어 다음 뷰컨으로 전달 될 것임 
        else {
            fatalError("SecondViewController 생성 에러")
        }
        
        secondVC.modalPresentationStyle = .fullScreen
        fromCurrentVC.present(secondVC, animated: true, completion: nil)
        // present 메서드는 아무 클래스에나 구현 되어있는게 아님 UIViewController를 상속받은 클래스에서만 구현 할 수가 있음
    }
    
    /*
     MVVM 패턴에서 화면 이동할때 데이터 전달하는게 조금 불편해서
     coordinator pattern이라는 것을 많이 사용함 
     */
    
}
