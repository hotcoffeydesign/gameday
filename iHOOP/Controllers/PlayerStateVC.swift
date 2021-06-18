//
//  PlayerStateVC.swift
//  iHOOP
//
//  Created by mac on 27/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
//import PathMenu
import ObjectMapper

extension PlayerStateVC{
    func adCircularMenuClickedButton(at buttonIndex: Int32) {
        print("Clicked at : \(buttonIndex)")
        if buttonIndex == 0{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SummaryVC") as! SummaryVC
            vc.playerDetail = self.playerDetail
            
            self.navigationController?.pushViewController(vc, animated: true)
        }else
        {
            let popVC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
            popVC.delegate_cancel_ok = self
            if arrTableData.count > 0
            {
                popVC.tempTitle = "Are you sure you want to exit without saving the game?"
            }
            else{
                popVC.tempTitle = "Are you sure you want to exit?"
            }
            popVC.modalPresentationStyle = .overCurrentContext
            self.present(popVC, animated: false, completion: nil)
        }
    }
}

class PlayerStateVC: BaseViewController, cancel_ok_handle {
    func cancel_handle() {
        
    }
    func ok_handle() {
        self.navigationController?.popToViewController(ofClass: GameSeasonVC.self)
//        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBOutlet var circularMenu:ADCircularMenu!
    //@IBOutlet var view_Menu:UIView!
    @IBOutlet weak var img_player:UIImageView!
    @IBOutlet weak var lbl_playerName:UILabel!
    @IBOutlet weak var lbl_playerRank:UILabel!
    var playerName = ""
    var hasid = ""
    var playerDetail: PlayerDetail?
    var baseImgUrl = ""
    var sGame = false
    var playedid = ""
    var gameid = ""
    var seasonid = ""
    var btnBackTitle = ""
    
    var DefReb_Count = 0
    var OffReb_Count = 0
    var To_Count = 0
    var Stl_Count = 0
    var Asst_Count = 0
    var Block_Count = 0
    var ThreePT_Plus_Count = 0
    var ThreePT_Minus_Count = 0
    var TwoPT_Plus_Count = 0
    var TwoPT_Minus_Count = 0
    var OnePT_Plus_Count = 0
    var OnePT_Minus_Count = 0
    
    var WinLoss = 0
    var arrTableData = [String]()
    var refrence: String?
    var arrValue = [String]()
    @IBOutlet var tblRecord: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNvigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "PLAYER STATE"
    }
    
    @IBAction func btExitTouch(sender: UIButton){
        let popVC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        popVC.delegate_cancel_ok = self
        if arrTableData.count > 0
        {
            popVC.tempTitle = "Are you sure you want to exit without saving the game?"
        }
        else{
            popVC.tempTitle = "Are you sure you want to exit?"
        }
        popVC.modalPresentationStyle = .overCurrentContext
        self.present(popVC, animated: false, completion: nil)
    }
    
    @IBAction func btnUndoTouch(sender: UIButton){
        self.undoValue()
    }
    
    func Win_Loss_API_Call() {
        // Log out
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        //param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        
        param[ApiConstant.saveGameKeys.kPlayerID] = self.playedid
        param[ApiConstant.saveGameKeys.kOnePtHit] = OnePT_Plus_Count
        param[ApiConstant.saveGameKeys.kOnePtMiss] = OnePT_Minus_Count
        param[ApiConstant.saveGameKeys.kTwoPtHit] = TwoPT_Plus_Count
        param[ApiConstant.saveGameKeys.kTwoPtMiss] = TwoPT_Minus_Count
        param[ApiConstant.saveGameKeys.kThreePtHit] = ThreePT_Plus_Count
        param[ApiConstant.saveGameKeys.kThreePtMiss] = ThreePT_Minus_Count
        param[ApiConstant.saveGameKeys.kOffReb] = OffReb_Count
        param[ApiConstant.saveGameKeys.kDefReb] = DefReb_Count
        param[ApiConstant.saveGameKeys.kTo] = To_Count
        param[ApiConstant.saveGameKeys.kSteal] = Stl_Count
        param[ApiConstant.saveGameKeys.kAssist] = Asst_Count
        param[ApiConstant.saveGameKeys.kBlock] = Block_Count
        param[ApiConstant.saveGameKeys.kWinLoss] = WinLoss
        param[ApiConstant.ApiKey.kseason_id] = self.seasonid
        param[ApiConstant.ApiKey.kgame_id] = self.gameid
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kAddGameResult)
    }
    
    @IBAction func win_Touch()    {
        if arrTableData.count > 0
        {
            WinLoss = 1
            self.Win_Loss_API_Call()
        }else{
            self.showAnnouncement(withMessage: "Please add some records to proceed")
        }
    }
    @IBAction func loss_Touch()    {
        if arrTableData.count > 0
        {
            WinLoss = 0
            self.Win_Loss_API_Call()
        }else{
            self.showAnnouncement(withMessage: "Please add some records to proceed")
        }
    }
    @IBAction func draw_Touch()    {
        
           if arrTableData.count > 0
           {
               WinLoss = 2
               self.Win_Loss_API_Call()
           }else{
               self.showAnnouncement(withMessage: "Please add some records to proceed")
           }
       }
   
    @IBAction func Def_Reb_Touch()    {
        arrValue.append("DefReb_Count")
     
        DefReb_Count += 1
        //arrTableData.insert("dreb :,(\(DefReb_Count)),black", at: 0)
        arrTableData.append("dreb:,(\(DefReb_Count)),black")
        self.refreshTableView()
    }
    @IBAction func Off_Reb_Touch()    {
        arrValue.append("OffReb_Count")
 
        OffReb_Count += 1
        arrTableData.append("oreb:,(\(OffReb_Count)),black")
        self.refreshTableView()
    }
    @IBAction func To_Touch()    {
        arrValue.append("To_Touch")
        To_Count += 1
        arrTableData.append("to:,(\(To_Count)),black")
        self.refreshTableView()
    }
    @IBAction func Stl_Touch()    {
        arrValue.append("Stl_Count")
        
        Stl_Count += 1
        arrTableData.append("stl:,(\(Stl_Count)),black")
        self.refreshTableView()
    }
    @IBAction func Asst_Touch()    {
        arrValue.append("Asst_Count")
       
        Asst_Count += 1
        arrTableData.append("ast:,(\(Asst_Count)),black")
        self.refreshTableView()
    }
    @IBAction func Block_Touch()    {
        arrValue.append("Block_Count")
       
        Block_Count += 1
        arrTableData.append("blk:,(\(Block_Count)),black")
        self.refreshTableView()
    }
    
    
    @IBAction func ThreePT_Plus_Touch()    {
        arrValue.append("ThreePT_Plus_Count")
        ThreePT_Plus_Count += 1
        arrTableData.append("3pt:,\(ThreePT_Plus_Count)-\(ThreePT_Plus_Count+ThreePT_Minus_Count) 3pt,green")
        self.refreshTableView()
    }
    @IBAction func ThreePT_Minus_Touch()    {
        arrValue.append("ThreePT_Minus_Count")
        ThreePT_Minus_Count += 1
        arrTableData.append("3pt miss:,\(ThreePT_Plus_Count)-\(ThreePT_Plus_Count+ThreePT_Minus_Count) 3pt,red")
        self.refreshTableView()
    }
    @IBAction func TwoPT_Plus_Touch()    {
        arrValue.append("TwoPT_Plus_Count")
        refrence = "TwoPT_Plus_Count"
        TwoPT_Plus_Count += 1
        arrTableData.append("2pt:,\(TwoPT_Plus_Count)-\(TwoPT_Plus_Count+TwoPT_Minus_Count) fg,green")
        self.refreshTableView()
    }
    @IBAction func TwoPT_Minus_Touch()    {
        arrValue.append("TwoPT_Minus_Count")
        TwoPT_Minus_Count += 1
        arrTableData.append("2pt miss:,\(TwoPT_Plus_Count)-\(TwoPT_Plus_Count+TwoPT_Minus_Count) fg,red")
        self.refreshTableView()
    }
    @IBAction func OnePT_Plus_Touch()    {
        arrValue.append("OnePT_Plus_Count")
        refrence = "OnePT_Plus_Count"
        OnePT_Plus_Count += 1
        arrTableData.append("1pt:,\(OnePT_Plus_Count)-\(OnePT_Plus_Count+OnePT_Minus_Count) ft,green")
        self.refreshTableView()
    }
    @IBAction func OnePT_Minus_Touch()    {
        arrValue.append("OnePT_Minus_Count")
        refrence = "OnePT_Minus_Count"
        OnePT_Minus_Count += 1
        arrTableData.append("1pt miss:,\(OnePT_Plus_Count)-\(OnePT_Plus_Count+OnePT_Minus_Count) ft,red")
        self.refreshTableView()
    }
    
    func undoValue(){
        print("undo array \(arrValue)")
        if arrTableData.count != 0 && arrTableData.count > 0{

            if arrValue.last == "DefReb_Count"{
               DefReb_Count -= 1
            }else if arrValue.last == "OffReb_Count"{
                OffReb_Count -= 1
            }else if arrValue.last == "To_Touch"{
                To_Count -= 1
            }else if arrValue.last == "Stl_Count"{
                Stl_Count -= 1
            }else if arrValue.last == "Asst_Count"{
                Asst_Count -= 1
            }else if arrValue.last == "Block_Count"{
                Block_Count -= 1
            }else if arrValue.last == "ThreePT_Plus_Count"{
                ThreePT_Plus_Count -= 1
            }else if arrValue.last == "ThreePT_Minus_Count"{
                ThreePT_Minus_Count -= 1
            }else if arrValue.last == "TwoPT_Plus_Count"{
                TwoPT_Plus_Count -= 1
            }else if arrValue.last == "TwoPT_Minus_Count"{
                TwoPT_Minus_Count -= 1
            }else if arrValue.last == "OnePT_Plus_Count"{
                OnePT_Plus_Count -= 1
            }else if arrValue.last == "OnePT_Minus_Count"{
                OnePT_Minus_Count -= 1
            }
            self.arrValue.removeLast()
            self.arrTableData.removeLast()
            self.tblRecord.reloadData()
        }
        
    }
    
    func refreshTableView()
    {
//        self.tblRecord.reloadData()
        self.tblRecord.beginUpdates()
        self.tblRecord.insertRows(at: [IndexPath.init(row: self.arrTableData.count-1, section: 0)], with: .automatic)
        self.tblRecord.endUpdates()
        
        self.scrollToBottom()
    }
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.arrTableData.count-1, section: 0)
            self.tblRecord.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
}
class cell_PlayerRecord: UITableViewCell
{
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblValue: UILabel!
    
}
extension PlayerStateVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTableData.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblRecord.dequeueReusableCell(withIdentifier: "cell_PlayerRecord", for: indexPath) as! cell_PlayerRecord
        cell.lblTitle.text = arrTableData[indexPath.row].commaSaparatedComponents[0]
        cell.lblValue.text = arrTableData[indexPath.row].commaSaparatedComponents[1]
        
        cell.lblTitle.font = UIFont.systemFont(ofSize: 15.0)
        if arrTableData[indexPath.row].commaSaparatedComponents[2] == "red"
        {
            cell.lblTitle.textColor = UIColor.red
        }else if arrTableData[indexPath.row].commaSaparatedComponents[2] == "green"
        {
            cell.lblTitle.textColor = UIColor.init(red: 72.0/255.0, green: 199.0/255.0, blue: 72.0/255.0, alpha: 1.0)
        }else if arrTableData[indexPath.row].commaSaparatedComponents[2] == "black"
        {
            cell.lblTitle.font = UIFont.boldSystemFont(ofSize: 14.0)
            cell.lblTitle.textColor = UIColor.white//UIColor.init(red: 255.0/255.0, green: 147.0/255.0, blue: 0.0/255.0, alpha: 0.7)
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
extension PlayerStateVC: APIManagerDelegate{
    
    func compilation_Success(data: Any, check: String!) {
        print(data)
        APIManager.sharedManager.apiManagerDelegate = self
        if check == ApiConstant.ApiAction.kAddGameResult
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.showAnnouncement(withMessage: "Record saved successfully"/*basemodal.msg!*/) {
                    let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "GameSummeryVC") as! GameSummeryVC
                    vc.playerName = self.playerName
                    vc.hashId = self.hasid
                    vc.btnBackTitle = self.btnBackTitle
                    vc.player_id = self.playedid
                    vc.game_id = self.gameid
                    vc.sesionid = self.seasonid
                    vc.Sgame = self.sGame
                    self.navigationController?.pushViewController(vc, animated: true)
                }
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
extension UIImage{
    
    func resizeImageWith(newSize: CGSize) -> UIImage {
        
        let horizontalRatio = newSize.width / size.width
        let verticalRatio = newSize.height / size.height
        
        let ratio = max(horizontalRatio, verticalRatio)
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: newSize))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

