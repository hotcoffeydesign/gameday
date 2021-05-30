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
    
    //@IBOutlet weak var View_LogoutPopUpView:UIView!
    var arrRank = ["12","212","45", "456","12","212","45", "456","12","212","45"]
    var arrPlayersName = ["gfdgdfg","gdfgdfg","gfgdfg","gfgdf","gffdgdfg","gfdgdfg","gdfgdfg","gfgdfg","gfgdf","gffdgdfg","jeevan"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupBack()
       
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.showNavigationBar()
        self.HideBackButton()
        
//        self.tbl_Players.reloadData()
        self.getPlayersList()
    }
    func setupBack(){
        let btn1 = UIButton(type: .custom)
        btn1.setImage(UIImage(named: "add-user"), for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn1.addTarget(self, action: #selector(btn_AddNewplayer), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        
        let btn2 = UIButton(type: .custom)
        btn2.setImage(UIImage(named: "logout"), for: .normal)
        btn2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn2.addTarget(self, action: #selector(btn_ShowLogoutPopUp), for: .touchUpInside)
        let item2 = UIBarButtonItem(customView: btn2)
        
        self.navigationItem.setRightBarButtonItems([item2,item1], animated: true)
    }
    @objc func btn_AddNewplayer(){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewPlayerVC") as! AddNewPlayerVC
        vc.API_type = "add"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc func btn_ShowLogoutPopUp(){
        /*
        self.View_LogoutPopUpView.frame = view.bounds
        self.view.addSubview(View_LogoutPopUpView)
        self.View_LogoutPopUpView.isHidden = false
        self.View_LogoutPopUpView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3975545805)
        */
        let popVC = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "PopUpVC") as! PopUpVC
        popVC.delegate_cancel_ok = self
        popVC.tempTitle = "Are you sure you want to logout?"
        popVC.modalPresentationStyle = .overCurrentContext
        self.present(popVC, animated: false, completion: nil)
    }
    
    @IBAction func btn_dismissLogoutPopupVC( sender: UIButton){
        
    }
    @IBAction func btn_LogoutYes( sender: UIButton){
      self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    func getPlayersList()
    {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.ktoken] = SharedPreference.getUserData().token
        //        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kplayerList)
        APIManager.sharedManager.call_getAPI(dataDict: param, action: ApiConstant.ApiAction.kplayerList)
    }
}
extension PlayersVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return  arr_players.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_Players.dequeueReusableCell(withIdentifier: "cell_tblPlayers", for: indexPath) as! cell_tblPlayers
        let url = URL(string: "\(self.baseImgUrl)\(arr_players[indexPath.section].image ?? "")")
        cell.lbl_playerRank.text = "# \(arr_players[indexPath.section].hashID.replacingOccurrences(of: "#", with: "").replacingOccurrences(of: " ", with: ""))"
        cell.lbl_playerName.text = "\(arr_players[indexPath.section].fname ?? "") \(arr_players[indexPath.section].lname ?? "")".capitalized
        cell.img_player.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "player_grey_right"), options: .scaleDownLargeImages, completed: nil)
        
        cell.contentView.layer.cornerRadius = 30
        cell.contentView.clipsToBounds = true
        cell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3963505993)
        cell.lbl_playerName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cell.lbl_playerRank.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        if EditedCellIndex.contains(indexPath.row) && EditedCellIndex.count > 1
        {
            EditedCellIndex.removeFirst()
        }else if EditedCellIndex.contains(indexPath.row) && EditedCellIndex.count == 0{
            EditedCellIndex[0] = 2000
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15.0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        self.tbl_Players?.tableFooterView = footerView
        return footerView
    }
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?)
    {
        print("\(indexPath?.section ?? 0)")
        
        if EditedCellIndex.count > 1
        {
            EditedCellIndex.removeFirst()
        }else{
            EditedCellIndex[0] = 2000
        }
        
        guard  let cell = tbl_Players.cellForRow(at: indexPath!) //as! cell_tblPlayers
            else{
                return
        }
        let cellTmp = cell as! cell_tblPlayers
        cellTmp.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3963505993)
        cellTmp.lbl_playerName.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        cellTmp.lbl_playerRank.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let cell = tbl_Players.cellForRow(at: indexPath) as! cell_tblPlayers
        if EditedCellIndex.count > 0 && EditedCellIndex[0] == 2000
        {
            EditedCellIndex[0] = indexPath.section
        }else{
            EditedCellIndex.append(indexPath.section)
        }
        cell.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        cell.lbl_playerName.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.lbl_playerRank.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
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
            vc.playerDetail = self.arr_players[indexPath.section]
            vc.baseImgUrl = self.baseImgUrl
            vc.API_type = "update"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        Edit.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "greenCircle")!)// #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
        Edit.image = UIImage(named: "edit")
        deleteAction.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "redCircle")!)// #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        deleteAction.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction,Edit])
        return configuration
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerStateVC") as! PlayerStateVC
        vc.playerDetail = arr_players[indexPath.section]
        vc.baseImgUrl = self.baseImgUrl
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PlayersVC:APIManagerDelegate
{
    
    func compilation_Success(data: Any, check: String!) {
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
    
}



