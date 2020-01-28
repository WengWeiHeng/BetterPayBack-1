//
//  CalanderViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

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
    
    
    
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        //cell.backgroundColor = UIColor(red: 230/255, green: 180/255, blue: 50/255, alpha: 1.0)
        cell.backgroundColor  = UIColor.white
        
        if let textLabel = cell.contentView.subviews[0] as? UILabel{
            
            //日にちの表示を正しいちにずらす
            if indexPath.row < howManyItemsShouldIAdd{
                textLabel.text = ""
            }else{
                textLabel.text = "\(indexPath.row + 1 - howManyItemsShouldIAdd)"
            }
            
            //今日の日付の所、色変換
            let currentDay = Calendar.current.component(.day, from: Date())
            if indexPath.row + 1 - howManyItemsShouldIAdd == currentDay{
                print("currentDay:\(currentDay)")
                cell.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
            }
            //textLabel.text = "\(indexPath.row + 1)" //1から
            
            if indexPath.row == 10 {
                print("indexPath:\(indexPath.row)")
                let redPath = UIBezierPath()
                redPath.addArc(withCenter: CGPoint(x: 150, y: 150), // 中心
                    radius: 5, // 半径
                    startAngle: 0, // 開始角度
                    endAngle: .pi * 2.0, // 終了角度
                    clockwise: true) // 時計回り
                
                let redLayer = CAShapeLayer()
                redLayer.path = redPath.cgPath
                redLayer.fillColor = UIColor.red.cgColor // 塗り色
                redLayer.strokeColor = UIColor.red.cgColor // 線の色
                redLayer.lineWidth = 3.0 // 線の幅
                self.view.layer.addSublayer(redLayer)
            }
        }
        
        return cell
        
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
        homeButton.setImage(UIImage(named: "home-icon"), for: UIControl.State.normal)
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
        
        //        var currentYear = Calendar.current.component(.year, from: Date())
        //        var currentMonth = Calendar.current.component(.month, from: Date())
        
        print("\(currentYear)/\(currentMonth)") //今月test
        
        timeLabel.text = months[currentMonth - 1] + "\(currentYear)"
        
        calendar.reloadData() //今の月の日更新
        
        
        print("whatDayIsIt：　\(whatDayIsIt)") //12/1 は金曜 (collection view item がまた5個itemを足さなければいけない)
    }
    
    
    
}
