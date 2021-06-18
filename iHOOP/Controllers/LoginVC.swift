//
//  ViewController.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginVC: BaseViewController{
    
    @IBOutlet weak var tf_UseName:UITextField!
    @IBOutlet weak var tf_Password:UITextField!
    @IBOutlet weak var btnRemeberMe: UIButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.value(forKey: "User") != nil &&  UserDefaults.standard.value(forKey: "pwd") != nil{
            self.tf_UseName.text = UserDefaults.standard.value(forKey: "User") as? String
            self.tf_Password.text = UserDefaults.standard.value(forKey: "pwd") as? String
            self.btnRemeberMe.isSelected = true
        }
        self.hideNvigationBar()
    }
    
    @IBAction func btnRemeberMeTouch(sender: UIButton){
        btnRemeberMe.isSelected = !btnRemeberMe.isSelected
        if sender.isSelected{
            UserDefaults.standard.setValue(self.tf_UseName.text, forKey: "User")
            UserDefaults.standard.setValue(self.tf_Password.text, forKey: "pwd")
        }else{
            UserDefaults.standard.removeObject(forKey: "User")
            UserDefaults.standard.removeObject(forKey: "pwd")
        }
    }
    
    @IBAction func btnForgotPassword(sender: UIButton){
        let vc  = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
        
       }
       
    
    @IBAction func btn_NewUserCreateAnAccount( sender:UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btn_LoginAction( sender:UIButton){
        if (tf_UseName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 1{
            showAnnouncement(withMessage: "Please Enter Username")
        }
        else if  (tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 1{
            showAnnouncement(withMessage: "Please Enter Password")
        }
        else if(tf_Password.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 4{
            showAnnouncement(withMessage: "Please Enter A Password of Minimum 4 Characters Length")
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
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                
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
    
    func gotoNextVC(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayersVC") as! PlayersVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
//[05/03/2020 2:07 PM] Krishna patel: rgb(240, 105, 57)

//[05/03/2020 2:07 PM] Krishna patel: rgb(247, 149, 116)

//[05/03/2020 2:07 PM] Krishna patel: rgb(238, 116, 75)
extension UIView {
    func layerGradient() {
        let layer : CAGradientLayer = CAGradientLayer()
        layer.frame.size = self.frame.size
        layer.frame.origin = CGPoint(x: 0, y: 0)
        layer.cornerRadius = CGFloat(frame.width / 20)

        let color0 = UIColor(red:240.0/255, green:105.0/255, blue:57.0/255, alpha:0.5).cgColor
        let color1 = UIColor(red:247.0/255, green:149.0/255, blue: 116.0/255, alpha:0.1).cgColor
        let color2 = UIColor(red:238.0/255, green:116.0/255, blue: 75.0/255, alpha:0.1).cgColor
        

        layer.colors = [color0,color1,color2]
        self.layer.insertSublayer(layer, at: 0)
    }
}
