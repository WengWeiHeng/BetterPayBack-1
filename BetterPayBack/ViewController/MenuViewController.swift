//
//  MenuViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import Firebase
import CoreData

var passwordUpDate:String = ""

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let user = Auth.auth().currentUser {
            if let controller = storyboard?.instantiateViewController(withIdentifier: "homeTabBar"){
                present(controller, animated: true, completion: nil)
            }
            
            let userName = String(user.displayName ?? "none")
            print("nowUserName:\(userName)")
            
            
            //coredataでpasswordを保存する
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let moc = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
//            //search条件
//            let searchContent = NSPredicate(format: "haveReturned = true")
//            fetchRequest.predicate = searchContent
            do{
                //結果をresultsに入れる
                let results = try moc.fetch(fetchRequest) as! [PayBack]
                for password in results{
                    //moneyTotal.append((money as AnyObject).value(forKey: "money") as! String)
                    //haventReturnedMoneyArray.append(((money as AnyObject).value(forKey: "haveReturned") != nil))
                    passwordUpDate = password.password ?? "UUUUUU"
                }
            }catch{
                print("passwordCatchFailed(MenuView)")
            }
            
            print("passwordUpDate:\(passwordUpDate)")
        }
        
    }
    

    @IBAction func btnLoginTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "login"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "register"){
            present(controller, animated: true, completion: nil)
        }
    }
    
}
