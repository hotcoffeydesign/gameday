//
//  ExitPopUpVC.swift
//  iHOOP
//
//  Created by mac on 28/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class ExitPopUpVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func btn_No( sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btn_Yes( sender: UIButton){
     let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayersVC") as! PlayersVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
