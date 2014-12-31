//
//  BCInstanceMethodCallback.m
//  Common
//
//  Created by yongyang on 13-3-26.
//  Copyright (c) 2013年 yipinapp. All rights reserved.
//

#import "BCInstanceMethodCallback.h"

@implementation BCInstanceMethodCallback
+ (BCInstanceMethodCallback *)callBackWithTarget:(id)target action:(SEL)action
{
    BCInstanceMethodCallback *callback = [[BCInstanceMethodCallback alloc] init];
    callback.target = target;
    callback.action = action;
    return callback;
}


@end
