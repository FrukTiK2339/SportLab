//
//  ModelSheetPresentationController.swift
//  SportLab
//
//  Created by Дмитрий Рыбаков on 17.01.2023.
//

import UIKit

class ModalSheetPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let bounds = containerView?.bounds else { return .zero }
        return CGRect(x: 0, y: bounds.height*3/4, width: bounds.width, height: bounds.height/4)
    }
}
