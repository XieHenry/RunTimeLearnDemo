//
//  GuiJieDangObjc.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "GuiJieDangObjc.h"

@implementation GuiJieDangObjc

- (void)encodeWithCoder:(NSCoder *)coder {
    unsigned int count = 0;
    Ivar * ivars = class_copyIvarList([GuiJieDangObjc class], &count);
    for (int i = 0; i < count; i++) {
        //取出变量名称
        Ivar ivar = ivars[i];
        const char * name = ivar_getName(ivar);
        NSString * key = [[NSString alloc]initWithUTF8String:name];
        //拿出属性值  -- KVC!!!
        [coder encodeObject:[self valueForKey:key] forKey:key];
    }
}




- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        unsigned int count = 0;
        Ivar * ivars = class_copyIvarList([GuiJieDangObjc class], &count);
        for (int i = 0; i < count; i++) {
            //取出变量名称
            Ivar ivar = ivars[i];
            const char * name = ivar_getName(ivar);
            NSString * key = [[NSString alloc]initWithUTF8String:name];
            //拿出属性值
            id value = [coder decodeObjectForKey:key];

            [self setValue:value forKey:key];
        }
        
    }
    return self;
}
@end
