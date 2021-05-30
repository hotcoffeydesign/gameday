//
//  Network.swift
//  TheHotter
//
//  Created by user on 21/8/2017.
//  Copyright © Ajayy infograins. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration
import UIKit
//import RSLoadingView

protocol NetworkRequestResourceType {
    var path: String {get}
    var method: Alamofire.HTTPMethod {get}
    var param: [String: Any] {get}
    var url:URL{get}
}

struct NetworkRequestResource: NetworkRequestResourceType {
    var path: String
    var method: Alamofire.HTTPMethod
    var param: [String : Any]
    
    var url:URL{
        return URL(string: self.path)!
    }
}
extension UIView{

    func alertForAuthentication(){
        
        let alert = UIAlertController(title: "Login error", message: "Something went wrong, it seems your account used on another device", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (alertAction) in
            SharedPreference.clearUserData()
            
            let loginVC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            MainClass.appDelegate.navController = UINavigationController(rootViewController: loginVC)
            MainClass.appDelegate.window?.rootViewController = MainClass.appDelegate.navController
        }))
        
        MainClass.appDelegate.window?.rootViewController?.present(alert, animated: false, completion: {
        })
    }
    
    func getHUD(spinner:UIActivityIndicatorView) -> UIView{
        let window = UIApplication.shared.delegate?.window
        window??.resignFirstResponder()
        let view = UIView(frame: UIScreen.main.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.center = (window??.rootViewController?.view.center)!
        spinner.center = view.center
        spinner.startAnimating()
        view.addSubview(spinner)
        window??.addSubview(view)
        return view
    }
}
class Network  {
  
    final class func dataTask(_ path: URL, method: HTTPMethod, param: Dictionary<String, Any>, compiletionBlock:@escaping (_ result: Result<Any, NSError> ) -> Void){
        
        if !Connectivity.isConnectedToInternet {
            let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "No internet connection available"]);
            compiletionBlock(.failure(customError))
            return
        }
        
        let hudView = UIView().getHUD(spinner: UIActivityIndicatorView())
        //let loadingView = RSLoadingView()
        //loadingView.show(on: appD.window!)
        
        //let auth = SPTAuth.defaultInstance()
        var headers = [String: String]()
        
            headers = ["x-api-key" : "13!4#8%4&5(#$445%4"]//["x-api-key" : "TLB_5AAF884F75F3F"]
        
        /*
        if (("\(path)".range(of: "//api.spotify.com/v1/")) != nil)
        {
            headers = ["Accept" : "application/json",
                       "Authorization" : "Bearer"]
        }*/
        if SharedPreference.getUserData().token != nil{
            headers["token"] = "\(SharedPreference.getUserData().token ?? "")".replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
        }
        
        self.sharedAlamofire.request(path, method: method, parameters: param, encoding: URLEncoding.default, headers: headers).responseJSON { (response:DataResponse<Any>) in
            
            
            switch(response.result) {
            case .success(let JSON):
                hudView.removeFromSuperview()
                //loadingView.hide()
                
                let status = (JSON as? NSDictionary)?.value(forKey: "status") as? Int
                if status == 401 {
                    UIView().alertForAuthentication()
                }else{
                    compiletionBlock(.success(JSON))
                }
                
                break
            case .failure(_):
                //let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding!"]);
                /*
                self.sharedAlamofire.request(path, method: method, parameters: param, encoding: URLEncoding.default, headers: headers).responseString(completionHandler: { (strResponse: DataResponse<String>) in
                    print("//////////// responseString: \(strResponse)")
                    let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : response.error ?? "\(strResponse)"]);
                    compilationBlock(.failure(customError))
                    hudView.removeFromSuperview()
                    //break
                })
                */
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : response.error ?? "Server Not Responding!"]);
                
                compiletionBlock(.failure(customError))
                hudView.removeFromSuperview()
                //loadingView.hide()
                break
                
            }
        }
    }
    
    static func log(resource: NetworkRequestResourceType) {
        let greeting = "\n\n*********************************************\n\n"
        var debugString = greeting;
        
        debugString += (resource.path  + resource.param.apiDebug)
        debugString += greeting
        print("\n\n==============NetworkRequest===============:\(debugString)\n\n")
    }
    
    class func networkRequest(_ resource:NetworkRequestResourceType , compilation: @escaping (Result<Any, NSError>) -> Void){
        self.log(resource:resource)
        Network.dataTask(resource.url, method: resource.method, param: resource.param) {
            compilation($0)
        }
    }
    
    final class func uploadData(_ resource: NetworkRequestResourceType, compilationBlock: @escaping (_ result: Result<Any, NSError>) -> Void){
        self.log(resource:resource)
        
        if !Connectivity.isConnectedToInternet {
            let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "No internet connection available"]);
            compilationBlock(.failure(customError))
            return
        }
        
        let hudView = UIView().getHUD(spinner: UIActivityIndicatorView())
        
        var headers = [String: String]()
        //if (("\(path)".range(of: "//api.spotify.com/v1/")) != nil)
        //{
        headers = ["x-api-key" : "13!4#8%4&5(#$445%4"]
        //}
        /*
         if (("\(path)".range(of: "//api.spotify.com/v1/")) != nil)
         {
         headers = ["Accept" : "application/json",
         "Authorization" : "Bearer"]
         }*/
        if SharedPreference.getUserData().token != nil{
            headers["token"] = "\(SharedPreference.getUserData().token ?? "")".replacingOccurrences(of: "Optional(", with: "").replacingOccurrences(of: ")", with: "")
        }
        
        self.sharedAlamofire.uploadWithToken(multipartFormData: { (multipartFormData) in
            for  (key, value) in resource.param
            {
                print("key:::: \(key)")
                /*if key == APIConstants.SaveFolio.kInner_imageArray
                {
                    print("Key: \(key), Value: \(value)")
                    let tmpArr = value as! NSMutableArray
                    for i in 0 ..< tmpArr.count
                    {
                        let url = tmpArr[i] as! URL
                        //multipartFormData.append(url, withName: key)
                        multipartFormData.append(url, withName: key.replacingOccurrences(of: "[]", with: "[\(i)]"))
                    }
                }
                else */if value is URL{
                    let url = value as! URL
                    multipartFormData.append(url, withName: key)
                }else {
                    multipartFormData.append((value as AnyObject).data!(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }
        }, to: resource.url, headers: headers, encodingCompletion:  {
            (encodingResult) in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    print(".............Upload Progress: \(Progress.fractionCompleted)")
                })
                upload.responseJSON { response in
                    hudView.removeFromSuperview()
                    switch response.result
                    {
                    case .success(let result):
                        compilationBlock(.success(result))
                    case .failure(let error):
                        let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : error.localizedDescription]);
                        compilationBlock(.failure(customError))
                    }
                }
                
            case .failure( _ as NSError):
                hudView.removeFromSuperview()
                let customError = NSError(domain: "Network", code: 67, userInfo: [NSLocalizedDescriptionKey : "Server Not Responding!"]);
                compilationBlock(.failure(customError))
            default:
                break
            }
        })
 
        
        
    }
    
    
    class func urlRequest(_ urlString:String) -> NSMutableURLRequest {
        return NSMutableURLRequest(url: URL(string: urlString)!, cachePolicy: .returnCacheDataElseLoad , timeoutInterval: kTimeOutInterval)
    }
    
    class func downloadImage(_ urlString:String, compilation:@escaping (_ result: Data) -> Void){
        self.sharedAlamofire.request(self.urlRequest(urlString) as! URLRequestConvertible).response(completionHandler: { (response) in
            
            guard let data = response.data else {return}
            compilation(data)
            
        })
    }
    
    init(){
        
    }
    static fileprivate let kTimeOutInterval:Double = 210//3.5 minutes
    
    static fileprivate var sharedAlamofire:SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = kTimeOutInterval
        configuration.timeoutIntervalForRequest =  kTimeOutInterval
        let alamoFireManager = Alamofire.SessionManager(configuration: configuration)
        
        
        
        return alamoFireManager
    }()
    
    class func downloadFileToLocal(_ fileToDownload: URL, fileToStoreLocation: URL, compilation:@escaping (_ localPath: URL?) -> Void){
        
        do {
            
            let request = try URLRequest(url: fileToDownload, method: .get)
            
            self.sharedAlamofire.download(request, to: { (url, urlReponse) -> (destinationURL: URL, options: DownloadRequest.DownloadOptions) in
                
                return (fileToStoreLocation, DownloadRequest.DownloadOptions.removePreviousFile)
            }).response(completionHandler: { (response) in
                compilation(response.destinationURL)
            })
            
            
        }catch (_) {
            
        }
    }
}

class Connectivity {
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}

