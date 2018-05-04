//
//  VSNetworkManager.h
//  VisitSystem
//
//  Created by Star on 2018/5/3.
//  Copyright © 2018年 Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#import "VSHTTPInterface.h"

typedef NS_ENUM(NSUInteger, HTTPMethod) {
    HTTPMethodGET,          //幂等，资源访问
    HTTPMethodPOST,         //非幂等，资源访问或修改
    HTTPMethodPUT,          //幂等，资源访问或修改
    HTTPMethodPATCH,        //修改更新资源
    HTTPMethodDELETE,       //删除资源
};

@interface VSNetworkManager : NSObject

/*
 *  单例模式
 *
 *  @return 网络请求类实例，可作为初始化方法
 */
+ (nonnull instancetype)sharedManager;

/*
 *  HTTP请求
 *
 *  @param requestMethod    请求方式
 *  @param serverUrl        服务器地址
 *  @param apiPath          方法链接
 *  @param parameters       参数
 *  @param progress         请求进度
 *  @param success          成功回调block
 *  @param failure          失败回调block
 *  
 *  return  
 */
- (nullable NSURLSessionDataTask *)requestMethod:(HTTPMethod)requestMethod
                                        severUrl:(nonnull NSString *)url
                                         apiPath:(nonnull NSString *)apiPath
                                      parameters:(nullable id)parameters
                                        progress:(nullable void(^)(NSProgress *_Nullable progress))progress
                                         success:(nullable void(^)(BOOL isSuccess,id _Nullable response))success
                                         failure:(nullable void(^)(NSString *_Nullable errorMessage))failure;

@end
