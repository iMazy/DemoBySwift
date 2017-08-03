//
//  ViewController.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *menuContainerView;

@end

@implementation ViewController

- (void)setMenuItem:(NSDictionary *)menuItem {
    _menuItem = menuItem;
    [self hideOrShowMenu:NO animated:YES];
    self.detailVC.menuItem = menuItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideOrShowMenu:NO animated:NO];
    
    self.scrollView.delegate = self;
    
    self.menuContainerView.layer.anchorPoint = CGPointMake(1.0, 0.5);
    
}

- (void) hideOrShowMenu:(BOOL)show animated: (BOOL)animated {
    
    CGFloat menuOffset = self.menuContainerView.bounds.size.width;
    [self.scrollView setContentOffset: show ? CGPointZero : CGPointMake(menuOffset, 0) animated:animated];
    self.showingMenu = show;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual: @"DetailViewSegue"]) {
        UINavigationController *nav = (UINavigationController *)segue.destinationViewController;
        self.detailVC = (DetailViewController *)nav.topViewController;
    }
}

#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    scrollView.pagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.bounds.size.width);
    // 设置左边菜单折叠动画
    CGFloat multiplier = 1.0/self.menuContainerView.bounds.size.width;
    CGFloat offset = scrollView.contentOffset.x * multiplier;
    CGFloat fraction = 1.0 - offset;
    self.menuContainerView.layer.transform = [self transformForFraction:fraction];
    self.menuContainerView.alpha = fraction;
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat menuOffset = self.menuContainerView.bounds.size.width;
    CGPoint p1 = CGPointMake(menuOffset, 0);
    CGPoint p2 = scrollView.contentOffset;
    self.showingMenu = CGPointEqualToPoint(p1, p2);
}

- (CATransform3D) transformForFraction: (CGFloat) fracton {
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0/1000;
    CGFloat angle = (1.0 - fracton) * (-M_PI_2);
    CGFloat xOffset = self.menuContainerView.bounds.size.width * 0.5;
    CATransform3D rotateTransform = CATransform3DRotate(identity, angle, 0.0, 1.0, 0.0);
    CATransform3D translateTransform = CATransform3DMakeTranslation(xOffset, 0, 0);
    return CATransform3DConcat(rotateTransform, translateTransform);
}


@end
