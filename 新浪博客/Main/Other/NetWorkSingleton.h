//
//  NetWorkSingleton.h
//  新浪博客
//
//  Created by neo on 2017/8/31.
//  Copyright © 2017年 neo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);

@interface NetWorkSingleton : NSObject

-(AFHTTPSessionManager *)baseHtppRequest;

-(void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
