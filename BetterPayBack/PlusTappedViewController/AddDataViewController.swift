//
//  AddDataViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData
import Firebase



class AddDataViewController: UIViewController,UITextFieldDelegate,UIScrollViewDelegate {
    
    //userTotalMoney保存する配列
    //var userTotalMoneyArray = [NSManagedObject]()
    var userTotalMoneyArrayInt : [Int] = []
    
    var sumOfUserTotalMoneyArrayInt : Int = 0
    
    //textFieldがkeyBoardに隠されないように
    var scrollView = UIScrollView()
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var borrowLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var returnLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    
    
    @IBOutlet weak var yearB: UIImageView!
    @IBOutlet weak var monthB: UIImageView!
    @IBOutlet weak var dayB: UIImageView!
    @IBOutlet weak var hourB: UIImageView!
    @IBOutlet weak var minuteB: UIImageView!
    
    
    @IBOutlet weak var yearR: UIImageView!
    @IBOutlet weak var monthR: UIImageView!
    @IBOutlet weak var dayR: UIImageView!
    @IBOutlet weak var hourR: UIImageView!
    @IBOutlet weak var monuteR: UIImageView!
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var nameFieldImg: UIImageView!
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var moneyFieldImg: UIImageView!
    @IBOutlet weak var reasonField: UITextField!
    @IBOutlet weak var reasonImg: UIImageView!
    
    @IBOutlet weak var yearBorrow: UITextField!
    @IBOutlet weak var yearBorrowImg: UIImageView!
    @IBOutlet weak var monthBorrow: UITextField!
    @IBOutlet weak var monthBorrowImg: UIImageView!
    @IBOutlet weak var dayBorrow: UITextField!
    @IBOutlet weak var dayBorrowImg: UIImageView!
    @IBOutlet weak var hourBorrow: UITextField!
    @IBOutlet weak var hourBorrowImg: UIImageView!
    @IBOutlet weak var minuteBorrow: UITextField!
    @IBOutlet weak var minuteBorrowImg: UIImageView!
    
    @IBOutlet weak var yearReturn: UITextField!
    @IBOutlet weak var yearReturnImg: UIImageView!
    @IBOutlet weak var monthReturn: UITextField!
    @IBOutlet weak var monthReturnImg: UIImageView!
    @IBOutlet weak var dayReturn: UITextField!
    @IBOutlet weak var dayReturnImg: UIImageView!
    @IBOutlet weak var hourReturn: UITextField!
    @IBOutlet weak var hourReturnImg: UIImageView!
    @IBOutlet weak var minuteReturn: UITextField!
    @IBOutlet weak var minuteReturnImg: UIImageView!
    
    @IBOutlet weak var nameKome: UILabel!
    @IBOutlet weak var borrowKome: UILabel!
    @IBOutlet weak var moneyKome: UILabel!
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //MARK:sizeChange
        let width = view.frame.width
        let height = view.frame.height
        nameLabel.frame = CGRect(x: width*0.2 - 20, y: height*0.24 - 12, width: 41, height: 24)
        nameFieldImg.frame = CGRect(x: width*0.5 - width*0.39, y: height*0.29 - height*0.025, width: width*0.78, height: height*0.05)//324 48
        nameField.frame = CGRect(x: width*0.5 - width*0.32, y: height*0.29 - height*0.025, width: width*0.67, height: height*0.05)//280 48
        nameKome.frame = CGRect(x: width*0.93 - 15, y: height*0.29 - 17, width: 31, height: 34)//31 34
        
        borrowLabel.frame = CGRect(x: width*0.2 - 20, y: height*0.35 - 12, width: 82, height: 24)
        yearBorrowImg.frame = CGRect(x: width*0.11, y: height*0.39 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        yearBorrow.frame = CGRect(x: width*0.15, y: height*0.39 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        yearB.frame = CGRect(x: width*0.26 , y: height*0.39 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        monthBorrowImg.frame = CGRect(x: width*0.38, y: height*0.39 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        monthBorrow.frame = CGRect(x: width*0.42, y: height*0.39 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        monthB.frame = CGRect(x: width*0.53 , y: height*0.39 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        dayBorrowImg.frame = CGRect(x: width*0.65, y: height*0.39 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        dayBorrow.frame = CGRect(x: width*0.69, y: height*0.39 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        dayB.frame = CGRect(x: width*0.80 , y: height*0.39 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        hourBorrowImg.frame = CGRect(x: width*0.11, y: height*0.455 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        hourBorrow.frame = CGRect(x: width*0.15, y: height*0.455 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        hourB.frame = CGRect(x: width*0.26 , y: height*0.455 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        minuteBorrowImg.frame = CGRect(x: width*0.38, y: height*0.455 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        minuteBorrow.frame = CGRect(x: width*0.42, y: height*0.455 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        minuteB.frame = CGRect(x: width*0.53 , y: height*0.455 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        borrowKome.frame = CGRect(x: width*0.93 - 15, y: height*0.39 - 17, width: 31, height: 34)//31 34
        moneyLabel.frame = CGRect(x: width*0.2 - 20, y: height*0.5 - 12, width: 41, height: 24)
        moneyFieldImg.frame = CGRect(x: width*0.5 - width*0.39, y: height*0.55 - height*0.025, width: width*0.78, height: height*0.05)//324 48
        moneyField.frame = CGRect(x: width*0.5 - width*0.32, y: height*0.55 - height*0.025, width: width*0.67, height: height*0.05)//280 48
        moneyKome.frame = CGRect(x: width*0.93 - 15, y: height*0.55 - 17, width: 31, height: 34)//31 34
        returnLabel.frame = CGRect(x: width*0.2 - 20, y: height*0.615 - 12, width: 82, height: 24)
        yearReturnImg.frame = CGRect(x: width*0.11, y: height*0.655 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        yearReturn.frame = CGRect(x: width*0.15, y: height*0.655 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        yearR.frame = CGRect(x: width*0.26 , y: height*0.655 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        monthReturnImg.frame = CGRect(x: width*0.38, y: height*0.655 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        monthReturn.frame = CGRect(x: width*0.42, y: height*0.655 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        monthR.frame = CGRect(x: width*0.53 , y: height*0.655 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        dayReturnImg.frame = CGRect(x: width*0.65, y: height*0.655 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        dayReturn.frame = CGRect(x: width*0.69, y: height*0.655 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        dayR.frame = CGRect(x: width*0.80 , y: height*0.655 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        hourReturnImg.frame = CGRect(x: width*0.11, y: height*0.72 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        hourReturn.frame = CGRect(x: width*0.15, y: height*0.72 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        hourR.frame = CGRect(x: width*0.26 , y: height*0.72 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        minuteReturnImg.frame = CGRect(x: width*0.38, y: height*0.72 - height*0.02, width: width*0.21, height: height*0.04)//90 35
        minuteReturn.frame = CGRect(x: width*0.42, y: height*0.72 - height*0.02, width: width*0.18, height: height*0.04)//75 35
        monuteR.frame = CGRect(x: width*0.53 , y: height*0.72 - height*0.02, width: width*0.09, height: height*0.04)//38 38
        reasonLabel.frame = CGRect(x: width*0.2 - 20, y: height*0.77 - 12, width: 41, height: 24)
        reasonImg.frame = CGRect(x: width*0.5 - width*0.39, y: height*0.81 - height*0.025, width: width*0.78, height: height*0.05)//324 48
        reasonField.frame = CGRect(x: width*0.5 - width*0.32, y: height*0.81 - height*0.025, width: width*0.67, height: height*0.05)//280 48
        
        returnButton.frame = CGRect(x: width*0.5 - width*0.37, y: height*0.9 - height*0.025, width: 130, height: 64)//130 64
        checkButton.frame = CGRect(x: width*0.5 + width*0.05, y: height*0.9 - height*0.025, width: 130, height: 64)//130 64
        
        
        
        returnButton.layer.cornerRadius = 30.0
        returnButton.layer.backgroundColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1.0).cgColor
        returnButton.layer.cornerRadius = 25
        
        checkButton.layer.cornerRadius = 30.0
        checkButton.layer.backgroundColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1.0).cgColor
        checkButton.layer.cornerRadius = 25
        
        
        
        nameField.delegate = self //tag:1
        moneyField.delegate = self //tag:7
        reasonField.delegate = self //tag:13
        yearBorrow.delegate = self //tag:2
        monthBorrow.delegate = self //tag:3
        dayBorrow.delegate = self //tag:4
        hourBorrow.delegate = self //tag:5
        minuteBorrow.delegate = self //tag:6
        yearReturn.delegate = self //tag:8
        monthReturn.delegate = self //tag:9
        dayReturn.delegate = self //tag:10
        hourReturn.delegate = self //tag:11
        minuteReturn.delegate = self //tag:12
        
        nameField.tag = 1
        yearBorrow.tag = 2
        monthBorrow.tag = 3
        dayBorrow.tag = 4
        hourBorrow.tag = 5
        minuteBorrow.tag = 6
        moneyField.tag = 7
        yearReturn.tag = 8
        monthReturn.tag = 9
        dayReturn.tag = 10
        hourReturn.tag = 11
        minuteReturn.tag = 12
        reasonField.tag = 13
        
        
        scrollView.delegate = self
        scrollView.frame.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
 
        view.addSubview(returnButton)
        view.addSubview(checkButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        view.bringSubviewToFront(nameField)
//        view.bringSubviewToFront(returnButton)
//        view.bringSubviewToFront(checkButton)
 
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag >= 7 && textField.tag <= 13{
            //self.configureObserver()
            print("move")
            scrollView.addSubview(moneyField)
            scrollView.addSubview(yearReturn)
            scrollView.addSubview(monthReturn)
            scrollView.addSubview(dayReturn)
            scrollView.addSubview(hourReturn)
            scrollView.addSubview(minuteReturn)
            scrollView.addSubview(reasonField)
            view.addSubview(scrollView)
            
            configureObserver()
            
//            view.bringSubviewToFront(nameField)
//            view.bringSubviewToFront(returnButton)
//            view.bringSubviewToFront(checkButton)
            view.bringSubviewToFront(nameField)
            view.bringSubviewToFront(yearBorrow)
            view.bringSubviewToFront(monthBorrow)
            view.bringSubviewToFront(dayBorrow)
            view.bringSubviewToFront(hourBorrow)
            view.bringSubviewToFront(minuteBorrow)
            view.bringSubviewToFront(returnButton)
            view.bringSubviewToFront(checkButton)
        }else{
            print("don't move")
            //scrollView.removeFromSuperview()
            //nameField.removeFromSuperview()
            
            view.bringSubviewToFront(nameField)
            view.bringSubviewToFront(yearBorrow)
            view.bringSubviewToFront(monthBorrow)
            view.bringSubviewToFront(dayBorrow)
            view.bringSubviewToFront(hourBorrow)
            view.bringSubviewToFront(minuteBorrow)
            view.bringSubviewToFront(returnButton)
            view.bringSubviewToFront(checkButton)
        }
        
        return true
    }
    

    
    //keyboardを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //self.view.endEditing(true)
        moneyField.resignFirstResponder()
        yearReturn.resignFirstResponder()
        monthReturn.resignFirstResponder()
        dayReturn.resignFirstResponder()
        hourReturn.resignFirstResponder()
        minuteReturn.resignFirstResponder()
        reasonField.resignFirstResponder()
        return true
        
    }
    
    // Notificationを設定
    func configureObserver() {
        
        let notification = NotificationCenter.default
        
        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notification.addObserver(
            self,
            selector: #selector(self.keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // Notificationを削除
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(notification:Notification?){
        let rect = (notification?.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -(rect?.size.height)!)
        }
    }
    
    @objc func keyboardWillHide(notification:Notification?){
        let duration: TimeInterval? = notification?.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? Double
        UIView.animate(withDuration: duration!) {
            self.view.transform = CGAffineTransform.identity
        }
    }
    
    
    
    @IBAction func checkBtnTapped(_ sender: Any) {
        
        //入力したかどうかチェック
        if nameField.text == "" || moneyField.text == "" || yearBorrow.text == "" || monthBorrow.text == "" || dayBorrow.text == ""{
            
            //alert表示
            let alert = UIAlertController(title: "アラート", message: "＊付いている欄入力未完了", preferredStyle: UIAlertController.Style.alert)
            
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
            
            
        }else{
            //saveするため
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let moc = context
            let personEntity = NSEntityDescription.entity(forEntityName: "PayBack", in: moc)
            
            //new dataを作る
            let newPerson = NSManagedObject(entity: personEntity!, insertInto: moc)
            
            //atributeを加入
            let nowUserDataId = getUserName() //どのuserのdataを判断
            newPerson.setValue(nowUserDataId, forKey: "dataID")
            
            newPerson.setValue(nameField.text, forKey: "name")
            newPerson.setValue(moneyField.text, forKey: "money")
            
            newPerson.setValue(yearBorrow.text, forKey: "yearBorrow")
            newPerson.setValue(monthBorrow.text, forKey: "monthBorrow")
            newPerson.setValue(dayBorrow.text, forKey: "dayBorrow")
            newPerson.setValue(hourBorrow.text, forKey: "hourBorrow")
            newPerson.setValue(minuteBorrow.text, forKey: "minuteBorrow")
            
            newPerson.setValue(yearReturn.text, forKey: "yearReturn")
            newPerson.setValue(monthReturn.text, forKey: "monthReturn")
            newPerson.setValue(dayReturn.text, forKey: "dayReturn")
            newPerson.setValue(hourReturn.text, forKey: "hourReturn")
            newPerson.setValue(minuteReturn.text, forKey: "minuteReturn")
            
            newPerson.setValue(reasonField.text, forKey: "reason")
            
            //MARK:別のviewControllerの変数を使う
            //        //RecordViewのsumOfMoney変数をとる
            //        let getRecordView = RecordViewController()
            //        let getRecordViewSumOfMoney = getRecordView.sumOfMoney
            
            newPerson.setValue(sumOfMoney, forKey: "totalMoney")
            
            //MARK:TestReturn
            newPerson.setValue(false, forKey: "haveReturned")
            
            newPerson.setValue(nowUserPassword, forKey: "password")
            
            let m : String = moneyField.text!
            let mInt = Int(m)!
            userTotalMoneyArrayInt.append(mInt)
            //reduceでmoneyInteger配列の合計を求める
            sumOfUserTotalMoneyArrayInt = userTotalMoneyArrayInt.reduce(0) {(num1: Int, num2: Int) -> Int in
                return num1 + num2
            }
            
            //getUserTotalMoneyData(uN: nowUserName)
            
            
            //save
            do{
                try moc.save()
                
            }catch{
                print("save error")
            }
            
            //navigationController?.popToRootViewController(animated: true)
            if let controller = storyboard?.instantiateViewController(withIdentifier: "record"){
                present(controller, animated: true, completion: nil)
            }
            
            
        }
        
        
        
        
        
    }
    
    //MARK:userTotalMoney
    func getUserTotalMoneyData(uN:String){
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
            //userTotalMoneyArray = results as [NSManagedObject]
            for info in results{
                info.userTotalMoney = Int32(sumOfUserTotalMoneyArrayInt)
                //userTotalMoneyArray[0].value(forKey: "userTotalMoney") as! Int32
            }

        }catch{
            print("get userTotalMoney error(AddDataViewController)")
        }
    }
    
    //userName記録
    func getUserName() -> String{
        var userName = ""
        if let user = Auth.auth().currentUser {
            userName = String(user.displayName ?? "none")
            
        }
        print("nowUserDataId:\(userName)")
        return userName
    }
    
    
    
    @IBAction func btnReturnTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "homeTabBar"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
}
