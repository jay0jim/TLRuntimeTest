//
//  People+Associated.h
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import "People.h"

typedef void(^CodingCallBlock)();

@interface People (Associated)

@property (nonatomic) NSNumber *associatedBust;
@property (nonatomic, copy) CodingCallBlock associatedCallBlock;

@end
