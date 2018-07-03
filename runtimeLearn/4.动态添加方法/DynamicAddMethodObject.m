//
//  DynamicAddMethodObject.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/26.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "DynamicAddMethodObject.h"

@implementation DynamicAddMethodObject

//当这个类别调用一个没有实现的类方法就会来到这里!!
//+(BOOL)resolveClassMethod:(SEL)sel

void eat(id self,SEL sel) {
    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
}


// 当一个对象调用未实现的方法，会调用这个方法处理,并且会把对应的方法列表传过来.
// 刚好可以用来判断，未实现的方法是不是我们想要动态添加的方法
+(BOOL)resolveInstanceMethod:(SEL)sel {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if (sel == @selector(eat)) {
#pragma clang diagnostic pop

        // 动态添加eat方法
        
        // 第一个参数：给哪个类添加方法
        // 第二个参数：添加方法的方法编号
        // 第三个参数：添加方法的函数实现（函数地址）
        // 第四个参数：函数的类型，(返回值+参数类型) v:void @:对象->self :表示SEL->_cmd
        class_addMethod(self, sel, (IMP)eat, "v@:");

    }
    return [super resolveInstanceMethod:sel];
}

@end
