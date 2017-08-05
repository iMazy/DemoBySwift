//
//  DetailViewController.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"

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
    self.navigationItem.title = menuItem[@"title"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hamburgerViewTapped:)];
    self.hamburgerView = [[HamburgerView alloc] initWithFrame: CGRectMake(0, 0, 20, 20)];
    [self.hamburgerView addGestureRecognizer:tapGesture];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.hamburgerView];
}

- (void)hamburgerViewTapped: (UIGestureRecognizer *)gesture {
    UINavigationController *nav = (UINavigationController *)self.parentViewController;
    ViewController *containerVC = (ViewController *)nav.parentViewController;
    [containerVC hideOrShowMenu:!containerVC.showingMenu animated:YES];
}

@end
