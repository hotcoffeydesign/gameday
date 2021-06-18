//
//  SummaryVC.swift
//  iHOOP
//
//  Created by mac on 29/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import ObjectMapper
class SummaryVC: BaseViewController {
    
    var playerDetail: PlayerDetail!
    var baseImgUrl = ""
    
    @IBOutlet weak var lbl_PlayerName:UILabel!
    @IBOutlet weak var lbl_PlayerHashID:UILabel!
    @IBOutlet weak var lbl_GamePlayed:UILabel!
    @IBOutlet weak var lbl_MINIGame:UILabel!
    @IBOutlet weak var lbl_PSTGame:UILabel!
    @IBOutlet weak var lbl_3Pt_MadeAtmpt:UILabel!
    @IBOutlet weak var lbl_FT_MadeAtmpt:UILabel!
    @IBOutlet weak var lbl_FG_MadeAtmpt:UILabel!
    @IBOutlet weak var lbl_REBSGame:UILabel!
    @IBOutlet weak var lbl_OFF_REBSGame:UILabel!
    @IBOutlet weak var lbl_DEF_REBSGame:UILabel!
    @IBOutlet weak var lbl_PFGame:UILabel!
    @IBOutlet weak var lbl_STLSGame:UILabel!
    @IBOutlet weak var lbl_TO_Game:UILabel!
    @IBOutlet weak var lbl_BLKS_Game:UILabel!
    @IBOutlet weak var lbl_ASSTSGame:UILabel!
    
    var playerSummery: PlayerSummeryModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showNavigationBar()
        self.title = "SUMMARY"
        self.HideBackButton()
        self.setupBack()
        self.getPlayersList()
        //print("playerDetail: \(playerDetail)")
        
        self.lbl_PlayerName.text = "\(playerDetail.fname ?? "") \(playerDetail.lname ?? "")".capitalized
        self.lbl_PlayerHashID.text = "#\(playerDetail.hashID?.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: " ", with: ""))"
        
    }
    func setupBack(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "back"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        btn1.addTarget(self, action: #selector(BackToPlayerStat), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setLeftBarButtonItems([item1], animated: true)
    }
    @objc func BackToPlayerStat(){
        self.navigationController?.popViewController(animated: true)
    }
    func getPlayersList()
    {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        param[ApiConstant.ApiKey.kPlayerID] = playerDetail.player_id
       
    
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kplayerGamePoints)
    }
}
extension SummaryVC:APIManagerDelegate
{
    
    func compilation_Success(data: Any, check: String!) {
        APIManager.sharedManager.apiManagerDelegate = self
        if check == ApiConstant.ApiAction.kplayerGamePoints
        {
            guard let basemodal = Mapper<BaseModel<PlayerSummeryModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                
                playerSummery = basemodal.object
                print(playerSummery)
                
//                self.lbl_GamePlayed.text = "\(playerSummery.TotalGame ?? 0.0)"
                self.lbl_MINIGame.text = "0"
//                let tempV = (CGFloat.init(Float.init(playerSummery.Three_Hit)!)+CGFloat.init(Float.init(playerSummery.FT_Hit)!)+CGFloat.init(Float.init(playerSummery.FG_Hit)!))/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_PSTGame.text = String(format:"%.01f", tempV)
//                self.lbl_3Pt_MadeAtmpt.text = "\(playerSummery.Three_Hit ?? "") - \(playerSummery.Three_Hit.integerValue + playerSummery.Three_Mis.integerValue )"
//                self.lbl_FT_MadeAtmpt.text = "\(playerSummery.FT_Hit ?? "") - \(playerSummery.FT_Hit.integerValue + playerSummery.FT_Mis.integerValue )"
//                self.lbl_FG_MadeAtmpt.text = "\(playerSummery.FG_Hit ?? "") - \(playerSummery.FG_Hit.integerValue + playerSummery.FG_Mis.integerValue )"
//                let tempV_0 = (CGFloat.init(Float.init(playerSummery.Off_Reb)!)+CGFloat.init(Float.init(playerSummery.Def_Reb)!))/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_REBSGame.text = String(format:"%.01f", tempV_0)
//                let tempV_1 = CGFloat.init(Float.init(playerSummery.Off_Reb)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_OFF_REBSGame.text = String(format:"%.01f", tempV_1)
//                let tempV_2 = CGFloat.init(Float.init(playerSummery.Def_Reb)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_DEF_REBSGame.text = String(format:"%.01f", tempV_2)
//                self.lbl_PFGame.text = "0"
//                let tempV_3 = CGFloat.init(Float.init(playerSummery.Stl_Count)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_STLSGame.text = String(format:"%.01f", tempV_3)//playerSummery.Stl_Count
//                let tempV_4 = CGFloat.init(Float.init(playerSummery.To_Count)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_TO_Game.text = String(format:"%.01f", tempV_4)//playerSummery.To_Count
//                let tempV_5 = CGFloat.init(Float.init(playerSummery.Block_Count)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_BLKS_Game.text = String(format:"%.01f", tempV_5)//playerSummery.Block_Count
//                let tempV_6 = CGFloat.init(Float.init(playerSummery.Asst_Count)!)/CGFloat.init(Float.init(playerSummery.TotalGame)!)
//                self.lbl_ASSTSGame.text = String(format:"%.01f", tempV_6)//playerSummery.Asst_Count
                
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
