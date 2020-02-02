//
//  ViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    //var currentMonth = Calendar.current.component(.month, from: Date())
    
    
    @IBOutlet weak var mainDateCollectionView: UICollectionView!
    
    @IBOutlet weak var middleRetangle: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weekLabel: UILabel!
    
    //    @IBOutlet weak var homeButton: UIButton!
    //    @IBOutlet weak var profileButton: UIButton!
    //
    
    @IBOutlet weak var totalLentLabel: UILabel!
    
    //    var haventReturnMoney: Int = 0
    //    var totalLentMoney: Int = 0
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    let currentDay = Calendar.current.component(.day, from: Date())
    var months = ["1月",
                  "2月",
                  "3月",
                  "4月",
                  "5月",
                  "6月",
                  "7月",
                  "8月",
                  "9月",
                  "10月",
                  "11月",
                  "12月"]
    
    var weekDays = ["Sunday",
                    "Monday",
                    "Tuesday",
                    "Wednesday",
                    "Thursday",
                    "Friday",
                    "Saturday"]
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        dateLabel.layer.borderColor  = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0).cgColor
        dateLabel.layer.borderWidth = 0
        
        middleRetangle.layer.borderWidth = 0.8
        middleRetangle.layer.borderColor = UIColor.darkGray.cgColor
        middleRetangle.layer.shadowColor = UIColor.black.cgColor
        middleRetangle.layer.shadowOffset = CGSize(width: 0, height: 0)
        middleRetangle.layer.shadowOpacity = 0.1
        middleRetangle.layer.shadowRadius = 1
        
        mainDateCollectionView.dataSource = self
        mainDateCollectionView.delegate = self
        
        setCalendar()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //今まで貸した総金額表示
        let getRecordViewControllerFunction = RecordViewController()
        getRecordViewControllerFunction.getData()
        
        //まだ返してない総金額表示
        let getCountDownViewControllerFunction = CountDownViewController()
        getCountDownViewControllerFunction.getHaveReturnedData()
        
        //        sumOfHaventReturnedMoney = sumOfMoney - haveReturndTotalMoney
        
        
        //MARK:別のviewControllerの変数を使う
//        //RecordViewのsumOfHaventReturnedMoney変数をとる
//        let getRecordView = RecordViewController()
//        let getRecordViewsumOfHaventReturnedMoney = getRecordView.sumOfHaventReturnedMoney
//
        
        totalLentLabel.text = "¥\(sumOfHaventReturnedMoney)"
        
        //最初表示位置
        mainDateCollectionView.scrollToItem(at: IndexPath(row:currentDay-3,section:0), at: .left, animated: false)
        
    }
    
    
//    @IBAction func lastMonth(_ sender: Any) {
//        currentMonth -= 1
//        if currentMonth == 0{
//            currentMonth = 12
//            currentYear -= 1
//        }
//        setCalendar()
//    }
//    @IBAction func nextMonth(_ sender: Any) {
//        currentMonth += 1
//        if currentMonth == 13{
//            currentMonth = 1
//            currentYear += 1
//        }
//        setCalendar()
//    }
//
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainDateCell", for: indexPath) as UICollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainDateCell", for: indexPath) as! TopCalendarCollectionViewCell
        cell.backgroundColor  = UIColor.white
        //contents viewに加えた物を　cellのcontentViewのsubviewで探す
        //[0]はcontentviewの一つ目の物
        if let dateTextLabel = cell.contentView.subviews[0] as? UILabel{
            dateTextLabel.text = "\(indexPath.row + 1)" //表示する数値は０からじゃなくて、１から
            
        }
        
        let currentDay = Calendar.current.component(.day, from: Date())
        if indexPath.row == currentDay - 1 {
            cell.layer.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0).cgColor
            cell.collecyionDayLabel.textColor = .white
            cell.collecyionDayLabel.layer.borderWidth = 0
            cell.collecyionDayLabel.layer.shadowOpacity = 0
        }else{
            cell.layer.backgroundColor = UIColor.white.cgColor
            cell.collecyionDayLabel.textColor = .darkGray
            cell.collecyionDayLabel.layer.borderWidth = 0.5
            cell.collecyionDayLabel.layer.shadowColor = UIColor.black.cgColor
            cell.collecyionDayLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
            cell.collecyionDayLabel.layer.shadowOpacity = 0.1
            cell.collecyionDayLabel.layer.shadowRadius = 1
        }
        
        return cell
    }
    
    //日にちの設定
    func setCalendar(){
        monthLabel.text = months[currentMonth - 1]
        
        let currentTodayDate = Calendar.current.component(.day, from: Date())
        dateLabel.text = "\(currentTodayDate)"
        
        let currentTodayWeekday = Calendar.current.component(.weekday, from: Date())
        weekLabel.text = "\(weekDays[currentTodayWeekday - 1])"
        
        mainDateCollectionView.reloadData()
    }
}




