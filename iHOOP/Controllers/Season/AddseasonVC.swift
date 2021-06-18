//
//  AddseasonVC.swift
//  iHOOP
//
//  Created by mac on 07/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class AddseasonVC:BaseViewController  {
    @IBOutlet weak var tfGameName: UITextField!
    @IBOutlet weak var tfGamDate: UITextField!
        
        var gameName: String?
        let datePicker = UIDatePicker()
        let formatter = DateFormatter()
        var player_id: String?
        var season_id: String?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            formatter.dateFormat = "MM/dd/yyyy"
            self.tfGameName.text = self.gameName
            self.tfGamDate.text = formatter.string(from: Date())
                
            self.hideNvigationBar()
        }
        
        @IBAction func btnCancelTouch(sender: UIButton){
            self.navigationController?.popViewController(animated: true)
        }
        
        @IBAction func btnSaveTouch(sender: UIButton){
            self.callapiForAddseasson()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == tfGamDate{
                self.showDatePicker()
            }
        }
        
        func showDatePicker(){
            //Formate Date
            datePicker.datePickerMode = .date
            datePicker.addTarget(self, action: #selector(donedatePicker), for: .valueChanged)
            let toolbar = UIToolbar();
            toolbar.sizeToFit()
            //done button & cancel button
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            let cancelButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(cancelDatePicker))
            toolbar.setItems([spaceButton,cancelButton], animated: false)
            tfGamDate.inputAccessoryView = toolbar
            tfGamDate.inputView = datePicker
            
        }

        @objc func donedatePicker(){
            tfGamDate.text = formatter.string(from: datePicker.date)
        }

        @objc func cancelDatePicker(){
            self.tfGamDate.resignFirstResponder()
        }
        
    }

    extension AddseasonVC:APIManagerDelegate{
        func callapiForAddseasson()  {
            APIManager.sharedManager.apiManagerDelegate = self
            var param = [String:Any]()
             param[ApiConstant.ApiKey.kPlayerID] = self.player_id
                   param[ApiConstant.ApiKey.kseason_id] = self.season_id
                   param[ApiConstant.ApiKey.kseasonName] = self.tfGameName.text
                   param[ApiConstant.ApiKey.kseasonDate] = self.tfGamDate.text
            APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kaddseason)
        }
        
        func compilation_Success(data: Any, check: String!) {
            print(data)
            APIManager.sharedManager.apiManagerDelegate = self
            if check == ApiConstant.ApiAction.kaddseason
            {
                guard let basemodal = Mapper<BaseModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                    print("parsing error")
                    self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                    return
                }
                if basemodal.isSuccess{
                    self.navigationController?.popViewController(animated: true)
                }
                else{
                    self.showAnnouncement(withMessage: basemodal.msg!)
                }
            }
        }
        func compilation_Error(data: Any, check: String!) {
            self.showServerErrorMessage(error_data: data)
        }
        
        
        
    }
