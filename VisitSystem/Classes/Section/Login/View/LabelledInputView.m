//
//  LabelledInputView.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "LabelledInputView.h"

#import "Masonry.h"

@interface LabelledInputView()

@property(nonatomic,strong) UILabel *label;
@property(nonatomic,strong) UITextField *textField;

@end

@implementation LabelledInputView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
        self.label.textColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:14];
        [self addSubview:self.label];
        
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(70, 0, 200, 30)];
        self.textField.borderStyle = UITextBorderStyleLine;
        self.textField.backgroundColor = [UIColor whiteColor];
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textColor = [UIColor blackColor];
        [self addSubview:self.textField];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(270, 30));
        }];
    }
    return self;
}

- (instancetype)initWithLabelText:(NSString *)text {
    self = [self init];
    if(self){
        self.label.text = text;
    }
    return self;
}

- (instancetype)initWithLabelText:(NSString *)text
                isSecureTextEntry:(BOOL)isSecureTextEntry
{
    self = [self initWithLabelText:text];
    if(self){
        self.textField.secureTextEntry = isSecureTextEntry;
    }
    return self;
}

- (void)setDelegate:(id)target {
    self.textField.delegate = target;
}

@end
