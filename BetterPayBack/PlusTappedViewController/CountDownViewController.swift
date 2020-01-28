//
//  CountDownViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData

//もう返した総金額
var haveReturndTotalMoney : Int = 0


class CountDownViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    let barImage = UIImageView()
    
    
    //返したお金を保存する配列
    var haveReturnedArray : [Int] = []
    
    //期限を保存する配列
    var dateReturnArray = [NSManagedObject]()
    
    var rowHeight: Int = 0
    
    @IBOutlet weak var countDownTableView: UITableView!
    
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
        profileButton.tintColor = .gray
        view.addSubview(profileButton)
        
        // Do any additional setup after loading the view.
        countDownTableView.delegate = self
        countDownTableView.dataSource = self
        
        //tableViewのセルの高さ
        countDownTableView.rowHeight = 150
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        getHaveReturnedData()
        //tabaleView更新
        countDownTableView.reloadData()
        
        
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
    
    //MARK: getData
    func getData(){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LentMoney3")
        
        //FetchRequestする
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            //dateReturnArray = results as! [NSManagedObject]
            dateReturnArray = results as [NSManagedObject]
            
        }catch{
            print("request error(CountDownViewController)")
        }
    }
    
    
    //MARK:getHaveReturnedData
    func getHaveReturnedData(){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LentMoney3")
        //search条件
        let searchContent = NSPredicate(format: "haveReturned = true")
        fetchRequest.predicate = searchContent
        
        //FetchRequestする
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            //dateReturnArray = results as! [NSManagedObject]
            //dateReturnArray = results as [NSManagedObject]
            
            for info in results{
                //返したお金を保存する配列
                if info.money != nil {
                    let moneyInt = Int(info.money!)!
                    haveReturnedArray.append(moneyInt)
                }
            }
            //reduceでmoneyInteger配列の合計を求める
            haveReturndTotalMoney = haveReturnedArray.reduce(0) {(num1: Int, num2: Int) -> Int in
                return num1 + num2
            }
            //まだ返してない総金額
            sumOfHaventReturnedMoney = sumOfMoney - haveReturndTotalMoney
            
            print("もう返した総金額配列：\(haveReturnedArray)")
            print("もう返した総金額：\(haveReturndTotalMoney)")
            print("まだ返してない総金額：\(sumOfHaventReturnedMoney)")
            
            
        }catch{
            print("request error(CountDownViewController2)")
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateReturnArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countDownTableView.dequeueReusableCell(withIdentifier: "countDownCell", for: indexPath) as! CountDownTableViewCell
        
        if let personName = dateReturnArray[indexPath.row].value(forKey: "name") as? String{
            
            //returnDate
            let yearReturn = dateReturnArray[indexPath.row].value(forKey: "yearReturn") as? String
            let monthReturn = dateReturnArray[indexPath.row].value(forKey: "monthReturn") as? String
            let dayReturn = dateReturnArray[indexPath.row].value(forKey: "dayReturn") as? String
            
            //borrowDate
            let yearBorrow = dateReturnArray[indexPath.row].value(forKey: "yearBorrow") as? String
            let monthBorrow = dateReturnArray[indexPath.row].value(forKey: "monthBorrow") as? String
            let dayBorrow = dateReturnArray[indexPath.row].value(forKey: "dayBorrow") as? String
            
            //returnDateの表示
            cell.tillDeadlineLabel.text = "\(yearReturn ?? "00")年\(monthReturn ?? "00")月\(dayReturn ?? "00")日まであと"
            cell.borrowNameLabel.text = "\(personName)"
            cell.borrowNameLabel.font = UIFont.systemFont(ofSize: 25)
            
            //期限まであと何日getする
            let getDaysLeft = daysLeft(year: yearReturn, month: monthReturn, day: dayReturn)
            cell.leftDaysLabel.text = "\(getDaysLeft)"
            //貸し出し日から期限まで何日getする
            let getDaysWent = daysWent(yearB: yearBorrow, monthB: monthBorrow, dayB: dayBorrow, yearR: yearReturn, monthR: monthReturn, dayR: dayReturn)
            
            //wavePercentageをgetする
            let getWavePercentage = wavePercentage(dayLeft: getDaysLeft, dayWent: getDaysWent)
            let cellWidth = self.view.frame.width
            //let cellHeight = self.view.frame.height
            let cellRowHeight = countDownTableView.rowHeight
            //print("cellRowHeight: \(cellRowHeight)")
            
            //waveを表示
            cell.backWaveView.frame = CGRect(x: 10, y: 10, width: cellWidth - 20, height: cellRowHeight - 20)
            cell.backWaveView.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 88/255, alpha: 1)
            
            let waveViewCGRect = CGRect(x: 10, y: 10, width: Double(cellWidth) * getWavePercentage - 20, height: Double(cellRowHeight - 20))
            cell.waveView.frame = waveViewCGRect
            //print("waveViewCGRect:\(waveViewCGRect)")
            cell.waveView.backgroundColor = UIColor(red: 6/255, green: 71/255, blue: 244/255, alpha: 1)
            
            //cell背景がcontrollerの背景色と同じにする
            cell.contentView.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1)
            
            //waveImageの表示
            cell.waveImage.image = UIImage(named: "wave")
            let waveImageX = Double(cellWidth) * getWavePercentage - 20
            let imageCGRect = CGRect(x: waveImageX, y: 10, width: 40, height: Double(cellRowHeight - 20))
            cell.waveImage.frame = imageCGRect
            
            
            
            //MARK:返金表示
            //もう返したかどうか判断して背景色を変わる
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let moc = context
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LentMoney3")
            //search条件
            let searchContent = NSPredicate(format: "haveReturned = true")
            fetchRequest.predicate = searchContent
            //FetchRequestする
            do{
                //結果をresultsに入れる
                let results = try moc.fetch(fetchRequest) as! [PayBack]
                //dataArray = results as [NSManagedObject]
                
                //index記録用
                var indexR : Int = 0
                
                for info in results{
                    indexR += 1
                    let returnInfo = dateReturnArray[indexPath.row].value(forKey: "haveReturned") as? Bool
                    if returnInfo == true {
                        
                        cell.leftDaysLabel.text = ""
                        cell.tillDeadlineLabel.text = "返金した"
                        cell.tillDeadlineLabel.font = UIFont.systemFont(ofSize: 40)
                        cell.dayLabel.text = ""
                        cell.blackView.frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: countDownTableView.rowHeight - 20)
                        cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
                        print("indexR:\(indexR)")
                        print("\(info.name ?? "何々")さん、haveReturned：\(info.haveReturned)")
                    }else {
                        
                        cell.tillDeadlineLabel.font = UIFont.systemFont(ofSize: 18)
                        cell.dayLabel.text = "日"
                        cell.blackView.frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 20, height: countDownTableView.rowHeight - 20)
                        cell.blackView.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
                    }
                    
                    
                }
            }catch{
                print("request error(CountDownViewController3)")
            }
            
        }
        
        //let x =
        
        
        return cell
    }
    
    
    //MARK:左スワップ
    //cellに削除と通知するボタンを追加
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
                moc.delete(dataArray[indexPath.row])
                //save
                do{
                    try moc.save()
                }catch{
                    print("save error(delete)")
                }
                //recordArray 再び読み込み
                self.getData()
                //tableview reload 更新する
                self.countDownTableView.reloadData()
                
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
        
        let notification = UITableViewRowAction(style: .normal, title: "通知") { (action, indexPath) in
            
            //alert
            let alert = UIAlertController(title: "アラート", message: "Lineメッセージを送りますか？", preferredStyle: UIAlertController.Style.alert)
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                
                
                //search
                let appDel = (UIApplication.shared.delegate as! AppDelegate)
                let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
                let moc = context
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LentMoney3")
                //search条件
                let searchContent = NSPredicate(format: "name = '\(self.dateReturnArray[indexPath.row].value(forKey: "name") as! String)'","money")
                fetchRequest.predicate = searchContent
                
                //var sendNameField = ""
                var sendMoneyField = ""
                var sendLeftField = ""
                do{
                    let results = try moc.fetch(fetchRequest) as! [PayBack]
                    for info in results{
                        //let sendName = (info as AnyObject).value(forKey: "name") as! String
                        let sendMoney = (info as AnyObject).value(forKey: "money") as! String
                        let sendYearReturn = (info as AnyObject).value(forKey: "yearReturn") as! String
                        let sendMonthReturn = (info as AnyObject).value(forKey: "monthReturn") as! String
                        let sendDayReturn = (info as AnyObject).value(forKey: "dayReturn") as! String
                        //                        let sendYearBorrow = (info as AnyObject).value(forKey: "yearBorrow") as! String
                        //                        let sendMonthBorrow = (info as AnyObject).value(forKey: "monthBorrow") as! String
                        //                        let sendDayBorrow = (info as AnyObject).value(forKey: "dayBorrow") as! String
                        //期限まであと何日getする
                        let getDaysLeft = self.daysLeft(year: sendYearReturn, month: sendMonthReturn, day: sendDayReturn)
                        
                        //print("name = \(sendName)")
                        print("money = \(sendMoney)")
                        print("getDaysLeft = \(getDaysLeft)")
                        //sendNameField = sendName
                        sendMoneyField = sendMoney
                        sendLeftField = String(getDaysLeft)
                        //save
                        //try moc.save()
                        
                    }
                }catch{
                    print("error(left button)")
                }
                
                
                self.lineSend(leftDays: sendLeftField,money: sendMoneyField)
                
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
        
        notification.backgroundColor = UIColor.blue
        
        return [delete, notification]
    }
    
    //MARK:右スワップ
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let moneyHavedReturn = UIContextualAction(style: .normal, title: "返金\nした") { (action, view, completionHeader) in
            
            //alert表示
            let alert = UIAlertController(title: "アラート", message: "確かに返しましたか？", preferredStyle: UIAlertController.Style.alert)
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "確定", style: UIAlertAction.Style.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
                self.haventReturnedMoney(index: indexPath.row)
                self.getHaveReturnedData()
                //tableViewの更新
                self.countDownTableView.reloadData()
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
        moneyHavedReturn.backgroundColor = UIColor(red: 130/255, green: 200/255, blue: 39/255, alpha: 1)
        let moneyHavedReturnButton = UISwipeActionsConfiguration(actions: [moneyHavedReturn])
        return moneyHavedReturnButton
    }
    
    //MARK: まだ返してないお金計算
    func haventReturnedMoney(index: Int){
        
        //search
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "LentMoney3")
        //MARK:重複サーチ
        //search条件
        let searchContent = NSPredicate(format: "name = '\(dateReturnArray[index].value(forKey: "name") as! String)' AND yearBorrow = '\(dateReturnArray[index].value(forKey: "yearBorrow") as! String)' AND monthBorrow = '\(dateReturnArray[index].value(forKey: "monthBorrow") as! String)' AND dayBorrow = '\(dateReturnArray[index].value(forKey: "dayBorrow") as! String)'","haveReturned")
        fetchRequest.predicate = searchContent
        
        do{
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            for info in results{
                print("name = \((info as AnyObject).value(forKey: "name") as! String)")
                print("money = \((info as AnyObject).value(forKey: "money") as! String)")
                print("haveReturned = \((info as AnyObject).value(forKey: "haveReturned") as! Bool)")
                //(info as AnyObject).value(forKey: "haveReturned")
                info.haveReturned = true
                
                //save
                try moc.save()
                
            }
        }catch{
            print("error(left button)")
        }
        
        countDownTableView.reloadData()
        print("haveReturned(2) = \(dateReturnArray[index].value(forKey: "haveReturned") as! Bool)")
        
    }
    
    //MARK:Line通知
    //Lineで通知を送る
    func lineSend(leftDays : String, money : String){
        let urlscheme: String = "line://msg/text"
        let message = "元気？実はあまり元気ではないでしょ？最近忘れぽっくない？知ってたよ。だって貸したお金帰ってこないもん。忘れたでしょ？友たちとして注意してあげるから、もう忘れないでね♪\n返金の日数が迫っています。（あと\(leftDays)日）\n返金残額\(money)円です。"
        
        // line:/msg/text/(メッセージ)
        let urlstring = urlscheme + "/" + message
        
        // URLエンコード
        guard let encodedURL = urlstring.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            return
        }
        
        // URL作成
        guard let url = URL(string: encodedURL) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: { (succes) in
                    // LINEアプリ表示成功
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // LINEアプリがない場合
            let alertController = UIAlertController(title: "エラー",
                                                    message: "LINEがインストールされていません",
                                                    preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
            present(alertController, animated: true, completion: nil)
        }
        
    }
    
    //期限まであと何日の計算
    func daysLeft(year: String?, month: String?, day: String?) -> Int {
        
        let today = Date()
        let todayStartOfDay = Calendar.current.startOfDay(for: today)
        //print("今日: \(todayStartOfDay)")
        
        guard let year = year, let month = month, let day = day else { return 0 }
        
        let lastDate = DateComponents(calendar: Calendar.current, year: Int(year), month: Int(month), day: Int(day)).date!
        let lastDateStartOfDay = Calendar.current.startOfDay(for: lastDate)
        //print("期限: \(lastDateStartOfDay)")
        
        //期限までの日の計算
        let tillNowDays = Calendar.current.dateComponents([.day], from: todayStartOfDay, to: lastDateStartOfDay).day!
        print("返金期限まであと: \(tillNowDays)日")
        
        return tillNowDays
        
    }
    
    //貸し出し日から期限まで何日
    func daysWent(yearB: String?, monthB: String?, dayB: String?,
                  yearR: String?, monthR: String?, dayR: String?) -> Int{
        
        guard let yearB = yearB, let monthB = monthB, let dayB = dayB,
            let yearR = yearR, let monthR = monthR, let dayR = dayR else { return 0 }
        let borrowDate = DateComponents(calendar: Calendar.current, year: Int(yearB), month: Int(monthB), day: Int(dayB)).date!
        let returnDate = DateComponents(calendar: Calendar.current, year: Int(yearR), month: Int(monthR), day: Int(dayR)).date!
        let borrowDateStartOfDate = Calendar.current.startOfDay(for: borrowDate)
        let returnDateStartOfDate = Calendar.current.startOfDay(for: returnDate)
        //print("貸し出し日： \(borrowDateStartOfDate)")
        //計算
        let totalDays = Calendar.current.dateComponents([.day], from: borrowDateStartOfDate, to: returnDateStartOfDate).day!
        print("貸し出し日から期限まで: \(totalDays)日")
        
        return totalDays
    }
    
    //TODO:waveの表示
    func wavePercentage(dayLeft: Int?, dayWent: Int?) -> Double {
        guard let dayLeft = dayLeft, let dayWent = dayWent else { return 0 }
        let percentage = Double(dayLeft) / Double(dayWent)
        print("waveのpercentage: \(percentage)\n")
        return 1-percentage
    }
    
    
    
}
