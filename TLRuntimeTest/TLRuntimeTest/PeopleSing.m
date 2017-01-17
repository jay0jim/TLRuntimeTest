//
//  PeopleSing.m
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "PeopleSing.h"

#import <objc/objc-runtime.h>

@implementation PeopleSing

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if ([NSStringFromSelector(sel) isEqualToString:@"sing"]) {
        class_addMethod([self class], sel, (IMP)otherSing, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void otherSing(id self, SEL cmd) {
    NSLog(@"%@ 唱歌了！", ((PeopleSing *)self).name);
}

@end
