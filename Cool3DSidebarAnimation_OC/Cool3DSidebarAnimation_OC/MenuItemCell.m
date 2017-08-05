//
//  MenuItemCell.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "MenuItemCell.h"

@implementation MenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)configForMenuItem: (NSDictionary *) menuItem {
    self.menuImageView.image = [UIImage imageNamed: menuItem[@"image"]];
    NSArray *colorArray = menuItem[@"colors"];
    CGFloat r = [colorArray[0] floatValue];
    CGFloat g = [colorArray[1] floatValue];
    CGFloat b = [colorArray[2] floatValue];
    self.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
