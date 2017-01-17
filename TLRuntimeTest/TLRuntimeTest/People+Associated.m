//
//  People+Associated.m
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "People+Associated.h"

#import <objc/objc-runtime.h>

const char *bust = "bust";
const char *callBlock = "callBlock";

@implementation People (Associated)

- (void)setAssociatedBust:(NSNumber *)associatedBust {
    objc_setAssociatedObject(self, bust, associatedBust, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)associatedBust {
    return objc_getAssociatedObject(self, bust);
}

- (void)setAssociatedCallBlock:(CodingCallBlock)associatedCallBlock {
    objc_setAssociatedObject(self, callBlock, associatedCallBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (CodingCallBlock)associatedCallBlock {
    return objc_getAssociatedObject(self, callBlock);
}

@end











