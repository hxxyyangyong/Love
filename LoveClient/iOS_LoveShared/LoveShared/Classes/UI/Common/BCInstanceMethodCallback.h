//
//  BCInstanceCallBack.h
//  YPCommon
//
//  Created by Ji Will on 12/20/12.
//  Copyright (c) 2012 iBrand. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCInstanceMethodCallback : NSObject
@property (nonatomic, assign) SEL action;
@property (nonatomic, weak) id target;

+ (BCInstanceMethodCallback *)callBackWithTarget:(id)target action:(SEL)action;
@end
