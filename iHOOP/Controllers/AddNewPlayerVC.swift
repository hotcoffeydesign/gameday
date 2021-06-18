//
//  AddNewPlayerVC.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ObjectMapper
import SDWebImage

protocol DataAddNewPlayerDelegate: class {
    func DataAddNewPlayer(Fname : String, lname: String, Rank:String, playerImg: UIImage)
}

class AddNewPlayerVC: BaseViewController,UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak  var tf_FirstName:UITextField!
    @IBOutlet weak  var tf_LastName:UITextField!
    @IBOutlet weak  var tf_Rank:UITextField!
    @IBOutlet weak  var img_NewPlayerImage:UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var vwNavigation: UIView!
    
    var Urlimage:URL!
    var picker = UIImagePickerController()
    
    var playerDetail: PlayerDetail!
    var baseImgUrl = ""
    var API_type = "add"
    let updatePlayer = "update"
    let addPlayer = "add"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "http://18.191.152.224/iHoop/Assets/player-profile/default.png")
        self.img_NewPlayerImage.sd_setImage(with: url, completed: nil)
        self.vwNavigation.layerGradient()
        if API_type == addPlayer
        {
            self.lblTitle.text = "ADD NEW PLAYER"
        }else // updatePlayer
        {
            self.lblTitle.text = "UPDATE PLAYER"
            let url = URL(string: "\(self.baseImgUrl)\(playerDetail.image ?? "")")
            self.tf_Rank.text = "\(playerDetail.hashID?.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: " ", with: "") ?? "")"
            self.tf_FirstName.text = "\(playerDetail.fname ?? "")".capitalized
            self.tf_LastName.text = "\(playerDetail.lname ?? "")".capitalized
            self.img_NewPlayerImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "NewLogo"), options: .scaleDownLargeImages, completed: nil)
        }
        self.HideBackButton()
    }
    
    @IBAction func btn_NewplayerNotAdd( sender: UIButton){
        self.popController(sender)
    }
    
    @IBAction func btn_AddNewPlayer( sender: UIButton){
        let valid = validate()
        if valid.isSuccess {
            self.CallApiForWabService()
        } else {
            self.showAnnouncement(withMessage: valid.message)
        }
    }
    @IBAction func btn_AddNewPlayerProfileImage( sender : UIButton){
        var contStyle = UIAlertController.Style.alert
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            contStyle = UIAlertController.Style.actionSheet
        }
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: contStyle)
        
        let cameraAction = UIAlertAction(title: "From Camera", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "From Photo Gallery", style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            self.openGallary()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    //MARK:- Functions
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            picker.sourceType = UIImagePickerController.SourceType.camera
            picker.allowsEditing = true
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let imgTemp = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        self.img_NewPlayerImage.image = imgTemp
        picker.dismiss(animated: true, completion: nil)
        
        //let data = imgTemp.pngData()
        
        
        var img_Temp_2 = imgTemp
        if img_Temp_2.size.width > 768.0
        {
            img_Temp_2 = self.resizeImage(image: img_Temp_2, newWidth: 768.0)
        }
        var compressQuality = 1.0
        var data = img_Temp_2.jpegData(compressionQuality: CGFloat(compressQuality))
        //UIImageJPEGRepresentation(img_Temp_2, CGFloat(compressQuality))//(img_Temp_2, 0.75)
        
        var imageByte = data?.count
        let maxByte = 400000// max 400000 = 400kb
        
        while imageByte! > maxByte {
            compressQuality -= 0.1
            data =  img_Temp_2.jpegData(compressionQuality: CGFloat(compressQuality))
            imageByte = data?.count
            print("imageByte:---------- ",imageByte)
        }
        
        
        do {
            let urlString = String(describing: Utils.getAppDocumentDirectory()) + String(Utils.getCurrentTimeInterval()) + ".jpg"
            if let url = URL(string: urlString){
                try data?.write(to: url, options: .atomicWrite)
                self.Urlimage = url
                
            }
        }catch( _){
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize.init(width: newWidth, height: newHeight))
        image.draw(in: CGRect.init(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
extension AddNewPlayerVC: APIManagerDelegate{
    func validate() -> (isSuccess : Bool, message : String){
        var success = true
        var msg = ""
        
        if tf_FirstName.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.fnametextField
        }
        else if tf_LastName.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.lnametextField
        }
        else if tf_Rank.isEmpty(){
            success = false
            msg = UseCaseMessage.validate.Empty.Code
        }
        
        return (isSuccess: success , message : msg)
    }
    func CallApiForWabService()  {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String : Any]()
        param[ApiConstant.ApiKey.kFName] = tf_FirstName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.kLName] = tf_LastName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        param[ApiConstant.ApiKey.khashID] = tf_Rank.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if Urlimage != nil
        {
            param[ApiConstant.ApiKey.kimage] = Urlimage
        }
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        
        if API_type == updatePlayer
        {
            param[ApiConstant.ApiKey.kPlayerID] = playerDetail.player_id!
            
            APIManager.sharedManager.call_uploadAPI(dataDict: param, action: ApiConstant.ApiAction.kUpdatePlayer)
        }else {
            APIManager.sharedManager.call_uploadAPI(dataDict: param, action: ApiConstant.ApiAction.kaddPlayer)
        }
    }
    func compilation_Success(data: Any, check: String!) {
        if check == ApiConstant.ApiAction.kaddPlayer
            ||
            check == ApiConstant.ApiAction.kUpdatePlayer
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.showAnnouncement(withMessage: "Player \(API_type)ed successfully.".replacingOccurrences(of: "ee", with: "e")/*basemodal.msg!*/) {
                    self.navigationController?.popViewController(animated: false)
                }
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

extension AddNewPlayerVC{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        
        let oldLength: Int = (textField.text?.count)!
        let newLength: Int = oldLength + string.count - range.length
        
        if textField == tf_Rank && newLength > 4
        {
            return false
        }
        else if textField == tf_FirstName && newLength > 20
        {
            return false
        }else if textField == tf_LastName && newLength > 20
        {
            return false
        }
        
        return true
    }
}
