//
//  GameSeasonVC.swift
//  iHOOP
//
//  Created by mac on 06/03/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import ObjectMapper

class GameSeasonVC: BaseViewController {

    @IBOutlet weak var tblGAmeList:UITableView!
    @IBOutlet weak var tblsessonList:UITableView!
    @IBOutlet weak var btnGame: UIButton!
    @IBOutlet weak var btnSeason: UIButton!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var vwnavigation: UIView!
    //popup view
    @IBOutlet weak var vwGame: UIView!
    
    var backTitle: String?
    var detail = PlayerDetail()
    var arrGamelist = [GameSeasonModal]()
    var arrSeasonList = [GameSeasonModal]()
    var playerId = ""
    var gameSesonIndex = Int()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnAdd.addTarget(self, action: #selector(addSessonAction), for: .touchUpInside)
        btnBack.setTitle(backTitle, for: .normal)
        self.hideNvigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callapiForGameList()
        self.callapiForSessonList()
    }
    
    @IBAction func btnSelectetion(sender: UIButton){
        let button = sender.tag
        switch button {
        case 0:
            self.btnGameSelect()
            btnAdd.setTitle("Add Game", for: .normal)
            print("Game")
            btnAdd.removeTarget(self, action: #selector(addSessonAction), for: .touchUpInside)
            btnAdd.addTarget(self, action: #selector(addGameAction), for: .touchUpInside)
           break
        case 1:
            self.btnSessonSelect()
            btnAdd.setTitle("Add Season", for: .normal)
            btnAdd.removeTarget(self, action:  #selector(addGameAction), for: .touchUpInside)
            btnAdd.addTarget(self, action: #selector(addSessonAction), for: .touchUpInside)
            print("Seasson")
          break
        case 3:
          
            break
        case 4:
              print("back")
              self.navigationController?.popViewController(animated: true)
            break
        default:
            break
            
        }

    }
    
    @objc func addGameAction()  {
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "AddGameVC") as! AddGameVC
        let count = self.arrGamelist.count + 1
        vc.gameName = "Game \(count)"
        vc.player_id = playerId
        vc.playeName = detail.player_name
        vc.hashId = detail.hashID ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addSessonAction()  {
        print("sesson add")
        let count = self.arrSeasonList.count + 1
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "AddseasonVC") as! AddseasonVC
        vc.player_id = playerId
        vc.gameName = "season \(count)"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func btnGameSelect() {
        btnGame.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btnGame.backgroundColor = #colorLiteral(red: 0.03995263949, green: 0.07776782662, blue: 0.3099936843, alpha: 1)
        btnSeason.setTitleColor(#colorLiteral(red: 0.03995263949, green: 0.07776782662, blue: 0.3099936843, alpha: 1), for: .normal)
        btnSeason.backgroundColor = #colorLiteral(red: 0.8657214046, green: 0.858930409, blue: 0.8711194992, alpha: 1)
        self.tblGAmeList.isHidden = false
    }
    
    func btnSessonSelect() {
        btnSeason.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        btnSeason.backgroundColor = #colorLiteral(red: 0.03995263949, green: 0.07776782662, blue: 0.3099936843, alpha: 1)
        btnGame.setTitleColor(#colorLiteral(red: 0.03995263949, green: 0.07776782662, blue: 0.3099936843, alpha: 1), for: .normal)
        btnGame.backgroundColor = #colorLiteral(red: 0.8657214046, green: 0.858930409, blue: 0.8711194992, alpha: 1)
         self.tblGAmeList.isHidden = true
    }
    
}

extension GameSeasonVC:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblGAmeList{
            return arrGamelist.count
        }else{
            return arrSeasonList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CelltblGAmeList", for: indexPath) as! CelltblGAmeList
        if tableView == tblGAmeList{
            let data = arrGamelist[indexPath.row]
            cell.lblName.text = data.game_name
            cell.lblDate.text = "Date: \(data.game_date ?? "")"
            cell.btnVwSummery.tag = indexPath.row
            cell.btnVwSummery.addTarget(self, action: #selector(btnGameViewSummery(sender:)), for: .touchUpInside)
        }else{
            let data = self.arrSeasonList[indexPath.row]
            cell.lblName.text = data.season_name
            cell.lblDate.text = "Date: \(data.season_date ?? "")"
            cell.btnVwSummery.tag = indexPath.row
            cell.btnVwSummery.addTarget(self, action: #selector(btnSeasonViewSummery(sender:)), for: .touchUpInside)
        }
        
        return cell
    }
    
    @objc func btnGameViewSummery(sender: UIButton){
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "GameSummeryVC") as! GameSummeryVC
        vc.player_id = arrGamelist[sender.tag].player_id
        vc.playerName  = detail.player_name?.capitalized
        vc.hashId = self.detail.hashID
        vc.game_id = self.arrGamelist[sender.tag].game_id
        vc.btnBackTitle = self.arrGamelist[sender.tag].game_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func btnSeasonViewSummery(sender: UIButton){
        let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "SeasonSummeryVC") as! SeasonSummeryVC
        vc.player_id = arrSeasonList[sender.tag].player_id
        vc.playerName  = detail.player_name?.capitalized
        vc.hashId = self.detail.hashID
        vc.season_id = self.arrSeasonList[sender.tag].season_id
        vc.game_id = self.arrSeasonList[sender.tag].game_id
        vc.Backtitle = self.arrSeasonList[sender.tag].season_name
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tblsessonList{
            let data = arrSeasonList[indexPath.row]
            let vc = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "SeasonGameVC") as! SeasonGameVC
            vc.playerid = data.player_id ?? ""
            vc.seasonid = data.season_id ?? ""
            vc.sName = data.season_name ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @available(iOS 11.0, *)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        self.gameSesonIndex = indexPath.row
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, view, _) in
            if tableView == self.tblsessonList{
                self.showAnnouncement_YesNo(withMessage: "Do you really want to delete season?", closer_yes: {
                    APIManager.sharedManager.apiManagerDelegate = self
                    var param = [String:Any]()
                    param[ApiConstant.ApiKey.kseason_id] = self.arrSeasonList[indexPath.row].season_id
                    APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kseasondelete)
                })
            }else{
                self.showAnnouncement_YesNo(withMessage: "Do you really want to delete season?", closer_yes: {
                    APIManager.sharedManager.apiManagerDelegate = self
                    var param = [String:Any]()
                    param[ApiConstant.ApiKey.kgame_id] = self.arrGamelist[indexPath.row].game_id
                    APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kgamesdelete)
                })
            }
           
        }
      
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        deleteAction.image = UIImage(named: "delete")
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        return configuration
    }
    
}
extension GameSeasonVC: APIManagerDelegate{
    func callapiForGameList()  {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.kPlayerID] = self.playerId
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kgamelist)
    }
    
    func callapiForSessonList()  {
        APIManager.sharedManager.apiManagerDelegate = self
        var param = [String:Any]()
        param[ApiConstant.ApiKey.kPlayerID] = self.playerId
        APIManager.sharedManager.call_postAPI(dataDict: param, action: ApiConstant.ApiAction.kseasonlist)
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
                self.tblGAmeList.reloadData()
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg!)
            }
        }else if check == ApiConstant.ApiAction.kseasonlist{
            guard let basemodal = Mapper<BaseModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                detail = basemodal.object ?? PlayerDetail()
                self.arrSeasonList = detail.season_list ?? [GameSeasonModal]()
                self.tblsessonList.reloadData()
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
                self.tblGAmeList.reloadData()
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg!)
            }
        }else if check == ApiConstant.ApiAction.kseasondelete{
            guard let basemodal = Mapper<BaseModel<PlayerDetail>>().map(JSON: data as! [String : Any])else{
                print("parsing error")
                self.showAnnouncement(withMessage: LocalizedContants.App.Error.Network.Parser)
                return
            }
            if basemodal.isSuccess{
                self.arrSeasonList.remove(at: self.gameSesonIndex)
                self.tblsessonList.reloadData()
            }
            else{
                self.showAnnouncement(withMessage: basemodal.msg!)
            }
        }
    }
    
    func compilation_Error(data: Any, check: String!) {
        self.showServerErrorMessage(error_data: data )
    }
    
    
}


class CelltblGAmeList: UITableViewCell{
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnVwSummery: UIButton!
}
