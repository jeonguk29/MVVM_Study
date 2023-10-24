//
//  BindingTextField.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/14.
//
/*
 예를 들어서 이런 텍스트 필드 같은 거 요런 것들이 변하면 반대로 데이터를 변하게 할 수
 있는 요런 기능의 라이브러리를 제공을 하는데 요게 rxCocoa 입니다
 RxCocoa 라이브러리가 제공을 해주는 그런 유사한 기능을 제가 직접적으로 구현해 놨음
 
 */
import UIKit


class 바인딩기능있는텍스트필드: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonAddTarget()
    }
    
    // 스토리보드 생성시 호출
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonAddTarget() // 타겟 설정 자동으로 하게 만들었음
    }
    
    // addTarget ===> 메서드 호출
    private func commonAddTarget() {
        self.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        // 글자가 변할때마다 textFieldDidChanged를 호출
    }
    
    // 글자가 변할때마다 호출되는 메서드 ⭐️⭐️⭐️
    // - 바인딩기능있는텍스트필드는 생성이 될때부터 AddTarget기능을 가지고 있는 것임 AddTarget 해준 메서드는 아래와 같음
    @objc func textFieldDidChanged(_ textField: UITextField) {
        if let text = textField.text {
            나중에호출될수있는함수(text) // 텍스트를 추출하여 아래 클로저 호출
        }
    }
    
    // ⭐️ 즉. 글자가 변할때마다 클로저 호출
    // - 글자가 변할때마다 어떤일을 할 수 있도록 정의 해주면 그일을 할 수 있게 되는 것임 
    private var 나중에호출될수있는함수: (String) -> Void = { _ in }
    
    
    func 바인딩하기(callback: @escaping (String) -> Void) {
        나중에호출될수있는함수 = callback
    }
}
