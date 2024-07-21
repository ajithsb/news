//
//  FlowManager.swift
//  News
//
//  Created by Ajith SB 
//

import UIKit

let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
extension UIViewController{
    func gotoNewsDetailVC(data: ArticleEntity) {
        let  vc  = storyBoard.instantiateViewController(identifier: "NewsDetailsViewController") as NewsDetailsViewController
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
