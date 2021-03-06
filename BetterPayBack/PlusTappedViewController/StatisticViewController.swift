//
//  StatisticViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//


import UIKit
import CoreData
import Firebase

class StatisticViewController: UIViewController, PageMenuViewDelegate {
    
    //MARK:fakeTabBar
    //plusボタン
    let button = UIButton.init(type: .custom)
    //popupview
    var popupViewController = PopUpViewController()
    let homeButton = UIButton()
    let profileButton = UIButton()
    let barImage = UIImageView()
    
    //データ保存する配列
    var graficArray = [NSManagedObject]()
    //1月返したお金を保存する配列
    var haveReturnedArrayMonth1 : [Int] = []
    
    var graficLabelYellow = UILabel()
    var graficLabelBlue = UILabel()
    
    //picker
    var pickerView = UIPickerView()
    var nameField = UITextField()
    var nameBackground = UIImageView()
    var nameList : [String] = []
    var orderSetNameListValue : [String] = []
    var nameDictionary : [String:Int] = [:]
    var nameDictionaryHaveReturn : [String:Int] = [:]
    var rateOfPerson : Double = 0
    
    //統計：０、名前別：１
    var nowView : Int = 1
    
    var pageMenu: PageMenuView!
    var chartView : ChartView! = ChartView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true
        
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
        // インプットビュー設定 (最初hideする)
        nameField.inputView = pickerView
        nameField.inputAccessoryView = toolbar
        nameField.isHidden = true
        
        self.view.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        
        // Init View Contollers
        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        viewController1.title = "統計"
        
        let viewController2 = UIViewController()
        viewController2.view.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        viewController2.title = "名前別"
        
        //        let viewController3 = UIViewController()
        //        viewController3.view.backgroundColor = UIColor(red: 240/255, green: 135/255, blue: 98/255, alpha: 1.0)
        //        viewController3.title = "名前別"
        
        // Add to array
        let viewControllers = [viewController1, viewController2]
        
        // Page menu UI option
        let option = PageMenuOption(frame: CGRect(
            x: 0, y: 20, width: view.frame.size.width, height: view.frame.size.height - 20))
        
        // Init Page Menu with view controllers and UI option
        pageMenu = PageMenuView(viewControllers: viewControllers, option: option)
        pageMenu.delegate = self
        view.addSubview(pageMenu)
        self.view.addSubview(chartView!)
        
        chartView!.frame = CGRect(x: UIScreen.main.bounds.width/2-(UIScreen.main.bounds.width * 0.8)/5, y: UIScreen.main.bounds.height/2-120, width: 130, height: 130)
        
        
        //MARK:(mine)
        let viewWidth = view.frame.size.width
        let viewHeight = view.frame.size.height
        
        
        //colorView(yellow)
        let colorViewYellow = UIView()
        colorViewYellow.frame = CGRect(x: viewWidth * 0.1, y: viewHeight * 0.1, width: viewWidth * 0.18, height: viewHeight * 0.03)
        colorViewYellow.backgroundColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1)
        self.view.addSubview(colorViewYellow)
        //Label(yellow)
        let colorLabelYellow = UILabel()
        colorLabelYellow.frame = CGRect(x: viewWidth * 0.3, y: viewHeight * 0.1, width: viewWidth * 0.4, height: viewHeight * 0.03)
        colorLabelYellow.textColor = UIColor.black
        colorLabelYellow.text = "返された"
        colorLabelYellow.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(colorLabelYellow)
        //colorView(blue)
        let colorViewBlue = UIView()
        colorViewBlue.frame = CGRect(x: viewWidth * 0.1, y: viewHeight * 0.15, width: viewWidth * 0.18, height: viewHeight * 0.03)
        colorViewBlue.backgroundColor = UIColor(red: 18/255, green: 21/255, blue: 91/255, alpha: 1)
        self.view.addSubview(colorViewBlue)
        //Label(blue)
        let colorLabelBlue = UILabel()
        colorLabelBlue.frame = CGRect(x: viewWidth * 0.3, y: viewHeight * 0.15, width: viewWidth * 0.4, height: viewHeight * 0.03)
        colorLabelBlue.textColor = UIColor.black
        colorLabelBlue.text = "返されなかった"
        colorLabelBlue.font = UIFont.systemFont(ofSize: 20)
        self.view.addSubview(colorLabelBlue)
        
        //nameLabel(background非表示)
        nameBackground.image = UIImage(named: "fieldILong")
        nameBackground.frame = CGRect(x: viewWidth * 0.21, y: viewHeight * 0.23, width: viewWidth * 0.6, height: viewHeight * 0.06)
        self.view.addSubview(nameBackground)
        nameBackground.isHidden = true
        //let nameField = UITextField()
        nameField.frame = CGRect(x: viewWidth * 0.3, y: viewHeight * 0.24, width: viewWidth * 0.4, height: viewHeight * 0.05)
        nameField.textColor = UIColor.black
        nameField.text = "名前を選択"
        nameField.font = UIFont.systemFont(ofSize: 35)
        nameField.textAlignment = .center
        self.view.addSubview(nameField)
        
        
        
        //MARK:sizeChange
        let width = view.frame.width
        //let height = view.frame.height
        if width > 414{
            barImage.image = UIImage(named: "homeIndicator3")
            barImage.frame = CGRect(x: -1, y: view.frame.height - 123, width: width, height: 123)
            view.addSubview(barImage)
            
            //homeButton
            homeButton.setImage(UIImage(named: "home2"), for: UIControl.State.normal)
            homeButton.frame = CGRect(x: barImage.frame.width * 0.21 - 2 , y: view.frame.height * 0.9, width: 65, height: 65)
            homeButton.addTarget(self, action: #selector(self.homeButtonTapped(_:)), for: .touchUpInside)
            homeButton.tintColor = .gray
            view.addSubview(homeButton)
            //profileButton
            profileButton.setImage(UIImage(named: "user"), for: UIControl.State.normal)
            profileButton.frame = CGRect(x: barImage.frame.width * 0.7 , y: view.frame.height * 0.9, width: 65, height: 65)
            profileButton.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
            profileButton.tintColor = .gray
            view.addSubview(profileButton)
            
        }else{
            barImage.image = UIImage(named: "homeIndicator2")
            barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
            view.addSubview(barImage)
            
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
        
        
        //MARK:fake plus button
        //barImage.image = UIImage(named: "homeIndicator2")
        //barImage.frame = CGRect(x: -3, y: view.frame.height - 128, width: view.frame.width + 5, height: 128)
        //view.addSubview(barImage)
        //plusボタン設定
        button.setImage(UIImage(named: "plus_main"), for: UIControl.State.normal)
        button.frame = CGRect(x: barImage.center.x - 33 , y: self.view.frame.height * 0.83, width: 70, height: 70)
        button.addTarget(self, action: #selector(self.popup(_:)), for: .touchUpInside)
        view.addSubview(button)
//        //homeButton
//        homeButton.setImage(UIImage(named: "home2"), for: UIControl.State.normal)
//        homeButton.frame = CGRect(x: barImage.frame.width * 0.17 , y: view.frame.height * 0.9 - 7, width: 65, height: 65)
//        homeButton.addTarget(self, action: #selector(self.homeButtonTapped(_:)), for: .touchUpInside)
//        homeButton.tintColor = .gray
//        view.addSubview(homeButton)
//        //profileButton
//        profileButton.setImage(UIImage(named: "user"), for: UIControl.State.normal)
//        profileButton.frame = CGRect(x: barImage.frame.width * 0.66 + 2, y: view.frame.height * 0.9 - 7, width: 65, height: 65)
//        profileButton.addTarget(self, action: #selector(self.profileButtonTapped(_:)), for: .touchUpInside)
//        profileButton.tintColor = .gray
//        view.addSubview(profileButton)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.orientation == .portrait {
            pageMenu.frame = CGRect(
                x: 0, y: 50, width: view.frame.size.width, height: view.frame.size.height - 20)
        } else {
            pageMenu.frame = CGRect(
                x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        }
    }
    
    func willMoveToPage(_ pageMenu: PageMenuView, from viewController: UIViewController, index currentViewControllerIndex: Int) {
        
        print("---------")
        print(viewController.title!)
        //        chartView.touchUpButtonDraw()
        //        //MARK:namefieldを表示する
        //        nameField.isHidden = false
        //        nameBackground.isHidden = false
        
        graficLabelYellow.text = "0%"
        graficLabelBlue.text = "0%"
        
        if nowView == 2 && viewController.title! == "名前別" {
            nowView = 3
            //MARK:namefieldを表示する
            nameField.isHidden = false
            nameBackground.isHidden = false
            chartView.touchUpButtonDraw(rateOfPerson:rateOfPerson)
            print(nowView)
        }else if nowView == 0 && viewController.title! == "統計"{
            nowView = 1
            
            //MARK:別のviewControllerの変数を使う
//            //RecordViewのsumOfMoney変数をとる
//            let getRecordView = RecordViewController()
//            let getRecordViewSumOfMoney = getRecordView.sumOfMoney
//            //CountDownViewのhaveReturndTotalMoney変数をとる
//            let getCountDownView = CountDownViewController()
//            let getCountDownViewHaveReturndTotalMoney = getCountDownView.haveReturndTotalMoney
            //percentage計算
            let rateOfYellowMonth = getPercentage(sum: sumOfMoney, yellowSum: haveReturndTotalMoney)
            chartView!.drawChart(rate: rateOfYellowMonth)
            print("rateOfYellowMonth:\(rateOfYellowMonth)")
            putgraficLabel(graficYellow: rateOfYellowMonth)
            //chartView!.drawChart(rate: 45)
            
            //今まで貸した総金額表示
            let getRecordViewControllerFunction = RecordViewController()
            getRecordViewControllerFunction.getData()
            
            //まだ返してない総金額表示
            let getCountDownViewControllerFunction = CountDownViewController()
            getCountDownViewControllerFunction.getHaveReturnedData()
            
            nameField.isHidden = true
            nameBackground.isHidden = true
            print(nowView)
            
        }else if nowView == 4 {
            nowView = 1
            //MARK:namefieldを表示する
            nameField.isHidden = false
            nameBackground.isHidden = false
            chartView.touchUpButtonDraw(rateOfPerson: rateOfPerson)
            print(nowView)
        }
    }
    
    func didMoveToPage(_ pageMenu: PageMenuView, to viewController: UIViewController, index currentViewControllerIndex: Int) {
        
        print(viewController.title!)
        
        graficLabelYellow.text = "0%"
        graficLabelBlue.text = "0%"
        
        if nowView == 3 && viewController.title! == "統計" {
            nowView = 4
            
            //MARK:別のviewControllerの変数を使う
//            //RecordViewのsumOfMoney変数をとる
//            let getRecordView = RecordViewController()
//            let getRecordViewSumOfMoney = getRecordView.sumOfMoney
//            //CountDownViewのhaveReturndTotalMoney変数をとる
//            let getCountDownView = CountDownViewController()
//            let getCountDownViewHaveReturndTotalMoney = getCountDownView.haveReturndTotalMoney
//
            //percentage計算
            let rateOfYellowMonth = getPercentage(sum: sumOfMoney, yellowSum: haveReturndTotalMoney)
            chartView!.drawChart(rate: rateOfYellowMonth)
            print("rateOfYellowMonth:\(rateOfYellowMonth)")
            putgraficLabel(graficYellow: rateOfYellowMonth)
            //chartView!.drawChart(rate: 45)
            
            //今まで貸した総金額表示
            let getRecordViewControllerFunction = RecordViewController()
            getRecordViewControllerFunction.getData()
            
            //まだ返してない総金額表示
            let getCountDownViewControllerFunction = CountDownViewController()
            getCountDownViewControllerFunction.getHaveReturnedData()
            
            nameField.isHidden = true
            nameBackground.isHidden = true
            print(nowView)
            //nowView = 0
            
        }else if nowView == 1{
            nowView = 2
            //MARK:namefieldを表示する
            nameField.isHidden = false
            nameBackground.isHidden = false
            chartView.touchUpButtonDraw(rateOfPerson: rateOfPerson)
            print(nowView)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(
            alongsideTransition: nil,
            completion: { (UIViewControllerTransitionCoordinatorContext) in
                self.chartView!.changeScreen()
        }
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //MARK:別のviewControllerの変数を使う
//        //RecordViewのsumOfMoney変数をとる
//        let getRecordView = RecordViewController()
//        let getRecordViewSumOfMoney = getRecordView.sumOfMoney
//        //CountDownViewのhaveReturndTotalMoney変数をとる
//        let getCountDownView = CountDownViewController()
//        let getCountDownViewHaveReturndTotalMoney = getCountDownView.haveReturndTotalMoney
//
        //percentage計算
        let rateOfYellowMonth = getPercentage(sum: sumOfMoney, yellowSum: haveReturndTotalMoney)
        chartView!.drawChart(rate: rateOfYellowMonth)
        print("rateOfYellowMonth:\(rateOfYellowMonth)")
        putgraficLabel(graficYellow: rateOfYellowMonth)
        //chartView!.drawChart(rate: 45)
        
        //今まで貸した総金額表示
        let getRecordViewControllerFunction = RecordViewController()
        getRecordViewControllerFunction.getData()
        
        //まだ返してない総金額表示
        let getCountDownViewControllerFunction = CountDownViewController()
        getCountDownViewControllerFunction.getHaveReturnedData()
        
        
        
        
        //nameデータ
        getDataWithName()
        
        
    }
    
    
    //MARK:(mine)percentageを計算する
    func getPercentage(sum: Int,yellowSum: Int) -> Double{
        let rate = floor(Double(yellowSum) / Double(sum) * 1000) / 1000 * 100
        let rate2 = floor(rate * 10)/10
        return rate2
    }
    
    func putgraficLabel(graficYellow: Double){
        
        let graficBlue = floor((100 - graficYellow) * 1000) / 1000
        
        let viewWidth2 = view.frame.size.width
        let viewHeight2 = view.frame.size.height
        //graficLabel(yellow)
        //let graficLabelYellow = UILabel()
        
        if view.frame.width > 414{
            graficLabelYellow.frame = CGRect(x: viewWidth2 * 0.75, y: viewHeight2 * 0.62, width: viewWidth2 * 0.4, height: viewHeight2 * 0.1)
        }else{
            graficLabelYellow.frame = CGRect(x: viewWidth2 * 0.65, y: viewHeight2 * 0.62, width: viewWidth2 * 0.4, height: viewHeight2 * 0.1)
        }
        graficLabelYellow.textColor = UIColor(red: 252/255, green: 238/255, blue: 33/255, alpha: 1)
        graficLabelYellow.text = "\(graficYellow)%"
        graficLabelYellow.font = UIFont.systemFont(ofSize: 40)
        self.view.addSubview(graficLabelYellow)
        //graficLabel(blue)
        //let graficLabelBlue = UILabel()
        graficLabelBlue.frame = CGRect(x: viewWidth2 * 0.075, y: viewHeight2 * 0.29, width: viewWidth2 * 0.4, height: viewHeight2 * 0.1)
        graficLabelBlue.textColor = UIColor(red: 18/255, green: 21/255, blue: 91/255, alpha: 1)
        graficLabelBlue.text = "\(graficBlue)%"
        graficLabelBlue.font = UIFont.systemFont(ofSize: 40)
        self.view.addSubview(graficLabelBlue)
        
    }
    
    //userNameをゲットする
    func getUserName() -> String{
        var userName = ""
        if let user = Auth.auth().currentUser {
            userName = String(user.displayName ?? "none")
        }
        print("nowUserDataId:\(userName)")
        return userName
    }
    
    //MARK: (mine)getDataWithName
    func getDataWithName(){
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
        //search条件
        let nowUserDataID = getUserName()
        let searchContent = NSPredicate(format: "dataID = '\(nowUserDataID)'")
        fetchRequest.predicate = searchContent
        //FetchRequestする
        do{
            //            //search条件
            //            let searchContent = NSPredicate(format: "name = \(nameList[0])")
            //            fetchRequest.predicate = searchContent
            //結果をresultsに入れる
            let results = try moc.fetch(fetchRequest) as! [PayBack]
            graficArray = results as [NSManagedObject]
            
            for name in results{
                nameList.append((name as AnyObject).value(forKey: "name") as! String)
                
            }
            //重複無しにする
            let orderSetNameList = NSOrderedSet(array: nameList)
            orderSetNameListValue = orderSetNameList.array as! [String]
            print("nameList:\(orderSetNameListValue)")
            
            for i in orderSetNameListValue {
                nameDictionary.updateValue(0, forKey: i)
            }
            //nameDictionaryをcopyする
            nameDictionaryHaveReturn = nameDictionary
            print("nameDictionary:\(nameDictionary)")

        }catch{
            print("request error(withNamed)")
        }
    }
    
    
    func getEachMoney(nameIndex:Int) -> Double{
        let appDel = (UIApplication.shared.delegate as! AppDelegate)
        let context:NSManagedObjectContext = appDel.persistentContainer.viewContext
        let moc = context
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PayBack")
        //TODO:nameMoney
        let nowUserDataID = getUserName()
        let searchContentMoney = NSPredicate(format: "dataID = '\(nowUserDataID)' && name = '\(orderSetNameListValue[nameIndex])'")
        fetchRequest.predicate = searchContentMoney
        
        do{
            //結果をresultsに入れる
            let resultsMoney = try moc.fetch(fetchRequest) as! [PayBack]
            //graficArray = resultsMoney as [NSManagedObject]
            //dataArray = resultsMoney as [NSManagedObject]
            print("\(orderSetNameListValue[nameIndex]):\(nameDictionary[orderSetNameListValue[nameIndex]] ?? 0)")
            //1回以上のmoneyを保存するため変数all
            var total = 0
            var totalHaveReturned = 0
            for moneyOfName in resultsMoney{
                total = total + Int(moneyOfName.money!)!
                if moneyOfName.haveReturned == true {
                    totalHaveReturned = totalHaveReturned + Int(moneyOfName.money!)!
                }
                
            }
            nameDictionary.updateValue(total, forKey: orderSetNameListValue[nameIndex])
            nameDictionaryHaveReturn.updateValue(totalHaveReturned, forKey: orderSetNameListValue[nameIndex])
            print("nameDictionaryUpdate:\(nameDictionary)")
            print("nameDictionaryHaveReturnUpdate:\(nameDictionaryHaveReturn)")
            
            
        }catch{
            print("request error(withNamed)")
        }
        
        guard let totalDiction = nameDictionary["\(orderSetNameListValue[nameIndex])"] else {return 0}
        guard let haveReturnDiction = nameDictionaryHaveReturn["\(orderSetNameListValue[nameIndex])"] else {return 0}
        let rateOfDiction = getPercentage(sum: totalDiction, yellowSum: haveReturnDiction)
        
        return rateOfDiction
        
    }
    
    
    
    //String配列Int型に変換
    func monthArrayTurnInt(monthArray:Array<String>) -> (moneyIntegersArray:Array<Int>,total:Int){
        //money配列をInt型に変換
        var moneyIntegers: [Int] = []
        for str in monthArray {
            moneyIntegers.append(Int(str)!)
        }
        //reduceでmoneyIntegers配列の合計を求める
        let total = moneyIntegers.reduce(0) {(num1: Int, num2: Int) -> Int in
            return num1 + num2
        }
        
        return (moneyIntegers,total)
    }
    
    //配列情報をprintする
    func printArrayInfo(index:Int,whichMonth:Array<String>){
        let array = monthArrayTurnInt(monthArray: whichMonth).moneyIntegersArray
        let total = monthArrayTurnInt(monthArray: whichMonth).total
        print("\(index)月金額配列：\(array)")
        print("\(index)月総金額：\(total)")
    }
    
    
    
    
    // 決定ボタン押下(pickerView)
    @objc func done() {
        nameField.endEditing(true)
        nameField.text = "\(orderSetNameListValue[pickerView.selectedRow(inComponent: 0)])"
        let pickerIndex = orderSetNameListValue[pickerView.selectedRow(inComponent: 0)]
        print("pickerIndex:\(pickerIndex)")
        
        //一人のpercentageを計算
        rateOfPerson = getEachMoney(nameIndex: pickerView.selectedRow(inComponent: 0))
        
        chartView.touchUpButtonDraw(rateOfPerson: rateOfPerson)
        print("rateOfPerson:\(rateOfPerson)")
        putgraficLabel(graficYellow: rateOfPerson)
        
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
    
    
    
    
}

//pickerExtension
extension StatisticViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return orderSetNameListValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return orderSetNameListValue[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.nameField.text = orderSetNameListValue[row]
    }
    
    //     // ドラムロール選択時
    //     func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //     self.textField.text = list[row]
    //     }
    //
    
    
}
