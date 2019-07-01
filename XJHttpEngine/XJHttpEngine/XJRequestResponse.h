//
//  DHRequestResponse.h
//  DHHttpEngine
//
//  Created by 石显军 on 2019/6/28.
//  Copyright © 2019 石显军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, XJRequestErrorCode){
    XJRequestErrorCode_Scuess = 200,
};

@interface XJRequestResponse : NSObject

@property (nonatomic, assign) XJRequestErrorCode errorCode;

@property (nonatomic, strong) id responseMeassage;

@property (nonatomic, strong) NSString *errorstring;    //错误提示文字

@property (nonatomic, strong) NSError *error;           //错误信息

@end

NS_ASSUME_NONNULL_END
