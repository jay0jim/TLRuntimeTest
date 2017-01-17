//
//  People.m
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "People.h"

#import <objc/objc-runtime.h>

@implementation People

- (NSDictionary *)allProperties {
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        id propertyValue = [self valueForKey:name];
        
        if (propertyValue) {
            [resultDict setObject:propertyValue forKey:name];
        } else {
            [resultDict setObject:@"Empty Value" forKey:name];
        }
    }
    
    // 记得free
    free(properties);
    
    return resultDict;
}

- (NSDictionary *)allIvars {
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList([self class], &count);
    
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i++) {
        const char *ivarName = ivar_getName(ivars[i]);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        id ivarValue = [self valueForKey:name];
        
        if (ivarValue) {
            [resultDict setObject:ivarValue forKey:name];
        } else {
            [resultDict setObject:@"Empty Value" forKey:name];
        }
    }
    
    // 同样记得要free
    free(ivars);
    
    return resultDict;
}

- (NSDictionary *)allMethods {
    unsigned int count = 0;
    
    Method *methods = class_copyMethodList([self class], &count);
    
    NSMutableDictionary *resultDict = [@{} mutableCopy];
    
    for (NSUInteger i = 0; i < count; i++) {
        SEL methodSEL = method_getName(methods[i]);
        const char *methodName = sel_getName(methodSEL);
        NSString *name = [NSString stringWithUTF8String:methodName];
        
        int arguments = method_getNumberOfArguments(methods[i]);
        
        // -2的原因是每个方法前都有id,sel两个参数
        resultDict[name] = @(arguments - 2);
        
    }
    
    free(methods);
    
    return resultDict;
}

@end















