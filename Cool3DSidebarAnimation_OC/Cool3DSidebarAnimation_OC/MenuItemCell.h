//
//  MenuItemCell.h
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;

- (void)configForMenuItem: (NSDictionary *) menuItem;

@end
