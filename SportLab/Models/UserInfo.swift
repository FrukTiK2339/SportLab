//
//  UserInfo.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 12.01.2023.
//

import UIKit
import CoreData

struct UserInfo {
    var name: String
    var targetWeight: Int
    var currentWeight: Int
    var image: UIImage?
    
    init(name: String, targetWeight: Int, currentWeight: Int, image: UIImage?) {
        self.name = name
        self.targetWeight = targetWeight
        self.currentWeight = currentWeight
        self.image = image
    }
    
    init(from moObject: MOUserInfo) {
        self.name = moObject.name
        self.currentWeight = Int(moObject.currentWeight)
        self.targetWeight = Int(moObject.targetWeight)
        self.image = UIImage(data: moObject.image)
    }
}
