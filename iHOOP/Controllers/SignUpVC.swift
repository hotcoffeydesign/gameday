//
//  SignUpVC.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class SignUpVC: BaseViewController,APIManagerDelegate {
    
    @IBOutlet weak var tf_FName:UITextField!
    @IBOutlet weak var tf_LName:UITextField!
    @IBOutlet weak var tf_UserName:UITextField!
    @IBOutlet weak var tf_Email:UITextField!
    @IBOutlet weak var tf_Password:UITextField!
    @IBOutlet weak var tf_ConfirmPassword:UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    var welcome = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textToBold = "Login Now"
        let fullText = "Already have an account? Login Now"
        let attr = NSMutableAttributedString(string: fullText)
        attr.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 13), range: NSMakeRange(fullText.count - textToBold.count, textToBold.count))
        self.btnLogin.titleLabel?.attributedText = attr

        
    }
    
    @IBAction func btn_SignUpAction( sender : UIButton){
        let valid = validate()
        if valid.isSuccess {
            self.CallApiForWabService()
        } else {
            self.showAnnouncement(withMessage: valid.message)
        }
        
    }
    
    
    @IBAction func btn_AlreadyhaveAnAccount( sender: UIButton){
        if welcome == true{
            let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            addTransitionEffectForPopAndDismiss()
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            
            self.popController(sender)
        }
        
    }
}
extension SignUpVC{
    func validate() -> (isSuccess : Bool, message : String){
        var success = true
        var msg = ""
        
        if tf_FName.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.fnametextField
        }
        else if tf_LName.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.lnametextField
        }
        else if tf_UserName.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.UserNameValid
        }
        else if tf_Email.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.emailtextField
        }
        else if !tf_Email.isValidEmail(){
            success = false
            msg = UseCaseMessage.validate.Validtext.emailtextfield
        }
        else if tf_Password.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.passwordtextField
        }
        else if tf_ConfirmPassword.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.cnfrmpasswordtextField
        }
        else if tf_ConfirmPassword.text != tf_Password.text{
            success = false
            msg = UseCaseMessage.validate.Validtext.confirmpasswordtextfield
        }
        
        return (isSuccess: success , message : msg)
    }
    func CallApiForWabService()  {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String : Any]()
        param[ApiConstant.ApiKey.kFName] = tf_FName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.kLName] = tf_LName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.kUsername] = tf_UserName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.kemail] = tf_Email.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.kpassword] = tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kSignup)
    }
    func compilation_Success(data: Any, check: String!) {
        if check == ApiConstant.ApiAction.kSignup
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                showAnnouncement(withMessage: basemodal.msg ?? "", closer: {
                    if self.welcome == true{
                        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                        self.addTransitionEffectForPopAndDismiss()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }else{
                        
                    self.navigationController?.popViewController(animated: true)
                    }
                })
            }
            else
            {
                showAnnouncement(withMessage: basemodal.msg! )
            }
        }
    }
    func compilation_Error(data: Any, check: String!) {
        self.showServerErrorMessage(error_data: data)
    }
}
