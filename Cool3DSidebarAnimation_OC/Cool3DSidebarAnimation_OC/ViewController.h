//
//  ViewController.h
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) DetailViewController *detailVC;

@property (nonatomic, assign) BOOL showingMenu;

@property (nonatomic, strong) NSDictionary *menuItem;

- (void) hideOrShowMenu:(BOOL)show animated: (BOOL)animated;

@end

