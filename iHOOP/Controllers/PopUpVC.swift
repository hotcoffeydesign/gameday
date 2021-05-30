//
//  PopUpVC.swift
//  iHOOP
//
//  Created by mac on 31/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

protocol cancel_ok_handle {
    func cancel_handle()
    func ok_handle()
}
class PopUpVC: UIViewController {

    @IBOutlet var lblTitle: UILabel!
    
    var tempTitle = ""
    
    var delegate_cancel_ok: cancel_ok_handle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.lblTitle.text = tempTitle
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func OK_Clicked()
    {
        delegate_cancel_ok.ok_handle()
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func Cancel_Clicked()
    {
        delegate_cancel_ok.cancel_handle()
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
