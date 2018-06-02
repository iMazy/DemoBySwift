//
//  DetailViewController.h
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HamburgerView.h"

@interface DetailViewController : UIViewController

@property (nonatomic, strong) NSDictionary *menuItem;

@property (nonatomic, strong) HamburgerView *hamburgerView;

@end
