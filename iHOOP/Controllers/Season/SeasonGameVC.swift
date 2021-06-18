//
//  SeasonGameVC.swift
//  iHOOP
//
//  Created by mac on 07/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class SeasonGameVC: BaseViewController {

    @IBOutlet weak var tblSgameList: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    var detail = PlayerDetail()
    var arrGamelist = [GameSeasonModal]()
    var playerid = ""
    var gameid = ""
    var seasonid = ""
    var sName = ""
    var gameSesonIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnBack.setTitle(sName, for: .normal)
        self.hideNvigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.callapiForSeasonGameList()
    }
    
    @IBAction func BackButton(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddGame(sender: UIButton){
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "AddGameVC") as! AddGameVC
        let count = self.arrGamelist.count + 1
        vc.player_id = self.playerid
        vc.season_id = self.seasonid
        vc.gameName = "\(self.sName) G-\(count)"
        vc.playeName = detail.player_name ?? ""
        vc.hashId = detail.hashID ?? ""
        vc.sGame = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension SeasonGameVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGamelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSgameList.dequeueReusableCell(withIdentifier: "CelltblGAmeList", for: indexPath) as! CelltblGAmeList
        let data = arrGamelist[indexPath.row]
        cell.lblName.text = data.game_name
        cell.lblDate.text = "Date: \(data.game_date ?? "")"
        cell.btnVwSummery.tag = indexPath.row
        cell.btnVwSummery.addTarget(self, action: #selector(btnGameViewSummery(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func btnGameViewSummery(sender: UIButton){
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "GameSummeryVC") as! GameSummeryVC
        vc.player_id = arrGamelist[sender.tag].player_id
        vc.playerName  = detail.player_name?.capitalized
        vc.hashId = self.detail.hashID
        vc.game_id = self.arrGamelist[sender.tag].game_id
        vc.sesionid = self.arrGamelist[sender.tag].season_id
        vc.btnBackTitle = self.arrGamelist[sender.tag].game_name
        vc.Sgame = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    @available(iOS 11.0, *)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        self.gameSesonIndex = indexPath.row
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, view, _) in
           
                self.showAnnouncement_YesNo(withMessage: "Do you really want to delete season?", closer_yes: {
                    APIManager.sharedManager.apiManagerDelegate = self
                    var param = [String:Any]()
                    param[ApiConstant.ApiKey.kgame_id] = self.arrGamelist[indexPath.row].game_id
                    APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kgamesdelete)
                })
            
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        deleteAction.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
}
extension SeasonGameVC: APIManagerDelegate{
    func callapiForSeasonGameList()  {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.kPlayerID] = self.playerid
        param[ApiConstant.ApiKey.kseason_id] = self.seasonid
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kgamelist)
    }
    
    func compilation_Success(data: Any, check: String!) {
        print(data)
        APIManager.sharedManager.apiManagerDelegate = self
       if check == ApiConstant.ApiAction.kgamelist
        {
            guard let basemodal = Mapper<BaseModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                detail = basemodal.object ?? PlayerDetail()
                self.arrGamelist = detail.game_list ?? [GameSeasonModal]()
                self.tblSgameList.reloadData()
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg!)
            }
        }else if check == ApiConstant.ApiAction.kgamesdelete{
            guard let basemodal = Mapper<BaseModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.arrGamelist.remove(at: self.gameSesonIndex)
                self.tblSgameList.reloadData()
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
