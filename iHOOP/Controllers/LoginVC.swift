//
//  ViewController.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginVC: BaseViewController {
    
    @IBOutlet weak var tf_UseName:UITextField!
    @IBOutlet weak var tf_Password:UITextField!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textToBold = "Create an account"
        let fullText = "New user? Create an account"
        let attr = NSMutableAttributedString(string: fullText)
        attr.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 13), range: NSMakeRange(fullText.count - textToBold.count, textToBold.count))
        self.btnLogin.titleLabel?.attributedText = attr
        
        if SharedPreference.getUserData().token != nil{
            self.gotoNextVC()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.hideNvigationBar()
    }
    
    @IBAction func btn_NewUserCreateAnAccount( sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_LoginAction( sender:UIButton) {
        
        if (tf_UseName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 1 {
            showAnnouncement(withMessage: UseCaseMessage.validate.Empty.UserNameValid)
        }
        else if  (tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 1 {
            showAnnouncement(withMessage: UseCaseMessage.validate.Empty.passwordtextField)
        }
        else if(tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 6 {
            showAnnouncement(withMessage: UseCaseMessage.validate.Validtext.PasswordShort)
        }
        else{
            APIManager.sharedManager.apiManagerDelegate = self
            var param = [String : Any]()
            param[ApiConstant.ApiKey.kUsername] = tf_UseName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            param[ApiConstant.ApiKey.kpassword] = tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kLogin)
            
        }
    }
}

extension LoginVC: APIManagerDelegate {
    
    func compilation_Success(data: Any, check: String!) {
        
        if check == ApiConstant.ApiAction.kLogin
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any]) else {
                print("parsing error")
                showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            
            if basemodal.isSuccess {                
                let userDetail: LoginModel = basemodal.object!
                print(basemodal.object as Any)
                SharedPreference.saveUserData(user: userDetail)
                showAnnouncement(withMessage: UseCaseMessage.notify.loginSuccessful, closer: {
                    self.gotoNextVC()
                })
            }
            else
            {
                showAnnouncement(withMessage: basemodal.msg! /*"please enter valid credential!"*/ )
            }
        }
    }
    
    func compilation_Error(data: Any, check: String!) {
        self.showServerErrorMessage(error_data: data)
    }
    
    func gotoNextVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayersVC") as! PlayersVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
