//
//  DHHttpEngine.h
//  DHHttpEngine
//
//  Created by 石显军 on 2019/6/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "XJRequestResponse.h"

NS_ASSUME_NONNULL_BEGIN

@interface XJHttpEngine : NSObject

typedef void (^ DHRequestResponseBlock)(XJRequestResponse *response);

+ (instancetype)shareEngine;

@property (nonatomic, copy) NSString *(^getBaseUrlStrBlock)(void);
@property (nonatomic, copy) NSString *(^getUserTokenBlock)(void);

#pragma mark - Get
- (NSURLSessionDataTask *)GET:(NSString *)URLString
                   parameters:(NSDictionary * _Nullable)parameters
                     callback:(DHRequestResponseBlock _Nullable)callback;


@end

NS_ASSUME_NONNULL_END
