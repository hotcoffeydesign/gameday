//
//  PlayersVC.swift
//  iHOOP
//
//  Created by mac on 24/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
//import SDWebImage

class PlayersVC: BaseViewController, cancel_ok_handle {
    
    func cancel_handle() {
        // Don't logout
    }
    
    func ok_handle() {
        // Log out
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kLogout)
        /*
        self.navigationController?.popToRootViewController(animated: true)
        */
    }
    
    var EditedCellIndex = [2000]
    var arr_players = [PlayerDetail]()
    var baseImgUrl = ""
    
    @IBOutlet weak var tbl_Players:UITableView!
     @IBOutlet weak var VWNavigation:UIView!
    //PopUp
    @IBOutlet weak var vwMenu:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.hideNvigationBar()
        self.getPlayersList()
        self.VWNavigation.layerGradient()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismisMenu))
        self.vwMenu.addGestureRecognizer(tap)
    }
    
    @objc func dismisMenu(){
        self.vwMenu.removeFromSuperview()
    }
    
    @IBAction func btnaSeasonAddtournament(sender: UIButton){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameSeasonVC") as! GameSeasonVC
        vc.backTitle = "players"
        vc.playerId = self.arr_players[sender.tag].player_id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMenuTouch(sender: UIButton){
        let window = UIApplication.shared.keyWindow
        var topPadding = CGFloat()
        if #available(iOS 11.0, *) {
            topPadding = window?.safeAreaInsets.top ?? 0
        }
        self.vwMenu.frame = CGRect(x: 0, y:VWNavigation.frame.height + topPadding, width: view.frame.width, height: view.frame.height)
        view.addSubview(self.vwMenu)
    }

    @IBAction func btn_AddNewplayer(){
        self.vwMenu.removeFromSuperview()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPlayerVC") as! AddNewPlayerVC
        vc.API_type = "add"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btn_LogoutTouch(){
        self.vwMenu.removeFromSuperview()
        self.btn_ShowLogoutPopUp()
    }
    
    func btn_ShowLogoutPopUp(){
        let popVC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        popVC.delegate_cancel_ok = self
        popVC.tempTitle = "Are you sure you want to logout?"
        popVC.modalPresentationStyle = .overCurrentContext
        self.present(popVC, animated: false, completion: nil)
    }
  
    func getPlayersList(){
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        APIManager.sharedManager.call_getAPI(dataDict: param, action: ApiConstant.ApiAction.kplayerList)
    }
}
extension PlayersVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr_players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tbl_Players.dequeueReusableCell(withIdentifier: "cell_tblPlayers", for: indexPath) as! cell_tblPlayers
        
        let url = URL(string: "\(self.baseImgUrl)\(arr_players[indexPath.row].image ?? "")")
        
        cell.lbl_playerRank.text = "#\(arr_players[indexPath.row].hashID ?? "")"
        cell.lbl_playerName.text = "\(arr_players[indexPath.row].fname ?? "") \(arr_players[indexPath.row].lname ?? "")".capitalized
        cell.img_player.sd_setShowActivityIndicatorView(true)
        cell.img_player.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "NewLogo"), options: .scaleDownLargeImages, completed: nil)
        cell.btnViewSummery.tag = indexPath.row
        cell.btnAddTournament.tag = indexPath.row
        cell.btnViewSummery.addTarget(self, action: #selector(ViewSummery(sender:)), for: .touchUpInside)
        cell.btnAddTournament.addTarget(self, action: #selector(btnaSeasonAddtournament(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func ViewSummery(sender: UIButton){
        let data = arr_players[sender.tag]
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "SeasonSummeryVC") as! SeasonSummeryVC
        vc.game_id = ""
        vc.season_id = "0"
        vc.player_id = data.player_id
        vc.Backtitle = "Players"
        vc.playerName = (data.fname ?? "") + " " + (data.lname ?? "")
        vc.hashId = data.hashID
         vc.playersSummery = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    @available(iOS 11.0, *)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, view, _) in
            self.showAnnouncement_YesNo(withMessage: "Are you sure you want to delete this player from the list?", closer_yes: {
                APIManager.sharedManager.apiManagerDelegate = self
                var param = [String:Any]()
                param[ApiConstant.ApiKey.kPlayerID] = self.arr_players[indexPath.section].player_id
                APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kDeletePlayer)
            })
        }

        let Edit = UIContextualAction(style: .normal, title: nil) { (_, view, _) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPlayerVC") as! AddNewPlayerVC
            //   vc.arrEditDetails = SharedPreference.getUserData().id
            //arr_players[indexPath.section]
            vc.playerDetail = self.arr_players[indexPath.row]
            vc.baseImgUrl = self.baseImgUrl
            vc.API_type = "update"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        Edit.backgroundColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        Edit.image = UIImage(named: "edit")
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        deleteAction.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,Edit])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
   
}

extension PlayersVC:APIManagerDelegate{
    
    func compilation_Success(data: Any, check: String!) {
        print(data)
        APIManager.sharedManager.apiManagerDelegate = self
        if check == ApiConstant.ApiAction.kLogout
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                SharedPreference.clearUserData()
                self.showAnnouncement(withMessage: basemodal.msg!) {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg!)
            }
        }else if check == ApiConstant.ApiAction.kplayerList
        {
            guard let basemodal = Mapper<BaseListModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess
            {
                self.baseImgUrl = basemodal.imgURL!
                self.arr_players = basemodal.object! //as! [PlayerDetail]
                self.tbl_Players.reloadData()
            }
            else{
                self.arr_players.removeAll() //as! [PlayerDetail]
                self.tbl_Players.reloadData()
                
                self.showAnnouncement_YesNo(withMessage: "No existing player found. \nDo you want to add first player", closer_yes: {
                    self.btn_AddNewplayer()
                })
                
            }
        }else if check == ApiConstant.ApiAction.kDeletePlayer
        {
            guard let basemodal = Mapper<BaseModel<LoginModel>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.getPlayersList()
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

class cell_tblPlayers: UITableViewCell {
    @IBOutlet weak var img_player:UIImageView!
    @IBOutlet weak var lbl_playerName:UILabel!
    @IBOutlet weak var lbl_playerRank:UILabel!
    @IBOutlet weak var btnViewSummery: UIButton!
    @IBOutlet weak var btnAddTournament: UIButton!
    
}



