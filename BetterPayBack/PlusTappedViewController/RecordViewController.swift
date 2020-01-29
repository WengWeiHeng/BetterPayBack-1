//
//  RecordViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData

////総金額
//var sumOfMoney:Int = 0
////まだ返してないお金
//var sumOfHaventReturnedMoney:Int = 0
////データ保存する配列
//var dataArray = [NSManagedObject]()


class RecordViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    
    //総金額
    var sumOfMoney:Int = 0
    //まだ返してないお金
    var sumOfHaventReturnedMoney:Int = 0
    //データ保存する配列
    var dataArray = [NSManagedObject]()
    
    
    @IBOutlet weak var recordTableView: UITableView!
    @IBOutlet weak var recordSearchBar: UISearchBar!
    
    @IBOutlet weak var barImage: UIImageView!
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //recordTableViewのdatasource,delegate
        recordTableView.dataSource = self
        recordTableView.delegate = self
        
        //MARK:fake plus button
        barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
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
        profileButton.tintColor = .gray
        view.addSubview(profileButton)
        
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        //databaseの中にあるデータを取得して、examArrayに入れる
        getData()
        //まだ返してない総金額表示
        let getCountDownViewControllerFunction = CountDownViewController()
        getCountDownViewControllerFunction.getHaveReturnedData()
        //tabaleView更新
        recordTableView.reloadData()
    }
    
    
    //MARK: getData
    func getData(){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
        //FetchRequestする
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            dataArray = results as [NSManagedObject]
            
            //moneyを保存する配列
            //var moneyTotal:[NSString] = []
            var moneyTotal:[String] = []
            
            for money in results{
                moneyTotal.append((money as AnyObject).value(forKey: "money") as! String)
                //haventReturnedMoneyArray.append(((money as AnyObject).value(forKey: "haveReturned") != nil))
                
            }
            
            //money配列をInt型に変換
            var moneyIntegers: [Int] = []
            for str in moneyTotal {
                moneyIntegers.append(Int(str)!)
            }
            print("金額配列：\(moneyIntegers)")
            //reduceでmoneyInteger配列の合計を求める
            sumOfMoney = moneyIntegers.reduce(0) {(num1: Int, num2: Int) -> Int in
                return num1 + num2
            }
            print("総金額：\(sumOfMoney)")
            
            
        }catch{
            print("request error")
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2 = recordTableView.dequeueReusableCell(withIdentifier: "recordCell", for: indexPath) as! RecordTableViewCell
        if let personName3 = dataArray[indexPath.row].value(forKey: "name") as? String{
            let money = dataArray[indexPath.row].value(forKey: "money") as? String
            //let money = dataArray[indexPath.row].value(forKey: "money") as? Int32
            
            let yearBorrow = dataArray[indexPath.row].value(forKey: "yearBorrow") as? String
            let monthBorrow = dataArray[indexPath.row].value(forKey: "monthBorrow") as? String
            let dayBorrow = dataArray[indexPath.row].value(forKey: "dayBorrow") as? String
            let hourBorrow = dataArray[indexPath.row].value(forKey: "hourBorrow") as? String
            let minuteBorrow = dataArray[indexPath.row].value(forKey: "minuteBorrow") as? String
            
            let yearReturn = dataArray[indexPath.row].value(forKey: "yearReturn") as? String
            let monthReturn = dataArray[indexPath.row].value(forKey: "monthReturn") as? String
            let dayReturn = dataArray[indexPath.row].value(forKey: "dayReturn") as? String
            let hourReturn = dataArray[indexPath.row].value(forKey: "hourReturn") as? String
            let minuteReturn = dataArray[indexPath.row].value(forKey: "minuteReturn") as? String
            
            let reason = dataArray[indexPath.row].value(forKey: "reason") as? String
            
            let borrowTime: String = "貸し日付：\(yearBorrow ?? "__")/\(monthBorrow ?? "__")/\(dayBorrow ?? "__")\n\(hourBorrow ?? "__")時\(minuteBorrow ?? "__")分"
            let returnTime: String = "期限：\(yearReturn ?? "__")/\(monthReturn ?? "__")/\(dayReturn ?? "__")\n\(hourReturn ?? "__")時\(minuteReturn ?? "__")分"
            
            cell2.nameLabel.text = "名前：\(personName3)"
            cell2.borrowTimeLabel.text = "\(borrowTime)"
            cell2.moneyLabel.text = "金額：\(money ?? "0")"
            //cell2.moneyLabel.text = "金額：\(money ?? 0)"
            cell2.returnTimeLabel.text = "\(returnTime)"
            cell2.reasonLabel.text = "理由：\(reason ?? "無し")"
            
            
        }
        
        return cell2
    }
    
    //cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    
    //MARK: cellの削除
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "削除") { (action, indexPath) in
            
            //alert
            let alert = UIAlertController(title: "アラート", message: "本当に削除しますか？", preferredStyle: UIAlertController.Style.alert)
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                
                //ManagedObject Contextを取り出す
                let appDel = (UIApplication.shared.delegate as! AppDelegate)
                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
                let moc = context
                //選択されたcellのデータを削除
                //moc.deletedObjects(dataArray[indexPath.row])
                moc.delete(self.dataArray[indexPath.row])
                //save
                do{
                    try moc.save()
                }catch{
                    print("save error(delete)")
                }
                //recordArray 再び読み込み
                self.getData()
                //tableview reload 更新する
                self.recordTableView.reloadData()
                
            })
            // キャンセルボタン
            let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
            })
            
            alert.addAction(defaultAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            
        }
        
        return [delete]
        
    }
    
    
    
    //MARK: searchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
        
        if (searchBar.text != ""){
            
            let searchContent = NSPredicate(format: "%K contains[c] %@","name", recordSearchBar.text!)
            
            fetchRequest.predicate = searchContent
        }
        
        
        do{
            let results = try moc.fetch(fetchRequest)
            dataArray = results as! [NSManagedObject]
        }catch{
            print("error(search bar)")
        }
        
        recordTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.recordSearchBar.endEditing(true)
        
    }
    
    
    
    @IBAction func tapScreen(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    
    
    
}


