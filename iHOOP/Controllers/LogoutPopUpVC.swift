//
//  LogoutPopUpVC.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class LogoutPopUpVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func btn_dismissLogoutPopupVC( sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_LogoutYes( sender: UIButton){
         self.popController(sender)
    }
}
