//
//  LabelledInputView.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "LabelledInputView.h"

#import <Masonry/Masonry.h>

@interface LabelledInputView()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UIInputView *inputView;

@end

@implementation LabelledInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.label = [[UILabel alloc] init];
        [self addSubview:self.label];
        
        self.inputView = [[UIInputView alloc] init];
        
    }
    return self;
}

@end
