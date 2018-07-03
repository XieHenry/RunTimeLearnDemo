//
//  ExchangeMethodObject.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/26.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "ExchangeMethodObject.h"

@implementation ExchangeMethodObject

/**
 *  当程序加载这个类文件的时候
 */
+(void)load {
    //方法实现的交换!!!
    //Method:成员方法
    //    class_getClassMethod        拿到类方法
    //    class_getInstanceMethod     拿到对象方法
    Method m1 = class_getClassMethod([ExchangeMethodObject class], @selector(run));
    Method m2 = class_getClassMethod([ExchangeMethodObject class], @selector(study));
    //交换方法实现
    method_exchangeImplementations(m1, m2);
}

+ (void)run {
    NSLog(@"跑");
}

+ (void)study {
    NSLog(@"学习");
}

@end
