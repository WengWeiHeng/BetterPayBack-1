//
//  RegisterViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase
import CoreData

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        userNameField.delegate = self
        passwordField.delegate = self
    }
    
    @IBAction func btnReturnTapped(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func btnEnterTapped(_ sender: Any) {
        
        guard let userName = userNameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        
        //MARK:TODO:firebase会員登録
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil{
                print("新規ユーザー作成した")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("表示するユーザー名が変更された")
                        self.newPassword(us:userName,pw:password)
                        self.dismiss(animated: false, completion: nil)
                    }
                }
            }else {
                print("Error creating user: \(error!.localizedDescription)")
            }
            
//            self.newPassword(us:userName,pw:password)
            
        }
        
        
        
    }
    
    func newPassword(us:String,pw:String){
        //MARK:database
        //saveするため
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        let passwordEntity = NSEntityDescription.entity(forEntityName: "PassWord", in: moc)
        //new dataを作る
        let newPassword = NSManagedObject(entity: passwordEntity!, insertInto: moc)
        newPassword.setValue(us, forKey: "userName")
        newPassword.setValue(pw, forKey: "password")
        
        let newTotalMoney = 0
        newPassword.setValue(newTotalMoney, forKey: "userTotalMoney")
        
        
        
        //save
        do{
            print("us:\(us),pw:\(pw),newTotalMoney:\(newTotalMoney)")
            try moc.save()
            
        }catch{
            print("save error")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameField:
            userNameField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            userNameField.becomeFirstResponder()
            passwordField.resignFirstResponder()
            break
        default:
            break
        }
        return true
    }
    
    
}
