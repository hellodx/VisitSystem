//
//  LoginViewController.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//
#import <Masonry/Masonry.h>

#import "LoginViewController.h"
#import "UserModel.h"
#import "LabelledInputView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UIImageView *logoView;
@property(nonatomic,strong) UserModel *userModal;
@property(nonatomic,strong) LabelledInputView *userInputView;
@property(nonatomic,strong) LabelledInputView *passwordInputView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _userModal = [[UserModel alloc] init];
    
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPageLogo"]];
//    _logoView.frame = CGRectMake(0, 0, 200, 200);
    _logoView.contentMode = UIViewContentModeScaleToFill;
    _logoView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.logoView];
    
    _userInputView = [[LabelledInputView alloc] initWithLabelText:@"手机号" isSecureTextEntry:NO];
//    _userInputView.frame = CGRectMake(0, 0, 270, 30);
    [_userInputView setDelegate:self];
    [self.view addSubview:_userInputView];
    
    self.passwordInputView = [[LabelledInputView alloc] initWithLabelText:@"密码" isSecureTextEntry:YES];
    [self.passwordInputView setDelegate:self];
    [self.view addSubview:self.passwordInputView];
    
    
    //视图创建完毕后设置约束
    [self makeConstraints];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeConstraints {
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(80);
    }];
    
    [self.userInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.logoView);
        make.top.equalTo(self.logoView.mas_bottom).with.offset(50);
    }];
    
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.userInputView.mas_bottom).with.offset(30);
    }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

@end
