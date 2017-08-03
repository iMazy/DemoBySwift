//
//  HamburgerView.m
//  Cool3DSidebarAnimation_OC
//
//  Created by Mazy on 2017/8/3.
//  Copyright © 2017年 Mazy. All rights reserved.
//

#import "HamburgerView.h"

@interface HamburgerView()

@property (nonatomic, strong) UIImageView *hamburgerView;

@end

@implementation HamburgerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.hamburgerView = [[UIImageView alloc] initWithImage: [UIImage imageNamed: @"Hamburger"]];
    self.hamburgerView.userInteractionEnabled = YES;
    [self addSubview:self.hamburgerView];
}

- (void)rotate: (CGFloat)fraction {
    CGFloat angle = fraction * M_PI_2;
    self.hamburgerView.transform = CGAffineTransformMakeRotation(angle);
}

@end
