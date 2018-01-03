//
//  XMPresentationController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMPresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        return (self.containerView?.bounds)!.insetBy(dx: 10, dy: 50)
    }

    override func presentationTransitionWillBegin() {
        //若是动画自定义 则需要自己添加视图,上面那个控制大小位置的已经不能用了;
        self.presentedView?.frame = (self.containerView?.bounds)!
        self.containerView?.addSubview(self.presentedView!)

    }

    override func dismissalTransitionDidEnd(_ completed: Bool) {
        self.presentedView?.removeFromSuperview()
    }
}
