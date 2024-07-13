//
//  FlowManager.swift
//  News
//
//  Created by Aj on 13/07/24.
//

import UIKit

let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
extension UIViewController{
    func gotoNewsDetailVC(data: Article?) {
        let  vc  = storyBoard.instantiateViewController(identifier: "NewsDetailsViewController") as NewsDetailsViewController
        vc.data = data
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
