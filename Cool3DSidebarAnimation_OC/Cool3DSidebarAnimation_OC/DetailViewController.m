//
//  DetailViewController.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation DetailViewController

- (void)setMenuItem:(NSDictionary *)menuItem {
    _menuItem = menuItem;
    
    NSArray *colorArray = menuItem[@"colors"];
    CGFloat r = [colorArray[0] floatValue];
    CGFloat g = [colorArray[1] floatValue];
    CGFloat b = [colorArray[2] floatValue];
    self.view.backgroundColor = [UIColor colorWithRed: r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
    
    self.backgroundImageView.image = [UIImage imageNamed:menuItem[@"bigImage"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
