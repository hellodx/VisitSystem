//
//  VSNetworkManager.m
//  VisitSystem
//
//  Created by Star on 2018/5/3.
//  Copyright © 2018年 Star. All rights reserved.
//

#import "VSNetworkManager.h"

@interface VSNetworkManager()

@property (nonatomic,strong) AFHTTPSessionManager *sessionManager;

@end

@implementation VSNetworkManager

static VSNetworkManager *networkManager = nil;

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!networkManager) {
            networkManager = [[VSNetworkManager alloc] init];
        }
    });
    return networkManager;
}

- (instancetype)init {
    if(self = [super init]) {
        self.sessionManager = [AFHTTPSessionManager manager];
        //设置请求序列化器（JSON）
        self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.sessionManager.requestSerializer.timeoutInterval = 20.0;
        //设置响应内容类型
        self.sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
    }
    return self;
}

- (nullable NSURLSessionDataTask *)requestMethod:(HTTPMethod)requestMethod
                                        severUrl:(nonnull NSString *)url
                                         apiPath:(nonnull NSString *)apiPath
                                      parameters:(nullable id)parameters
                                        progress:(nullable void (^)(NSProgress * _Nullable))progress
                                         success:(nullable void (^)(BOOL, id _Nullable))success
                                         failure:(nullable void (^)(NSString * _Nullable))failure
{
    NSURLSessionDataTask *task = nil;
    //拼接请求地址
    NSString *requestPath = [url stringByAppendingPathComponent:apiPath];
    
    switch (requestMethod) {
        case HTTPMethodGET:
        {
            task = [self.sessionManager GET:requestPath
                                 parameters:parameters
                                   progress:progress
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                if(success){
                    success(YES,responseObject);
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if(failure){
                    failure([self failHandleWithErrorResponse:error task:task]);
                }
            }];
        }
            break;
        case HTTPMethodPOST:
        {
            task = [self.sessionManager POST:requestPath
                                  parameters:parameters
                                    progress:progress
                                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        if(success){
                                            success(YES,responseObject);
                                        }
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        if(failure){
                                            failure([self failHandleWithErrorResponse:error task:task]);
                                        }
                                    }];
        }
            
            break;
        case HTTPMethodPUT:
        {
            task = [self.sessionManager PUT:requestPath
                                 parameters:parameters
                                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                        if(success){
                                            success(YES,responseObject);
                                        }
                                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                        if(failure){
                                            failure([self failHandleWithErrorResponse:error task:task]);
                                        }
                                    }];
        }
            break;
        case HTTPMethodPATCH:
        {
            task = [self.sessionManager PATCH:requestPath
                                   parameters:parameters
                                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                          if(success){
                                              success(YES,responseObject);
                                          }
                                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                          if(failure){
                                              failure([self failHandleWithErrorResponse:error task:task]);
                                          }
                                      }];
        }
            break;
        case HTTPMethodDELETE:
        {
            task = [self.sessionManager DELETE:requestPath
                                    parameters:parameters
                                       success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           if(success){
                                               success(YES,responseObject);
                                           }
                                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                           if(failure){
                                               failure([self failHandleWithErrorResponse:error task:task]);
                                           }
                                       }];
        }
            break;
    }
    return task;
}

/*
 *  处理请求错误信息
 *
 *  @param error    AFN返回错误消息
 *  @param task     请求任务
 *  
 *  @return Error description
 */
- (NSString *)failHandleWithErrorResponse:(NSError * _Nullable)error
                                     task:(NSURLSessionDataTask * _Nullable)task {
    __block NSString *message = nil;
    //利用AFN的错误信息
    NSData *afN_errorMsg = [error.userInfo objectForKey:AFNetworkingOperationFailingURLResponseDataErrorKey];
    
    NSLog(@"afN_errorMsg : %@",[[NSString alloc] initWithData:afN_errorMsg encoding:NSUTF8StringEncoding]);
    
    if(!afN_errorMsg)
        message = @"网络连接失败";
    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
    NSInteger responseCode = response.statusCode;
    
    NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:afN_errorMsg
                                                                   options:NSJSONReadingAllowFragments
                                                                     error:nil];
    message = responseObject[@"error"];
    NSLog(@"error : %@",error);
    
    return message;
}
@end
