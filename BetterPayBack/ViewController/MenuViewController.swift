//
//  MenuViewController.swift
//  BetterPayBack
//
//  Created by cmStudent on 2020/01/29.
//  Copyright © 2020 19cm0140. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLoginTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "login"){
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnRegisterTapped(_ sender: Any) {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "register"){
            present(controller, animated: true, completion: nil)
        }
    }
    
}
