//
//  LoginViewModel.swift
//  LoginProject
//
//  Created by Allen H on 2022/11/13.
//

import UIKit

enum LoginStatus {
    case none                // 로그인전
    case validationFailed    // 입력실패
    case loginDenied         // 로그인거절
    case authenticated       // 인증완료
}

class LoginViewModel {
    
    // 유저가 입력한 글자 데이터
    private var emailString: String = ""
    private var passwordString: String = ""
    
    // 로그인 상태 데이터 ⭐️⭐️⭐️
    private var loginStatus: LoginStatus = .none
    
    //var loginStatusChanged: (LoginStatus) -> Void = { _ in }
    
    // Input
    // 4. 뷰에서 일어나는 일들 전달 받을 수 있도록
    func setEmailText(_ email: String) {
        emailString = email
    }
    
    func setPasswordText(_ password: String) {
        passwordString = password
    }
    
    func handleUserLogin(fromCurrentVC: UIViewController, animated: Bool) {
        guard !emailString.isEmpty && !passwordString.isEmpty else {
            self.loginStatus = .validationFailed
            return
        }

        APIService.shared.loginTest(username: emailString, password: passwordString) { [unowned self] result in
            switch result {
            case .success():
                // 로그인 데이터 상태 변경
                self.loginStatus = .authenticated
                self.goToNextVC(fromCurrentVC: fromCurrentVC, animated: true)
                print("로그인 성공")
            case .failure(_):
                // 로그인 데이터 상태 변경
                self.loginStatus = .loginDenied
                print("로그인 실패")
            }
        }
    }
    
    // Logic
    // 화면 이동을 뷰모델에서 처리 ⭐️
    // 5. 다음 화면 이동시 뷰모델이 가진 이메일 데이터를 전달 
    private func goToNextVC(fromCurrentVC: UIViewController, animated: Bool) {
        let firstVM = FirstPageViewModel(userEmail: self.emailString)
        let nextVC = FirstPageViewController(viewModel: firstVM)
        nextVC.modalPresentationStyle = .fullScreen

        fromCurrentVC.present(nextVC, animated: true)
    }
    
}
