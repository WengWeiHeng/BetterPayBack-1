//
//  PopUpViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/28.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    
    var btnStatisticCenter: CGPoint!
    var btnCalendarCenter: CGPoint!
    var btnAddDataCenter: CGPoint!
    var btnRecordCenter: CGPoint!
    var btnCountdownCenter: CGPoint!
    
    var btnCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //let screenWidth:CGFloat = self.view.frame.width
        //let screenHeight:CGFloat = self.view.frame.height
        
        
        // 画面のどこかがタップされたらポップアップを消す処理
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(self.tapped(_:))
        )
        
        // デリゲートをセット
        tapGesture.delegate = self as? UIGestureRecognizerDelegate
        
        self.view.addGestureRecognizer(tapGesture)
        
        // ポップアップ以外のところを半透明のグレーに
        self.view.backgroundColor = UIColor(red: 150/255,green: 150/255,blue: 150/255,alpha: 0.6)
        
        //statisticボタン
        let btnStatistic = UIButton()
        btnStatistic.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        btnStatistic.setImage(UIImage(named: "staticsIcon"), for: UIControl.State.normal)
        btnStatistic.layer.position = CGPoint(x: view.frame.width * 0.23, y: view.frame.height * 0.92)
        btnStatistic.addTarget(self, action: #selector(self.tapStatistic(_:)), for: .touchUpInside)
        self.view.addSubview(btnStatistic)
        
        //calendarボタン
        let btnCalendar = UIButton()
        btnCalendar.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        btnCalendar.setImage(UIImage(named: "calendarIcon"), for: UIControl.State.normal)
        btnCalendar.layer.position = CGPoint(x: view.frame.width * 0.26, y: view.frame.height * 0.82)
        btnCalendar.addTarget(self, action: #selector(self.tapCalendar(_ :)), for: .touchUpInside)
        self.view.addSubview(btnCalendar)
        
        //addDataボタン
        let btnAddData = UIButton()
        btnAddData.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        btnAddData.setImage(UIImage(named: "addDataIcon"), for: UIControl.State.normal)
        btnAddData.layer.position = CGPoint(x: view.frame.width * 0.5, y: view.frame.height * 0.76)
        btnAddData.addTarget(self, action: #selector(self.tapAddData(_ :)), for: .touchUpInside)
        self.view.addSubview(btnAddData)
        
        //recordボタン
        let btnRecord = UIButton()
        btnRecord.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        btnRecord.setImage(UIImage(named: "recordIcon"), for: UIControl.State.normal)
        btnRecord.layer.position = CGPoint(x: view.frame.width * 0.74, y: view.frame.height * 0.82)
        btnRecord.addTarget(self, action: #selector(self.tapRecord(_ :)), for: .touchUpInside)
        self.view.addSubview(btnRecord)
        
        //countdownボタン
        let btnCountdown = UIButton()
        btnCountdown.frame = CGRect(x: 318, y: 696, width: 90, height: 90)
        btnCountdown.setImage(UIImage(named: "countDownIcon"), for: UIControl.State.normal)
        btnCountdown.layer.position = CGPoint(x: view.frame.width * 0.77, y: view.frame.height * 0.92)
        btnCountdown.addTarget(self, action: #selector(self.tapCountdown(_:)), for: .touchUpInside)
        self.view.addSubview(btnCountdown)
        
        
        //ボタンアニメション
        UIView.animate(withDuration: 0.3, animations: {
            //ボタンexpand
            
        })
        
        
        
        
    }
    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        
        self.view.removeFromSuperview()
        
    }
    
    // statisticボタンが押されたとき
    @objc func tapStatistic(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let statistic:StatisticViewController = storyboard.instantiateViewController(withIdentifier: "statistic") as! StatisticViewController
        self.present(statistic, animated: false, completion: nil)
    }
    
    // calendarボタンが押されたとき
    @objc func tapCalendar(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let calendar:CalanderViewController = storyboard.instantiateViewController(withIdentifier: "calendar") as! CalanderViewController
        self.present(calendar, animated: false, completion: nil)
    }
    
    // addDataボタンが押されたとき
    @objc func tapAddData(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let addData:AddDataViewController = storyboard.instantiateViewController(withIdentifier: "addData") as! AddDataViewController
        self.present(addData, animated: false, completion: nil)
    }
    
    // recordボタンが押されたとき
    @objc func tapRecord(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let record:RecordViewController = storyboard.instantiateViewController(withIdentifier: "record") as! RecordViewController
        self.present(record, animated: false, completion: nil)
    }
    
    // countdownボタンが押されたとき
    @objc func tapCountdown(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let countDown:CountDownViewController = storyboard.instantiateViewController(withIdentifier: "countDown") as! CountDownViewController
        self.present(countDown, animated: false, completion: nil)
        
        
    }
    
    
    
}
