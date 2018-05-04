//
//  UserModel.m
//  VisitSystem
//
//  Created by Star on 2018/4/26.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "UserModel.h"
#import "NSString+MD5.h"

@implementation UserModel

- (NSString *)description{
    return [NSString stringWithFormat:@"UserModel:%p  phone:%@ password:%@",self,self.phone,self.password];
}

- (NSDictionary *)dictionaryForNetworkApplication {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:self.phone forKey:@"account"];
    [dictionary setObject:[self.password MD5] forKey:@"password"];
    [dictionary setObject:@"test" forKey:@"clientId"];
    
    return dictionary;
}

@end
