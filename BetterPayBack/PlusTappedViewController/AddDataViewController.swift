//
//  AddDataViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData

class AddDataViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var moneyField: UITextField!
    @IBOutlet weak var reasonField: UITextField!
    
    @IBOutlet weak var yearBorrow: UITextField!
    @IBOutlet weak var monthBorrow: UITextField!
    @IBOutlet weak var dayBorrow: UITextField!
    @IBOutlet weak var hourBorrow: UITextField!
    @IBOutlet weak var minuteBorrow: UITextField!
    
    @IBOutlet weak var yearReturn: UITextField!
    @IBOutlet weak var monthReturn: UITextField!
    @IBOutlet weak var dayReturn: UITextField!
    @IBOutlet weak var hourReturn: UITextField!
    @IBOutlet weak var minuteReturn: UITextField!
    
    
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        returnButton.layer.cornerRadius = 30.0
        returnButton.layer.backgroundColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1.0).cgColor
        returnButton.layer.cornerRadius = 25
        
        checkButton.layer.cornerRadius = 30.0
        checkButton.layer.backgroundColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1.0).cgColor
        checkButton.layer.cornerRadius = 25
        
        
        
        nameField.delegate = self
        moneyField.delegate = self
        reasonField.delegate = self
        yearBorrow.delegate = self
        monthBorrow.delegate = self
        dayBorrow.delegate = self
        hourBorrow.delegate = self
        minuteBorrow.delegate = self
        yearReturn.delegate = self
        monthReturn.delegate = self
        dayReturn.delegate = self
        hourReturn.delegate = self
        minuteReturn.delegate = self
        
        
        
    }
    
    //keyboardを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
        
    }
    
    
    
    @IBAction func checkBtnTapped(_ sender: Any) {
        //saveするため
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        let personEntity = NSEntityDescription.entity(forEntityName: "PayBack", in: moc)
        
        //new dataを作る
        let newPerson = NSManagedObject(entity: personEntity!, insertInto: moc)
        //atributeを加入
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
    
    
    
    @IBAction func btnReturnTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "homeTabBar"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
}
