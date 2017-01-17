//
//  People.h
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface People : NSObject {
    NSString *_occupation;
    NSString *_nationality;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger age;

- (NSDictionary *)allProperties;
- (NSDictionary *)allIvars;
- (NSDictionary *)allMethods;

@end
