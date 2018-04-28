//
//  UserModel.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (NSString *)description{
    return [NSString stringWithFormat:@"UserModel:%p  phone:%@ password:%@",self,self.phone,self.password];
}

@end
