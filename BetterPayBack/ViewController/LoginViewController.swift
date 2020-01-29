//
//  LoginViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase

//user名保存するため
var nowUserName: String = "none"
//nowUserのpasswordを保存するよう
var nowUserPassword : String = "none"

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    //    override func viewWillAppear(_ animated: Bool) {
    //        Auth.auth().addStateDidChangeListener { (auth, user) in
    //            nowUserName = NSUserName()
    //        }
    //    }
    
    
    @IBAction func btnReturnTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func btnEnterTapped(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        //MARK: TODO:firebase会員登録
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {

                //                //userName変更
                //                Auth.auth().addStateDidChangeListener { (auth, user) in
                //                    nowUserName = NSUserName()
                //                    print(NSUserName())
                //                }
                //nowPasswordの記録
                nowUserPassword = password
                print("nowUserPassword:\(nowUserPassword)")

                self.dismiss(animated: false, completion: nil)

            }else {
                print("Error loging in: \(error!.localizedDescription)")
                //error loging アラート
                let alert = UIAlertController(title: "登録エラー", message: nil, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        
    }
    
    
    
    
}
