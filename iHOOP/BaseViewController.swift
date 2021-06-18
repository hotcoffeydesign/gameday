//
//  BaseViewController.swift
//  Mula
//
//  Created by info on 06/07/18.
//  Copyright © 2018 Infograins. All rights reserved.
//

import UIKit
import CoreLocation
import SDWebImage
import ObjectMapper
import CoreLocation


class BaseViewController: UIViewController,UITextFieldDelegate {
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
           
            setNeedsStatusBarAppearanceUpdate()
      
//            self.navigationController?.setupNavigationPreference()
//            self.HideBackButton()
            self.LeftBackButotn()
            
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setupNavigationPreference()
      //  self.HideBackButton()
        viewWillLayoutSubviews()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       // self.createGradientLayer()
    }
  
    func addTransitionEffectForPopAndDismiss(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    @IBAction func dismissController(_ sender : UIButton){
        addTransitionEffectForPopAndDismiss()
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func popController(_ sender : UIButton){
        addTransitionEffectForPopAndDismiss()
        self.navigationController?.popViewController(animated: false)
    }
    
  
    func addTransitionAnimation(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        transition.type = CATransitionType.fade
        self.navigationController?.view.layer.add(transition, forKey: nil)
    }
    
    func isInternetConnected() -> Bool{
        if !Connectivity.isConnectedToInternet {
            return false
        }else{
            return true
        }
    }
    func setTabBarAsHome(){
        
    }
    func HideBackButton(){
        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
        navigationItem.leftBarButtonItem = backButton
    }
    func LeftBackButotn() {
        let menuBtn = UIButton(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
        // menuBtn.setImage(left , for: .normal)
        menuBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        menuBtn.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        let menuBarItem = UIBarButtonItem()
        menuBarItem.customView = menuBtn
        self.navigationItem.leftBarButtonItem = menuBarItem
    }
    
    func showActionSheetForCameraAndGallery(message : String , closerCamera: (()-> Void)? = nil ,gallery closerGallery: (()-> Void)? = nil,close closerClose: (()-> Void)? = nil){
        let actionSheet = UIAlertController(title: Utils.AppName(), message: message
            , preferredStyle: .actionSheet)
        //Camera
        actionSheet.addAction(UIAlertAction(title: PickCamera.camera, style: .default, handler: { (alertCamera) in
            closerCamera!()
        }))
        //Galery
        actionSheet.addAction(UIAlertAction(title: PickCamera.gallery, style: .default, handler: { (alertGallery) in
            closerGallery!()
        }))
        //Cancel
        actionSheet.addAction(UIAlertAction(title: PickCamera.cancel, style: .cancel, handler: { (alertCancel) in
            closerClose!()
        }))
        
        self.present(actionSheet, animated: true) {
        }
    }

    func showAnnouncement(withMessage message: String, closer:(()-> Void)? = nil){
        let alertController =   UIAlertController(title: Utils.AppName(), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction!) in
            closer?()
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showAnnouncement_YesNo(withMessage message: String, closer_yes:(()-> Void)? = nil){
        let alertController =   UIAlertController(title: Utils.AppName(), message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: .default) { (action:UIAlertAction!) in
            closer_yes?()
        }
        let cancelAction = UIAlertAction(title: "No", style: .default) { (action:UIAlertAction!) in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK:- Show & HIde navigation bar
    func showNavigationBar(){
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func hideNvigationBar(){
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func hideBottomTabBarWhenPushed(vc : UIViewController){
        vc.hidesBottomBarWhenPushed = true
    }
  
   
    @objc func goToBack(){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func popViewcontroller(_ sender : UIButton){
        self.goToBack()
    }
    func showAnnouncementYesAndNoOption(withMessage msg: String,yesTitle yTitle: String,noTitle nTitle: String, closer: (()-> Void)? = nil){
        let alertController =   UIAlertController(title: Utils.AppName() , message: msg, preferredStyle: .alert)
        let yesAction = UIAlertAction(title: yTitle, style: .default) { (action:UIAlertAction!) in
            closer?()
        }
        let noAction = UIAlertAction(title: nTitle, style: .default) { (action:UIAlertAction!) in
        }
        alertController.view.backgroundColor = UIColor(red: (230/255.0), green: (0/255.0), blue: (80/255.0), alpha: 0.3)
        alertController.view.tintColor = UIColor.hexStringToUIColor(AppColor.blueColor)
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
    
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showDropDownActionSheet(with message : String , allOptions : [String], closer: (()-> Void)? = nil , textField : UITextField){
        var contStyle = UIAlertController.Style.alert
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            contStyle = UIAlertController.Style.actionSheet
        }
        let actionSheet = UIAlertController(title: Utils.AppName(), message: message, preferredStyle: contStyle)
        for iteam in allOptions{
            actionSheet.addAction(UIAlertAction(title: iteam, style: .default, handler: { (alt) in
                textField.text = iteam
                closer!()
            }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        MainClass.appDelegate.window?.rootViewController?.present(actionSheet, animated: true, completion: {
        })
    }
    func getCurrentLocationEnabledCondition() -> Bool{
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                print("No access")
                return false
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                return true
            }
        } else {
            print("Location services are not enabled")
            return false
        }
    }
    func showServerErrorMessage(error_data : Any){
        let msg = (error_data as AnyObject).userInfo[NSLocalizedDescriptionKey]
        self.showAnnouncement(withMessage: "\(msg ?? "")")
    }
    func showParserMessage(){
        self.showAnnouncement(withMessage: ErrorMessage.parser)
    }
    
    func hideTabBar(){
        self.tabBarController?.tabBar.isHidden = true
    }
    func showTabBar(){
        self.tabBarController?.tabBar.isHidden = false
    }
    func addTransitionEffect(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade//kCATransitionPush
        transition.subtype = CATransitionSubtype.fromLeft//kCATransitionFromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
    }
    
    func saveImageOnDisk_ReturnDATA(imgTemp: UIImage, maxSizeInKB: Int) -> NSData
    {
        var compressQuality = 0.5
        var imgData = imgTemp.jpegData(compressionQuality: CGFloat(compressQuality))//UIImageJPEGRepresentation(imgTemp, CGFloat(compressQuality))
        
        var imageByte = imgData?.count
        let maxByte = maxSizeInKB * 1000
        
        while imageByte! > maxByte {
            compressQuality -= 0.1
            imgData = imgTemp.jpegData(compressionQuality: CGFloat(compressQuality))//UIImageJPEGRepresentation(imgTemp, CGFloat(compressQuality))
            imageByte = imgData?.count
        }
        return imgData! as NSData
    }
    
    func resizeImage(image: UIImage, requiredSize: CGSize) -> UIImage {
        
        if image.size.width < requiredSize.width || image.size.height < requiredSize.height
        {
            return image
        }
        
        let widthRatio = requiredSize.width / image.size.width
        let heightRatio = requiredSize.height / image.size.height
        
        let newSize: CGSize
        if (heightRatio > widthRatio) {
            newSize = CGSize(width: requiredSize.width, height: round(widthRatio * image.size.height))
        } else {
            newSize = CGSize(width: round(heightRatio * image.size.width), height: requiredSize.height)
        }
        
        var newImage: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: newSize.width, height: newSize.height), false, 1.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func saveImageOnDisk_ReturnURL(imgTemp: UIImage) -> String
    {
        var compressQuality = 1.0
        var data = imgTemp.jpegData(compressionQuality: CGFloat(compressQuality))//(imgTemp, 0.75)
        
        var imageByte = data?.count
        let maxByte = 400000// max 400000 = 400kb
        
        while imageByte! > maxByte {
            compressQuality -= 0.1
            data = imgTemp.jpegData(compressionQuality: CGFloat(compressQuality)) //UIImageJPEGRepresentation(imgTemp, CGFloat(compressQuality))
            imageByte = data?.count
        }
        
        do{
            let tmpImagePath = String(describing: Utils.getAppDocumentDirectory()) + String(Utils.getCurrentTimeInterval_inMillisec()) + ".jpg"
            
            if let url = URL(string: tmpImagePath)
            {
                try data?.write(to: url, options: .atomicWrite)
                print("URL String: \(tmpImagePath)")
                //arrTempImagePaths.append(tmpImagePath)
                return tmpImagePath
            }
            return ""
        }catch( _){
            print("Error while saving image in disc..........")
            return ""
        }
    }
    
    func postRequest(parameters: [String : Any], completion: @escaping ([String: Any]?, Error?) -> Void)
    {
        var hudView = UIView()
        hudView = UIView().getHUD(spinner: UIActivityIndicatorView())
        
        
        //create the url with NSURL
        let url = URL(string: "http://18.191.152.224/startrak/webservice/child/service.php/")!
        
        //create the session object
        let session = URLSession.shared
        
        //now create the Request object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to data object and set it as request body
        } catch let error {
            print(error.localizedDescription)
            DispatchQueue.main.async {
                hudView.removeFromSuperview()
            }
            completion(nil, error)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                DispatchQueue.main.async {
                    hudView.removeFromSuperview()
                }
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    hudView.removeFromSuperview()
                }
                completion(nil, NSError(domain: "dataNilError", code: -100001, userInfo: nil))
                return
            }
            
            do {
                //create json object from data
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {
                    completion(nil, NSError(domain: "invalidJSONTypeError", code: -100009, userInfo: nil))
                    return
                }
                print(json)
                DispatchQueue.main.async {
                    hudView.removeFromSuperview()
                }
                completion(json, nil)
            } catch let error {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    hudView.removeFromSuperview()
                }
                completion(nil, error)
            }
        })
        
        task.resume()
    }
    
    
}

extension UIButton
{
    func applyGradient(colors: [CGColor])
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.size.height / 2
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension StringProtocol where Index == String.Index {
    var byWords: [SubSequence] {
        var byWords: [SubSequence] = []
        enumerateSubstrings(in: startIndex..., options: .byWords) { _, range, _, _ in
            byWords.append(self[range])
        }
        return byWords
    }
}

struct PickCamera {
    static let camera = "Camera"
    static let gallery = "Gallery"
    static let cancel = "Cancel"
}
extension UIView {
    func addGradientWithColor(colorTop: UIColor, colorButton: UIColor){
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [colorTop.cgColor, colorButton.cgColor]
        
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        
        self.layer.insertSublayer(gradient, at: 0)
        
    }
}
extension UINavigationController{
    func setupNavigationPreference(){
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0).withAlphaComponent(0.5)
        UINavigationBar.appearance().tintColor = UIColor.white
  //     navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1).withAlphaComponent(1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
       if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
         popToViewController(vc, animated: animated)
       }
     }
}
