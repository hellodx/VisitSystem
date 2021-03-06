//
//  UserModel.h
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *password;

/*
 *  将模型转换为网络请求的字典对象，password需要md5加密
 */
- (NSDictionary *)dictionaryForNetworkApplication;

@end
