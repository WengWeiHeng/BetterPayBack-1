//
//  CalendarPopUpViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/31.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class CalendarPopUpViewController: UIViewController {
    
    var viewOfCell = UIView()
    
    var name = UILabel()
    var dateReturn = UILabel()
    var dateReturnTitle = UILabel()
    var money = UILabel()
    var moneyTitle = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
    
        
        //popup情報View
        viewOfCell.frame = CGRect(x: view.frame.width * 0.15 , y: view.frame.height * 0.3, width: view.frame.width * 0.7, height: view.frame.height * 0.35)
        viewOfCell.backgroundColor = .white
        viewOfCell.layer.cornerRadius = view.frame.width * 0.1
        view.addSubview(viewOfCell)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let w = viewOfCell.frame.width
        let h = viewOfCell.frame.height
        
        if w > 414{
            name.frame = CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.7, height: h * 0.3)
            name.text = "\(nameOfRedDot)"
            name.textColor = .black
            name.font = UIFont.systemFont(ofSize: 35)
            viewOfCell.addSubview(name)
            
            money.frame = CGRect(x: w * 0.1, y: h * 0.35, width: w * 0.7, height: h * 0.3)
            money.text = "金額："
            money.textColor = .black
            money.font = UIFont.systemFont(ofSize: 23)
            viewOfCell.addSubview(money)
            moneyTitle.frame = CGRect(x: w * 0.1, y: h * 0.45, width: w * 0.7, height: h * 0.3)
            moneyTitle.text = "\(moneyOfRedDot)"
            moneyTitle.textColor = .black
            moneyTitle.font = UIFont.systemFont(ofSize: 25)
            viewOfCell.addSubview(moneyTitle)
            
            dateReturn.frame = CGRect(x: w * 0.1, y: h * 0.6, width: w * 0.7, height: h * 0.3)
            dateReturn.text = "期限："
            dateReturn.textColor = .black
            dateReturn.font = UIFont.systemFont(ofSize: 23)
            viewOfCell.addSubview(dateReturn)
            dateReturnTitle.frame = CGRect(x: w * 0.1, y: h * 0.7, width: w * 0.7, height: h * 0.3)
            dateReturnTitle.text = "\(dateOfRedDot)"
            dateReturnTitle.textColor = .black
            dateReturnTitle.font = UIFont.systemFont(ofSize: 25)
            viewOfCell.addSubview(dateReturnTitle)
        }else{
            name.frame = CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.7, height: h * 0.3)
            name.text = "\(nameOfRedDot)"
            name.textColor = .black
            name.font = UIFont.systemFont(ofSize: 35)
            viewOfCell.addSubview(name)
            
            money.frame = CGRect(x: w * 0.1, y: h * 0.35, width: w * 0.7, height: h * 0.3)
            money.text = "金額："
            money.textColor = .black
            money.font = UIFont.systemFont(ofSize: 23)
            viewOfCell.addSubview(money)
            moneyTitle.frame = CGRect(x: w * 0.1, y: h * 0.45, width: w * 0.7, height: h * 0.3)
            moneyTitle.text = "\(moneyOfRedDot)"
            moneyTitle.textColor = .black
            moneyTitle.font = UIFont.systemFont(ofSize: 25)
            viewOfCell.addSubview(moneyTitle)
            
            dateReturn.frame = CGRect(x: w * 0.1, y: h * 0.6, width: w * 0.7, height: h * 0.3)
            dateReturn.text = "期限："
            dateReturn.textColor = .black
            dateReturn.font = UIFont.systemFont(ofSize: 23)
            viewOfCell.addSubview(dateReturn)
            dateReturnTitle.frame = CGRect(x: w * 0.1, y: h * 0.7, width: w * 0.7, height: h * 0.3)
            dateReturnTitle.text = "\(dateOfRedDot)"
            dateReturnTitle.textColor = .black
            dateReturnTitle.font = UIFont.systemFont(ofSize: 25)
            viewOfCell.addSubview(dateReturnTitle)
            
        }
        
//        name.frame = CGRect(x: w * 0.1, y: h * 0.1, width: w * 0.7, height: h * 0.3)
//        name.text = "\(nameOfRedDot)"
//        name.textColor = .black
//        name.font = UIFont.systemFont(ofSize: 35)
//        viewOfCell.addSubview(name)
//
//        money.frame = CGRect(x: w * 0.1, y: h * 0.35, width: w * 0.7, height: h * 0.3)
//        money.text = "金額："
//        money.textColor = .black
//        money.font = UIFont.systemFont(ofSize: 23)
//        viewOfCell.addSubview(money)
//        moneyTitle.frame = CGRect(x: w * 0.1, y: h * 0.45, width: w * 0.7, height: h * 0.3)
//        moneyTitle.text = "\(moneyOfRedDot)"
//        moneyTitle.textColor = .black
//        moneyTitle.font = UIFont.systemFont(ofSize: 25)
//        viewOfCell.addSubview(moneyTitle)
//
//        dateReturn.frame = CGRect(x: w * 0.1, y: h * 0.6, width: w * 0.7, height: h * 0.3)
//        dateReturn.text = "期限："
//        dateReturn.textColor = .black
//        dateReturn.font = UIFont.systemFont(ofSize: 23)
//        viewOfCell.addSubview(dateReturn)
//        dateReturnTitle.frame = CGRect(x: w * 0.1, y: h * 0.7, width: w * 0.7, height: h * 0.3)
//        dateReturnTitle.text = "\(dateOfRedDot)"
//        dateReturnTitle.textColor = .black
//        dateReturnTitle.font = UIFont.systemFont(ofSize: 25)
//        viewOfCell.addSubview(dateReturnTitle)
//
    }

    
    @objc func tapped(_ sender: UITapGestureRecognizer){
        self.view.removeFromSuperview()
    }

}
