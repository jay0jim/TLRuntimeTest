//
//  main.m
//  TLRuntimeTest
//
//  Created by Tony on 2017/1/17.
//  Copyright © 2017年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/objc-runtime.h>

#import "People.h"
#import "People+Associated.h"
#import "PeopleSing.h"
#import "Bird.h"

void sayFunction(id self, SEL _cmd, id some) {
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")), [self valueForKey:@"name"], some);
    NSLog(@"%@岁的%@说：%@", [self valueForKey:@"age"], [self valueForKey:@"name"], some);
    NSLog(@"%@岁的%@说：%@", object_getIvar(self, class_getInstanceVariable([self class], "_age")), object_getIvar(self, class_getInstanceVariable([self class], "_name")), some);
}

void myFunc1();
void myFunc2();
void myFunc3();

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
//        myFunc1();
//        myFunc2();
//        myFunc3();
        
//        PeopleSing *cangTeacher = [[PeopleSing alloc] init];
//        cangTeacher.name = @"苍老师";
//        [cangTeacher sing];
        
//        Bird *bird = [[Bird alloc] init];
//        ((void (*)(id, SEL))objc_msgSend)((id)bird, @selector(sing));
        
        
    }
    return 0;
}


/**
 1、动态创建类，向类中添加实例变量和方法
 */
#pragma mark - 1、动态创建类，向类中添加实例变量和方法
void myFunc1() {
    Class People = objc_allocateClassPair([NSObject class], "People", 0);
    
    class_addIvar(People, "_name", sizeof(NSString*), log2(sizeof(NSString*)), @encode(NSString*));
    //        // 如果设为int等非对象类型，在方法中使用KVC取值时会发生错误
    //        class_addIvar(People, "_age", sizeof(int), sizeof(int), @encode(int));
    //        class_addIvar(People, "_age", sizeof(NSUInteger), sizeof(NSUInteger), @encode(NSUInteger));
    class_addIvar(People, "_age", sizeof(NSNumber*), log2(sizeof(NSNumber*)), @encode(NSNumber*));
    
    
    SEL s = sel_registerName("say");
    class_addMethod(People, s, (IMP) sayFunction, "v@:@");
    
    objc_registerClassPair(People);
    
    //
    id peopleInstance = [[People alloc] init];
    
    // KVC
    [peopleInstance setValue:@"苍老师" forKey:@"name"];
    
    // Ivar
    Ivar ageIvar = class_getInstanceVariable(People, "_age");
    object_setIvar(peopleInstance, ageIvar, @18);
    
    // 强制把msgSend转换为三参数
    ((void (*)(id, SEL, id))objc_msgSend)(peopleInstance, s, @"大家好");
    
    peopleInstance = nil;
    
    objc_disposeClassPair(People);
    
}

#pragma mark -
/**
 2、显示类中ivars，属性和方法
 */
void myFunc2() {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍老师";
    cangTeacher.age = 18;
    [cangTeacher setValue:@"老师" forKey:@"occupation"];
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *ivarResultDic = [cangTeacher allIvars];
    for (NSString *ivarName in ivarResultDic.allKeys) {
        NSLog(@"ivarName:%@, ivarValue:%@",ivarName, ivarResultDic[ivarName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
    }
}

#pragma mark -
/**
 3、利用catagory向类添加属性
 */
void myFunc3() {
    People *cangTeacher = [[People alloc] init];
    cangTeacher.name = @"苍井空";
    cangTeacher.age = 18;
    [cangTeacher setValue:@"老师" forKey:@"occupation"];
    cangTeacher.associatedBust = @(90);
    cangTeacher.associatedCallBlock = ^(){
        
        NSLog(@"苍老师要写代码了！");
        
    };
    cangTeacher.associatedCallBlock();
    
    NSDictionary *propertyResultDic = [cangTeacher allProperties];
    for (NSString *propertyName in propertyResultDic.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyResultDic[propertyName]);
    }
    
    NSDictionary *methodResultDic = [cangTeacher allMethods];
    for (NSString *methodName in methodResultDic.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodResultDic[methodName]);
    }
}










