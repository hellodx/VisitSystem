//
//  LabelledInputView.h
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelledInputView : UIView

- (instancetype)initWithLabelText:(NSString *)text;

- (instancetype)initWithLabelText:(NSString *)text
                isSecureTextEntry:(BOOL)isSecureTextEntry;

- (void)setDelegate:(id)target;
@end
