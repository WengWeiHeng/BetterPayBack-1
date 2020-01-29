//
//  ProfileViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    let barImage = UIImageView()
    
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:fake plus button
        barImage.image = UIImage(named: "homeIndicator2")
        barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
        view.addSubview(barImage)
        //plusボタン設定
        button.setImage(UIImage(named: "plus_main"), for: UIControl.State.normal)
        button.frame = CGRect(x: barImage.center.x - 33 , y: self.view.frame.height * 0.83, width: 70, height: 70)
        button.addTarget(self, action: #selector(self.popup(_:)), for: .touchUpInside)
        view.addSubview(button)
        //homeButton
        homeButton.setImage(UIImage(named: "home2"), for: UIControl.State.normal)
        homeButton.frame = CGRect(x: barImage.frame.width * 0.17 , y: view.frame.height * 0.9 - 7, width: 65, height: 65)
        homeButton.addTarget(self, action: #selector(self.homeButtonTapped(_:)), for: .touchUpInside)
        homeButton.tintColor = .gray
        view.addSubview(homeButton)
        //profileButton
        profileButton.setImage(UIImage(named: "user"), for: UIControl.State.normal)
        profileButton.frame = CGRect(x: barImage.frame.width * 0.66 + 2, y: view.frame.height * 0.9 - 7, width: 65, height: 65)
        profileButton.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
        profileButton.tintColor = .black
        view.addSubview(profileButton)
        
        // Do any additional setup after loading the view.
        showUserName()
    }
    
    //userNameの変更
    func showUserName(){
        
        //MARK: TODO: userNameの変更
        //userNameLabel.text = nowUserName
    }
    
    // ボタンが押されたときにaddSubviewする
    @objc func popup(_ sender: Any) {
        view.addSubview(popupViewController.view)
        
    }
    @objc func homeButtonTapped(_ sender: Any){
        if let controller = storyboard?.instantiateViewController(withIdentifier: "homeTabBar"){
            present(controller, animated: false, completion: nil)
        }
        homeButton.tintColor = .black
        profileButton.tintColor = .gray
    }
    @objc func profileButtonTapped(_ sender: Any){
        if let controller = storyboard?.instantiateViewController(withIdentifier: "profile"){
            present(controller, animated: false, completion: nil)
        }
        homeButton.tintColor = .gray
        profileButton.tintColor = .black
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
        
        //MARK: TODO: 会員機能
        //try! Auth.auth().signOut()
        print("ログアウトした")
        if let controller = storyboard?.instantiateViewController(withIdentifier: "main"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnHelpTapped(_ sender: Any) {
        //外部ブラウザでURLを開く
        let url = NSURL(string: "https://gpcjoy3887.wixsite.com/better-pay-back")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
}
