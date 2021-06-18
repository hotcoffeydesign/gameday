//
//  SeasonSummeryVC.swift
//  iHOOP
//
//  Created by mac on 06/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class SeasonSummeryVC: BaseViewController {
    //MARK: IBOutlet
    @IBOutlet weak var vwNavigation: UIView!
    @IBOutlet weak var btnBach: UIButton!
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
    
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFt: UIButton!
    @IBOutlet weak var btnFg: UIButton!
    
    //MARK: variable
    var Backtitle:String?
    var player_id: String?
    var game_id: String?
    var season_id: String?
    var playerDetail: PlayerDetail!
    var baseImgUrl = ""
    var playerSummery: PlayerSummeryModel?
    var playerName: String?
    var hashId: String?
    var playersSummery = false
    var finalTempV = Float()
    
    //MARK: default function
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lbl_PlayerName.text = playerName
        self.lbl_PlayerHashID.text = "#\(hashId ?? "")"
        self.hideNvigationBar()
        self.vwNavigation.layerGradient()
        self.btnBach.setTitle(self.Backtitle, for: .normal)
        self.getPlayersList()
    }
    
    //MARK: IBAction
    @IBAction func btnBach(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func BackToPlayerStat(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnThreePtAction(sender:UIButton){
        self.btnThree.isSelected = !self.btnThree.isSelected
       if self.btnThree.isSelected {
        let per = Float(playerSummery?.Three_Hit ?? 0) * 100 / (Float(playerSummery?.Three_Hit ?? 0) + Float(playerSummery?.Three_Mis ?? 0))
        self.lbl_3Pt_MadeAtmpt.text = "\(String(format: "%.1f", per)) %"
       }else{
        self.lbl_3Pt_MadeAtmpt.text = "\((playerSummery?.Three_Hit ?? 0)) - \(((playerSummery?.Three_Hit ?? 0) + (playerSummery?.Three_Mis ?? 0)))"
        }
    }
    
    
    @IBAction func btnFtAction(sender:UIButton){
        self.btnFt.isSelected = !self.btnFt.isSelected
       if self.btnFt.isSelected {
        let per = Float(playerSummery?.FT_Hit ?? 0) * 100 / (Float(playerSummery?.FT_Hit ?? 0) + Float(playerSummery?.FT_Mis ?? 0))
        self.lbl_FT_MadeAtmpt.text = "\(String(format: "%.1f", per)) %"
       }else{
         self.lbl_FT_MadeAtmpt.text = "\(playerSummery?.FT_Hit ?? 0) - \((playerSummery?.FT_Hit ?? 0) + (playerSummery?.FT_Mis ?? 0))"
        }
    }
    
    @IBAction func btnFgAction(sender:UIButton){
        self.btnFg.isSelected = !self.btnFg.isSelected
       if self.btnFg.isSelected {
        let per = Float(playerSummery?.FG_Hit ?? 0) * 100 / (Float(playerSummery?.FG_Hit ?? 0) + Float(playerSummery?.FG_Mis ?? 0))
        self.lbl_FG_MadeAtmpt.text = "\(String(format: "%.1f", per)) %"
       }else{
         self.lbl_FG_MadeAtmpt.text = "\(playerSummery?.FG_Hit ?? 0) - \((playerSummery?.FG_Hit ?? 0) + (playerSummery?.FG_Mis ?? 0))"
        }
    }
    
    
    func getPlayersList(){
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        param[ApiConstant.ApiKey.kPlayerID] = self.player_id
        param[ApiConstant.ApiKey.kgame_id] = self.game_id
        param[ApiConstant.ApiKey.kseason_id] = self.season_id
        
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kplayerGamePoints)
    }
}

extension SeasonSummeryVC:APIManagerDelegate{
    
    func compilation_Success(data: Any, check: String!) {
        print(data)
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
                let a =  Float(playerSummery?.Three_Hit ?? 0) * 3
                let b = Float(playerSummery?.FT_Hit ?? 0) * 1
                let c = Float(playerSummery?.FG_Hit ?? 0) * 2
                let tempV = a + b + c
                if playersSummery == true{
                    finalTempV = tempV / Float((playerSummery?.TotalGame ?? 0))
                }else{
                    finalTempV = tempV
                }
                self.lbl_GamePlayed.text = "\(playerSummery?.TotalGame ?? 0)"
                self.lbl_PSTGame.text = "\(finalTempV)"
                self.lbl_3Pt_MadeAtmpt.text = "\(playerSummery?.Three_Hit ?? 0) - \(((playerSummery?.Three_Hit ?? 0) + (playerSummery?.Three_Mis ?? 0)))"
                
                self.lbl_FT_MadeAtmpt.text = "\(playerSummery?.FT_Hit ?? 0) - \((playerSummery?.FT_Hit ?? 0) + (playerSummery?.FT_Mis ?? 0))"
                
                self.lbl_FG_MadeAtmpt.text = "\(playerSummery?.FG_Hit ?? 0) - \((playerSummery?.FG_Hit ?? 0) + (playerSummery?.FG_Mis ?? 0))"
                
                let rebs = (Float(playerSummery?.Off_Reb ?? 0) + Float(playerSummery?.Def_Reb ?? 0)) / Float(playerSummery?.TotalGame ?? 0)
                
                self.lbl_REBSGame.text = String(format: "%.1f", rebs)
//                let offrebs = (playerSummery?.Off_Reb ?? 0) / (playerSummery?.TotalGame ?? 0)
                self.lbl_OFF_REBSGame.text = String(format: "%.1f", Float(playerSummery?.Off_Reb ?? 0) / Float(playerSummery?.TotalGame ?? 0))
//                let defRebs = (playerSummery?.Def_Reb ?? 0) / (playerSummery?.TotalGame ?? 0)
                self.lbl_DEF_REBSGame.text = String(format: "%.1f", Float(playerSummery?.Def_Reb ?? 0) / Float(playerSummery?.TotalGame ?? 0))
                
                self.lbl_STLSGame.text = String(format: "%.1f", Float(playerSummery?.Stl_Count ?? 0) / Float(playerSummery?.TotalGame ?? 0))
                
                self.lbl_TO_Game.text = String(format: "%.1f", Float(playerSummery?.To_Count ?? 0) / Float(playerSummery?.TotalGame ?? 0))
                self.lbl_BLKS_Game.text = String(format: "%.1f", Float(playerSummery?.Block_Count ?? 0) / Float(playerSummery?.TotalGame ?? 0))
                self.lbl_ASSTSGame.text =  String(format: "%.1f", Float(playerSummery?.Asst_Count ?? 0) / Float(playerSummery?.TotalGame ?? 0))
                self.lbl_PFGame.text = "0.0"
                
                
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg ?? ""){
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    func compilation_Error(data: Any, check: String!) {
        self.showServerErrorMessage(error_data: data)
    }
}

