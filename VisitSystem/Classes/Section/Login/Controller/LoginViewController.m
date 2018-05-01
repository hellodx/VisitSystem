//
//  LoginViewController.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//
#import "Masonry.h"

#import "LoginViewController.h"
#import "UserModel.h"
#import "LabelledInputView.h"
#import "LoginButtonView.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UIImageView *logoView;
@property(nonatomic,strong) UserModel *userModal;
@property(nonatomic,strong) LabelledInputView *userInputView;
@property(nonatomic,strong) LabelledInputView *passwordInputView;
@property(nonatomic,strong) LoginButtonView *loginButtonView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _userModal = [[UserModel alloc] init];
    
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPageLogo"]];
    _logoView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:self.logoView];
    
    _userInputView = [[LabelledInputView alloc] initWithLabelText:@"手机号" isSecureTextEntry:NO];
    [_userInputView setDelegate:self];
    [self.view addSubview:_userInputView];
    
    self.passwordInputView = [[LabelledInputView alloc] initWithLabelText:@"密码" isSecureTextEntry:YES];
    [self.passwordInputView setDelegate:self];
    [self.view addSubview:self.passwordInputView];
    
    self.loginButtonView = [[LoginButtonView alloc] init];
    [self.loginButtonView.button addTarget:self action:@selector(Login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginButtonView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [self.view addGestureRecognizer:tapRecognizer];
    
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
    
    [self.loginButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.passwordInputView.mas_bottom).with.offset(50);
    }];
}

- (void)closeKeyboard:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma action
- (void)Login:(UIButton *)button {
    [self.view endEditing:YES];
    
    NSLog(@"userModal %@",_userModal);
}

#pragma delegate methods
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if(textField.superview == self.userInputView){
        self.userModal.phone = textField.text;
    } else if (textField.superview == self.passwordInputView){
        self.userModal.password = textField.text;
    }
//    NSLog(@"%@",_userModal);
}

@end
