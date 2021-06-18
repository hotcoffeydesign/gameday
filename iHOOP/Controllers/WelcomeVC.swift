//
//  WelcomeVC.swift
//  iHOOP
//
//  Created by mac on 05/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit


class WelcomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if SharedPreference.getUserData().token != nil{
                   self.gotoNextVC()
               }
        self.hideNvigationBar()
    }
    
    @IBAction func LoginTouch(sender: UIButton){
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func NewUserTouch(sender: UIButton){
           let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        vc.welcome = true
           self.navigationController?.pushViewController(vc, animated: true)
       }
    
    func gotoNextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayersVC") as! PlayersVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
