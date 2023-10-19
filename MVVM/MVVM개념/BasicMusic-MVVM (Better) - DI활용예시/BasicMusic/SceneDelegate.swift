//
//  SceneDelegate.swift
//  BasicMusic
//
//  Created by Allen H on 2022/12/13.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // 스토리보드 생성 + 조건을 만들어서 코드로 생성하기 ⭐️⭐️⭐️
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // 네트워킹 객체 생성
        // - 1. apiService를 외부에서 만들고
        let apiService = APIService() // + 의존성 주입이 필요한 이유 TestService로 바꿔치기를 할 수가 있음
                                        // 나중에 테스트 코드 같은것을 용이하게 작성 할 수 있음
        
        // 의존성 주입방식으로 네트워킹 객체 전달 ⭐️⭐️⭐️ (뷰모델 생성)
        // - 2. ViewModel을 만들때 외부에서 만든 것을 주입 (의존성 주입)
        let musicVM = MusicViewModel(apiManager: apiService)

        
        let firstVC = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        // 뷰모델 전달
        // - 3. 위에서 만든 ViewModel을 첫번째 화면 View 즉 ViewModel을 가지는 View에 전달을 하는 것임
        firstVC.viewModel = musicVM
        
        
        window?.rootViewController = firstVC
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

