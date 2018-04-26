//
//  LoginViewController.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "LoginViewController.h"

#import <Masonry/Masonry.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LoginPageLogo"]];
    logoView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:logoView];
    
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.centerX.equalTo(logoView.superview);
        make.top.equalTo(self.view).with.offset(80);
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
