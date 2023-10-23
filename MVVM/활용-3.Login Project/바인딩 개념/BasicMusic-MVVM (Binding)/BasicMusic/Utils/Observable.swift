//
//  Observable.swift
//  BasicMusic
//
//  Created by Allen H on 2023/05/12.
//

import Foundation

class 클래스로감싸진데이터<T> {
    // <T> 제네릭 타입으로 선언 더블, 문자열 등등 어떤 타입으로도 가능하게
    
    // ⭐️ 값이 변할때마다 "나중에호출될수있는함수"(클로저/함수) 호출
    var 데이터값: T {
        didSet {
            나중에호출될수있는함수?(데이터값)
        }
    }
    
    // "데이터값"이 변할때 =====> 함수호출 ⭐️⭐️⭐️
    var 나중에호출될수있는함수: ((T) -> Void)?
    
    init(_ 값: T) {
        self.데이터값 = 값
    }
    
    // RxSwift에서 이런식으로 사용 클로저를 받아서 내부에 할당
    func 바인딩하기(콜백함수: @escaping (T) -> Void) {
        self.나중에호출될수있는함수 = 콜백함수
    }

}
