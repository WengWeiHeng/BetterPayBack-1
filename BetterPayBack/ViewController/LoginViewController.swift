//
//  LoginViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase
import CoreData

//user名保存するため
var nowUserName: String = "none"
//nowUserのpasswordを保存するよう
var nowUserPassword : String = "none"

var passwordArray:[String] = []

var savePassword:String = ""

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailBackImage: UIImageView!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var passwordBackImage: UIImageView!
    
    @IBOutlet weak var btnBack: UIButton!
    
    @IBOutlet weak var btnEnter: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //MARK:sizeChange
        let width = view.frame.width
        let height = view.frame.height
        emailBackImage.frame = CGRect(x: width*0.5 - 170, y: height*0.3 - 24, width: 340, height: 48)
        emailField.frame = CGRect(x: width*0.5 - 150, y: height*0.3 - 24, width: 300, height: 48)
        passwordBackImage.frame = CGRect(x: width*0.5 - 170, y: height*0.4 - 24, width: 340, height: 48)
        passwordField.frame = CGRect(x: width*0.5 - 150, y: height*0.4 - 24, width: 300, height: 48)
        
        btnBack.frame = CGRect(x: width*0.5 - 136, y: height*0.5 - 21, width: 272, height: 43)
        btnEnter.frame = CGRect(x: width*0.5 - 136, y: height*0.6 - 21, width: 272, height: 43)
        
        
        emailField.delegate = self
        passwordField.delegate = self
        print("nowUserName:\(nowUserName)")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        Auth.auth().addStateDidChangeListener { (auth, user) in
//            nowUserName = NSUserName()
//        }
//    }

    
    func getPassword(uN:String){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PassWord")
        //search条件
        let searchContent = NSPredicate(format: "userName = '\(uN)'")
        fetchRequest.predicate = searchContent
        
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PassWord]
            for info in results{
                passwordTest = info.password ?? "xxxxxx"
            }
            
        }catch{
            print("get user,password error(PasswordViewController)")
        }
    }
    
    
    
    @IBAction func btnReturnTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func btnEnterTapped(_ sender: Any) {
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        //MARK: TODO:firebase会員登録
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                
                let nowUser = Auth.auth().currentUser
                nowUserName = nowUser?.displayName ?? "none"
                print("nowUserName:\(nowUserName)")
                
                //savePassword = password //!!
                self.getPassword(uN: nowUserName)
                print("passwordTest(Login):\(passwordTest)")

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
