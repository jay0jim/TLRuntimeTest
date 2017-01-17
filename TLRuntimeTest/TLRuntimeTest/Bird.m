//
//  Bird.m
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "Bird.h"
#import "PeopleSing.h"

@implementation Bird

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return NO;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    // 将消息转发到PeopleSing中响应
//    PeopleSing *cangTeacher = [[PeopleSing alloc] init];
//    cangTeacher.name = @"苍老师";
//    return cangTeacher;
    
    return nil;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"sing"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    PeopleSing *cangTeacher = [[PeopleSing alloc] init];
    cangTeacher.name = @"苍老师1";
    [anInvocation invokeWithTarget:cangTeacher];
}

@end











