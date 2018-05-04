//
//  LoginButtonView.m
//  VisitSystem
//
//  Created by hellodx on 2018/4/30.
//  Copyright © 2018年 Star. All rights reserved.
//
#import "Masonry.h"

#import "LoginButtonView.h"
#import "UIColor+RGBColor.h"

@implementation LoginButtonView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.button = [UIButton buttonWithType:UIButtonTypeSystem];
        self.button.frame = CGRectMake(0, 0, 270, 30);
        self.button.backgroundColor = [UIColor colorWithRGBValue:@"#168ade"];
//        self.button.backgroundColor = [UIColor redColor];
        
        [self.button setTitle:@"登录" forState:UIControlStateNormal];
        [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        self.button.layer.cornerRadius = 4;
        self.button.layer.masksToBounds = YES;
        
        [self disable];
//        self.button.enabled = NO;
        
//        self.button.showsTouchWhenHighlighted = YES;
        
        [self addSubview:self.button];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(270, 30));
        }];
    }
    return self;
}

- (void)enable {
    if(self){
        self.button.alpha = 1.0;
        self.button.enabled = YES;
    }
}

- (void)disable {
    if(self){
        self.button.alpha = 0.5;
        self.button.enabled = NO;
    }
}

@end
