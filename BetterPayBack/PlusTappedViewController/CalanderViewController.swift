//
//  CalanderViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData

var nameOfRedDot:String = ""
var yearOfRedDot:String = ""
var monthOfRedDot:String = ""
var dayOfRedDot:String = ""
var dateOfRedDot:String = ""
var moneyOfRedDot:String = ""

class CalanderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var calendar: UICollectionView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    let barImage = UIImageView()
    
    //期限を保存する配列
    var redDotArray = [NSManagedObject]()
    //redDotをつけたい日つけを保存する配列
    var redDotDateArray : [String] = []
    
    //calendarCellタップしたらpopupするView
    var calendarPopUpView = CalendarPopUpViewController()
    
    var yearOfCell:String = ""
    var monthOfCell:String = ""
    
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months = ["1",
                  "2",
                  "3",
                  "4",
                  "5",
                  "6",
                  "7",
                  "8",
                  "9",
                  "10",
                  "11",
                  "12"]
    
    
    //月による何日があるかの計算
    var numberOfDaysInThisMonth: Int{
        let dateComponents = DateComponents(year: currentYear, month: currentMonth)
        //let date = Calendar.current.date(from: dateComponents)
        let date = Calendar.current.date(from: dateComponents)!
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    //最初からcountする今日のhitsuke
    var whatDayIsIt: Int{
        let dateComponents = DateComponents(year: currentYear, month: currentMonth)
        let date = Calendar.current.date(from: dateComponents)!
        return Calendar.current.component(.weekday, from: date)
    }
    //computed property
    var howManyItemsShouldIAdd: Int{
        return whatDayIsIt - 1 //(whatDayIsIt = 6 、足すべきitem個数も5だから、whatDayIsIt値を1を引く)
    }
    
    
    
    func numberOfSection(in collectionView: UICollectionView) -> Int{
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth + howManyItemsShouldIAdd
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCollectionViewCell
        
        //cell.backgroundColor = UIColor(red: 230/255, green: 180/255, blue: 50/255, alpha: 1.0)
        cell.backgroundColor  = UIColor.white
        cell.redDot.isHidden = true
        
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            
            //日にちの表示を正しいちにずらす
            if indexPath.row < howManyItemsShouldIAdd{
                textLabel.text = ""
            }else{
                textLabel.text = "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
            }
            
            //今日の日付の所、色変換
            let currentDay2 = Calendar.current.component(.day, from: Date())
            let currentMonth2 = Calendar.current.component(.month, from: Date())
            let currentYear2 = Calendar.current.component(.year, from: Date())
            if indexPath.row + 1 - howManyItemsShouldIAdd == currentDay2 && currentMonth == currentMonth2 && currentYear == currentYear2{
                print("currentDay:\(currentDay2)")
                cell.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
                //cell.redDot.isHidden = false
                
            }else{
                cell.backgroundColor = .white
                //cell.redDot.isHidden = true
            }
            //textLabel.text = "\(indexPath.row + 1)" //1から
            
            
            
            //MARK:まだ返してない、赤いドットをつける
            //haventReturned == true のDateを取る
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let moc = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
            //search条件
            let searchContent = NSPredicate(format: "haveReturned = false")
            fetchRequest.predicate = searchContent
            //FetchRequestする
            do{
                //結果をresultsに入れる
                let results = try moc.fetch(fetchRequest) as! [PayBack]
                
                for info in results{
                    
                    //let returnDot = info.haveReturned
                    let yearDot = info.yearReturn
                    let monthDot = info.monthReturn
                    let dayDot = info.dayReturn
                    let moneyDot = info.money
                    if yearDot == yearOfCell {
                        let d = String(indexPath.row + 1 - howManyItemsShouldIAdd)
                        if dayDot == d && monthDot == monthOfCell{
                            cell.redDot.isHidden = false
                            print("\(yearDot ?? "20xx")/\(monthOfCell)/\(d),¥\(moneyDot ?? "0")")
                        }
                    }else {
                        cell.redDot.isHidden = true
                    }
                    
                    
                }
            }catch{
                print("request error(CountDownViewController3)")
            }
            
            
        }
        
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = indexPath.row + 1 - howManyItemsShouldIAdd
        let beTappedDate = "\(yearOfCell)年\(monthOfCell)月\(day)日"
        if redDotDateArray.contains(beTappedDate) == true {
            print("タップされたcellは：\(beTappedDate)")
            
            
            //search
            let appDel = (UIApplication.shared.delegate as! AppDelegate)
            let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
            let moc = context
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
            //MARK:重複サーチ
            //search条件
            let searchContent = NSPredicate(format: "yearReturn = '\(yearOfCell)' AND monthReturn = '\(monthOfCell)' AND dayReturn = '\(day)'")
            fetchRequest.predicate = searchContent
            
            do{
                let results = try moc.fetch(fetchRequest) as! [PayBack]
                for info in results{
                    nameOfRedDot = info.name ?? "none"
                    moneyOfRedDot = info.money ?? "0"
                }
            }catch{
                print("error(left button)")
            }
            
            
            
            
            
            
            
            
            dateOfRedDot = beTappedDate
            view.addSubview(calendarPopUpView.view)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 0  //cellの左右は0
    }
    
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 0  //cellの上下は0
    }
    
    func collectionView(_ collectionView: UICollectionView, layoutcollectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) -> CGSize{
        let width = collectionView.frame.width / 7
        return CGSize(width: width, height: 60) //cellの横幅はcollectionViewのframe/7,高さは40
    }
    
    func getDataOfRedDot(){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
        //search条件
        let searchContent = NSPredicate(format: "haveReturned = false")
        fetchRequest.predicate = searchContent
        //FetchRequestする
        do{
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            redDotArray = results as [NSManagedObject]
            for info in results{
                //guard let name = info.name else {return}
                guard let year = info.yearReturn else {return}
                guard let month = info.monthReturn else {return}
                guard let day = info.dayReturn else {return}
                
                let fullReturnDate = "\(year)年\(month)月\(day)日"
                redDotDateArray.append(fullReturnDate)
//                //返したお金を保存する配列
//                if info.yearReturn != nil {
//                    let moneyInt = Int(info.money!)!
//                    haveReturnedArray.append(moneyInt)
//                }
            }

        }catch{
            print("request error(CountDownViewController2)")
        }
        print(redDotDateArray)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.dataSource = self
        calendar.delegate = self
        
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
        
        setUp()
        getDataOfRedDot()
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
    
    
    @IBAction func nextMonth(_ sender: Any) {
        currentMonth += 1
        if currentMonth == 13{
            currentMonth = 1
            currentYear += 1
        }
        setUp() //next月を表示され
        
    }
    
    @IBAction func lastMonth(_ sender: Any) {
        currentMonth -= 1
        if currentMonth == 0{
            currentMonth = 12
            currentYear -= 1
        }
        setUp() //前の月を表示され
        
    }
    
    ///calenderの日付けを正しく表示され
    func setUp (){
        print("\(currentYear)/\(currentMonth)") //今月test
        
        timeLabel.text = months[currentMonth - 1] + "月" + "\(currentYear)"
        
        monthOfCell = months[currentMonth-1]
        yearOfCell = String(currentYear)
        
        calendar.reloadData() //今の月の日更新
    
        print("whatDayIsIt：　\(whatDayIsIt)") //12/1 は金曜 (collection view item がまた5個itemを足さなければいけない)
    }
    
    
    
}
