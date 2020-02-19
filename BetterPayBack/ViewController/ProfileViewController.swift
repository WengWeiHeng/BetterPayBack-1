//
//  ProfileViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    let barImage = UIImageView()
    
    
    @IBOutlet weak var icon: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var btnStackView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK:sizeChange
        let width = view.frame.width
        let height = view.frame.height
        icon.frame = CGRect(x: width*0.5 - 110, y: height*0.2 - 110, width: 220, height: 220)
        userNameLabel.frame = CGRect(x: width*0.5 - 136, y: height*0.35 - 21, width: 272, height: 43)
        btnStackView.frame = CGRect(x: width*0.5 - 136, y: height*0.6 - 150, width: 272, height: 299)
        
        if width > 414{
            barImage.image = UIImage(named: "homeIndicator3")
            barImage.frame = CGRect(x: -1, y: view.frame.height - 123, width: width, height: 123)
            view.addSubview(barImage)
            
            //homeButton
            homeButton.setImage(UIImage(named: "home2"), for: UIControl.State.normal)
            homeButton.frame = CGRect(x: barImage.frame.width * 0.21 - 2 , y: view.frame.height * 0.9, width: 65, height: 65)
            homeButton.addTarget(self, action: #selector(self.homeButtonTapped(_:)), for: .touchUpInside)
            homeButton.tintColor = .gray
            view.addSubview(homeButton)
            //profileButton
            profileButton.setImage(UIImage(named: "user"), for: UIControl.State.normal)
            profileButton.frame = CGRect(x: barImage.frame.width * 0.7 , y: view.frame.height * 0.9, width: 65, height: 65)
            profileButton.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
            profileButton.tintColor = .black
            view.addSubview(profileButton)
            
        }else{
            barImage.image = UIImage(named: "homeIndicator2")
            barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
            view.addSubview(barImage)
            
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
        }
        
        //MARK:fake plus button
        //barImage.image = UIImage(named: "homeIndicator2")
        //barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
        //view.addSubview(barImage)
        //plusボタン設定
        button.setImage(UIImage(named: "plus_main"), for: UIControl.State.normal)
        button.frame = CGRect(x: barImage.center.x - 33 , y: self.view.frame.height * 0.83, width: 70, height: 70)
        button.addTarget(self, action: #selector(self.popup(_:)), for: .touchUpInside)
        view.addSubview(button)
//        //homeButton
//        homeButton.setImage(UIImage(named: "home2"), for: UIControl.State.normal)
//        homeButton.frame = CGRect(x: barImage.frame.width * 0.17 , y: view.frame.height * 0.9 - 7, width: 65, height: 65)
//        homeButton.addTarget(self, action: #selector(self.homeButtonTapped(_:)), for: .touchUpInside)
//        homeButton.tintColor = .gray
//        view.addSubview(homeButton)
//        //profileButton
//        profileButton.setImage(UIImage(named: "user"), for: UIControl.State.normal)
//        profileButton.frame = CGRect(x: barImage.frame.width * 0.66 + 2, y: view.frame.height * 0.9 - 7, width: 65, height: 65)
//        profileButton.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
//        profileButton.tintColor = .black
//        view.addSubview(profileButton)
        
        // Do any additional setup after loading the view.
        showUserName()
    }
    
    //userNameの変更
    func showUserName(){
        
        //MARK: TODO: userNameの変更
        if let user = Auth.auth().currentUser {
            let userName = String(user.displayName ?? "none")
            userNameLabel.text = userName
        }
        
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
        try! Auth.auth().signOut()
        print("ログアウトした")
        if let controller = storyboard?.instantiateViewController(withIdentifier: "menu"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func btnSetupTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "setup"){
            present(controller, animated: false, completion: nil)
        }
    }
    
    
    @IBAction func btnHelpTapped(_ sender: Any) {
        //外部ブラウザでURLを開く
        let url = NSURL(string: "https://gpcjoy3887.wixsite.com/better-pay-back/blank-2")
        if UIApplication.shared.canOpenURL(url! as URL){
            UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
        }
    }
    
}
