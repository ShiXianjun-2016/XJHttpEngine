//
//  DHHttpEngine.m
//  DHHttpEngine
//
//  Created by 石显军 on 2019/6/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import "XJHttpEngine.h"

@interface XJHttpEngine ()

@end

@implementation XJHttpEngine

+ (instancetype)shareEngine
{
    static XJHttpEngine *_shareEngine = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareEngine = [XJHttpEngine new];
    });
    
    return _shareEngine;
}

#pragma mark - Private

- (NSString *)baseUrlStr
{
    if (self.getBaseUrlStrBlock) {
        return self.getBaseUrlStrBlock();
    }
    return @"";
}

- (NSString *)userToken
{
    if (self.getUserTokenBlock) {
        return self.getUserTokenBlock();
    }
    return @"";
}

- (void)responseSuccessHandler:(id)responseObject callback:(DHRequestResponseBlock)callback
{
    XJRequestResponse *response = [XJRequestResponse new];
    response.errorCode = [[responseObject objectForKey:@"errcode"] integerValue];
    response.responseMeassage = [NSString stringWithFormat:@"%@", [responseObject objectForKey:@"msg"]];
    if (response.errorCode != XJRequestErrorCode_Scuess) {
        response.errorstring = response.responseMeassage;
    }
    if(callback){
        callback(response);
    }
}

- (void)responseFailureHandler:(NSError *)error callback:(DHRequestResponseBlock)callback
{
    XJRequestResponse *response = [XJRequestResponse new];
    response.error = error;
    response.errorstring = error.localizedDescription;
    response.errorCode = error.code;
    response.responseMeassage = error.localizedDescription;
    if (callback) {
        callback(response);
    }
}

#pragma mark - Get

- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary * _Nullable)parameters
                     callback:(DHRequestResponseBlock _Nullable)callback
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:URLString];
    configuration.timeoutIntervalForRequest = 10;
    NSMutableDictionary *header = [NSMutableDictionary new];
    if ([self userToken]) {
        [header setObject:[self userToken] forKey:@"Authorization"];
    }
    configuration.HTTPAdditionalHeaders = header;
    
    NSURL *baseURL = [NSURL URLWithString:self.baseUrlStr];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL sessionConfiguration:configuration];
    
    NSURLSessionDataTask *task = [manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccessHandler:responseObject callback:callback];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseFailureHandler:error callback:callback];
    }];
    
    return task;
}

@end
