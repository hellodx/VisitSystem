//
//  LoginViewController.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//
#import "Masonry.h"

#import "VSNetworkManager.h"
#import "LoginViewController.h"
#import "UserModel.h"
#import "LabelledInputView.h"
#import "LoginButtonView.h"

@interface LoginViewController (){
    UIView *_loginView;
    CGFloat _transformY;    //因键盘遮挡需要的view偏移量
    CGFloat _keyboardDuration;
}

@property(nonatomic,strong) UIImageView *logoView;
@property(nonatomic,strong) UserModel *userModal;
@property(nonatomic,strong) LabelledInputView *userInputView;
@property(nonatomic,strong) LabelledInputView *passwordInputView;
@property(nonatomic,strong) LoginButtonView *loginButtonView;
@property(nonatomic,strong) UIActivityIndicatorView *loginIndicatorView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _loginView = [[UIView alloc] init];
    _loginView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_loginView];
    
    _userModal = [[UserModel alloc] init];
    
    _logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPageLogo"]];
    _logoView.contentMode = UIViewContentModeScaleToFill;
    [_loginView addSubview:self.logoView];
    
    _userInputView = [[LabelledInputView alloc] initWithLabelText:@"手机号" isSecureTextEntry:NO];
    [_loginView addSubview:_userInputView];
    [_userInputView.textField addTarget:self
                                 action:@selector(textFieldTextChange:)
                       forControlEvents:UIControlEventEditingChanged];
    
    self.passwordInputView = [[LabelledInputView alloc] initWithLabelText:@"密码" isSecureTextEntry:YES];
    [_loginView addSubview:self.passwordInputView];
    [self.passwordInputView.textField addTarget:self
                                 action:@selector(textFieldTextChange:)
                       forControlEvents:UIControlEventEditingChanged];
    
    self.loginButtonView = [[LoginButtonView alloc] init];
    [self.loginButtonView.button addTarget:self
                                    action:@selector(Login:)
                          forControlEvents:UIControlEventTouchUpInside];
    [_loginView addSubview:self.loginButtonView];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeKeyboard:)];
    [_loginView addGestureRecognizer:tapRecognizer];
    
    self.loginIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [self.view addSubview:_loginIndicatorView];
    
    [self makeConstraints];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeConstraints {
    [_loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.centerX.equalTo(self.view);
    }];
    
    [self.logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(_loginView);
        make.top.equalTo(_loginView).with.offset(80);
    }];
    
    [self.userInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_loginView);
        make.top.equalTo(self.logoView.mas_bottom).with.offset(50);
    }];
    
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_loginView);
        make.top.equalTo(self.userInputView.mas_bottom).with.offset(30);
    }];
    
    [self.loginButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_loginView);
        make.top.equalTo(self.passwordInputView.mas_bottom).with.offset(50);
    }];
    
    [self.loginIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_top).with.offset([UIScreen mainScreen].bounds.size.height/2);
    }];
}

- (void)closeKeyboard:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
}

#pragma mark Target-Action监听输入框变化
- (void)textFieldTextChange:(UITextField *)textField {
    if(textField.superview == self.userInputView){
        self.userModal.phone = textField.text;
    } else if (textField.superview == self.passwordInputView){
        self.userModal.password = textField.text;
    }
    
    if(_userModal.phone.length!=0 && _userModal.password.length!=0){
        [self.loginButtonView enable];
    } else {
        [self.loginButtonView disable];
    }
}

#pragma mark loginButtonView Target-Action
- (void)Login:(UIButton *)button {
    [self.view endEditing:YES];
    
    NSLog(@"userModal %@",_userModal);
    
    __block NSURLSessionDataTask *loginTask = nil;
    
    dispatch_queue_t networkQueue = dispatch_queue_create("ujet.networkQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(networkQueue, ^{
        [_loginIndicatorView startAnimating];
        loginTask = [[VSNetworkManager sharedManager] requestMethod:HTTPMethodPOST
                                                           severUrl:ServerBaseURL
                                                            apiPath:PATH_Login
                                                         parameters:[_userModal dictionaryForNetworkApplication]
                                                           progress:nil
                                                            success:^(BOOL isSuccess, id  _Nullable response) {
                                                                [_loginIndicatorView stopAnimating];
                                                                NSLog(@"success : %@",response);
                                                            } failure:^(NSString * _Nullable errorMessage) {
                                                                [_loginIndicatorView stopAnimating];
                                                                NSLog(@"fail : %@",errorMessage);
                                                            }];

    });
    
}

#pragma mark 通过NSNotification获取键盘的frame并且调整view
- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSLog(@"keyboard frame : %@",NSStringFromCGRect(keyboardFrame));
//    NSLog(@"loginButtonView frame : %@",NSStringFromCGRect(_loginButtonView.frame));
    
    //键盘的上边沿与按钮view的下边缘（+20）差
    _transformY = keyboardFrame.origin.y - (_loginButtonView.frame.origin.y + _loginButtonView.frame.size.height + 20);
    _keyboardDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if(_transformY < 0){
        [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view).offset(_transformY);
        }];
        
        [UIView animateWithDuration:_keyboardDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if(_transformY < 0){
        [_loginView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view);
        }];
        
        [UIView animateWithDuration:_keyboardDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma 释放资源
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
