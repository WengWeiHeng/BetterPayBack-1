//
//  LoginViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase
//import CoreData

//user名保存するため
var nowUserName: String = "none"
//nowUserのpasswordを保存するよう
var nowUserPassword : String = "none"

var passwordArray:[String] = []

var savePassword:String = ""

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        emailField.delegate = self
        passwordField.delegate = self
        print("nowUserName:\(nowUserName)")
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
//                    print("nowUserName:\(nowUserName)")
//                }
                //nowPasswordの記録
                //nowUserPassword = password
                
                
//                //coredataでpasswordを保存する
//                let appDel = (UIApplication.shared.delegate as! AppDelegate)
//                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
//                let moc = context
//                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
//                //FetchRequestする
//                do{
//                    //結果をresultsに入れる
//                    let results = try moc.fetch(fetchRequest) as! [PayBack]
//                    for info in results{
//                        info.password = password
//                        nowUserPassword = info.password ?? "??????"
//                        print("nowUserPassword:\(nowUserPassword)")
//                        passwordArray.append(info.password ?? "NNNNNN")
//                        print(passwordArray)
//                    }
//
//                }catch{
//                    print("request error(CountDownViewController)")
//                }



                //nowUserPassword = password
                //print("nowUserPassword:\(nowUserPassword)")
                
                let nowUser = Auth.auth().currentUser
                nowUserName = nowUser?.displayName ?? "none"
                print("nowUserName:\(nowUserName)")
                
                //savePassword = password //!!

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
