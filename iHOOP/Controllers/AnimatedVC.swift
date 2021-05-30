//
//  AnimatedVC.swift
//  iHOOP
//
//  Created by mac on 29/05/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AnimatedVC: BaseViewController {
    
    @IBOutlet weak var View_AnimateView1:UIView!
    @IBOutlet weak var View_AnimateView2:UIView!
    
    var tempV_1 = CGFloat.init(0.0)
    var tempV_2 = CGFloat.init(0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNvigationBar()
        
        tempV_1 =  View_AnimateView1.frame.origin.x
        tempV_2 =  View_AnimateView2.frame.origin.x
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.animation(viewAnimation: self.View_AnimateView1)
        self.animation2(viewAnimation: self.View_AnimateView2)
      
        self.perform(#selector(GoToFirstPage), with: nil, afterDelay: 3.0)
       
        self.hideNvigationBar()
    }
   
    @objc func GoToFirstPage()  {
        let newController = MainClass.mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(newController, animated: false)
    }
    
    func animation(viewAnimation: UIView)
    {
        //let tempV = viewAnimation.frame.origin.x
        viewAnimation.frame.origin.x = self.tempV_1 + viewAnimation.frame.width + viewAnimation.frame.width + viewAnimation.frame.width
        //viewAnimation.frame.origin.x = 0 - (tempV + viewAnimation.frame.width)
        
        UIView.animate(withDuration: 1.5, animations: {
            viewAnimation.frame.origin.x = self.tempV_1 - 60
            //viewAnimation.frame.origin.x =  tempV + viewAnimation.frame.width + 200
            print(viewAnimation.frame.width)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                viewAnimation.frame.origin.x = self.tempV_1 + 30 //viewAnimation.frame.width
                //viewAnimation.frame.origin.x = 20
                print(viewAnimation.frame.width)
            }) { (_) in
                viewAnimation.layer.removeAllAnimations()
            }
        }
    }
    
    func animation2(viewAnimation: UIView)
    {
        //let tempV = viewAnimation.frame.origin.x
        viewAnimation.frame.origin.x = tempV_2 - (viewAnimation.frame.width + viewAnimation.frame.width + viewAnimation.frame.width)
        
        UIView.animate(withDuration: 1.5, delay: 0, options: [.curveLinear], animations: {
            //viewAnimation.frame.origin.x = viewAnimation.frame.width// - (viewAnimation.frame.width)/2
            viewAnimation.frame.origin.x = self.tempV_2 + 60
            print(viewAnimation.frame.width)
        }) { (_) in
            UIView.animate(withDuration: 0.5, animations: {
                viewAnimation.frame.origin.x = self.tempV_2 - 30 //viewAnimation.frame.width
                //viewAnimation.frame.origin.x = 20
                print(viewAnimation.frame.width)
            }) { (_) in
                viewAnimation.layer.removeAllAnimations()
            }
        }
    }
    
    
}

