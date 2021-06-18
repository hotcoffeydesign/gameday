//
//  ForgotPasswordVC.swift
//  iHOOP
//
//  Created by mac on 05/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class ForgotPasswordVC: BaseViewController {

    @IBOutlet weak var tfEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNvigationBar()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSubmitTouch(sender: UIButton){
        if self.tfEmail.text == ""{
            self.showAnnouncement(withMessage: "please enter Username")
        }else{
            self.callApiForForgotPassword()
        }
    }

    @IBAction func btnBackToLogin(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
  
    func callApiForForgotPassword() {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String : Any]()
        param[ApiConstant.ApiKey.kUsername] = self.tfEmail.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kForgot)
    }

}

extension ForgotPasswordVC: APIManagerDelegate {
    
    func compilation_Success(data: Any, check: String!) {
        print(data)
        if check == ApiConstant.ApiAction.kForgot
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.showAnnouncement(withMessage: basemodal.msg ?? "")
            }
            else
            {
                showAnnouncement(withMessage: basemodal.msg ?? "")
            }
        }
    }
    
    func compilation_Error(data: Any, check: String!) {
        self.showServerErrorMessage(error_data: data)
    }
}
