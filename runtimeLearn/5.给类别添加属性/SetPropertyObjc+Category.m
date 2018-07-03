//
//  SetPropertyObjc+Category.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/29.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "SetPropertyObjc+Category.h"

static NSString *setPropertyKey = @"setPropertyKey";   //定义一个key值

@implementation SetPropertyObjc (Category)
//运行时实现setter方法
-(void)setSetProperty:(NSString *)setProperty {
    objc_setAssociatedObject(self,  &setPropertyKey, setProperty, OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

//运行时实现getter方法
- (NSString *)setProperty {
    return objc_getAssociatedObject(self, &setPropertyKey);
}

@end
