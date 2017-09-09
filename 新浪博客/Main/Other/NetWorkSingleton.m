//
//  NetWorkSingleton.m
//  新浪博客
//
//  Created by neo on 2017/8/31.
//  Copyright © 2017年 neo. All rights reserved.
//

#import "NetWorkSingleton.h"


@implementation NetWorkSingleton



/**
 
 

 @return AFHTTPSessionManager
 */
-(AFHTTPSessionManager *)baseHtppRequest{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    
//    manager.requestSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"text/html", @"application/json", nil];
    
    return manager;
}

-(void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    
}

@end
