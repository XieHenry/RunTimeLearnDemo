//
//  GetClassPropertyVC.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "GetClassPropertyVC.h"
#import "GetClassPropertyObjc.h"

@interface GetClassPropertyVC ()
@property (nonatomic,strong) GetClassPropertyObjc *classPro;
@end

@implementation GetClassPropertyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*打印一个类的所有ivar, property 和 method（简单直接的使用）*/
    
    self.classPro = [[GetClassPropertyObjc alloc] init];
    [self.classPro setValue:@"波仔" forKey:@"_name"];
    [self.classPro setValue:@25 forKey:@"_age"];
    //p.address = @"北京";
    self.classPro.weight = 120.0f;
    
    // 1.打印所有ivars
    unsigned int ivarCount = 0;
    // 用一个字典装ivarName和value
    NSMutableDictionary *ivarDict = [NSMutableDictionary dictionary];
    Ivar *ivarList = class_copyIvarList([self.classPro class], &ivarCount);
    for(int i = 0; i < ivarCount; i++){
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivarList[i])];
        id value = [self.classPro valueForKey:ivarName];
        
        if (value) {
            ivarDict[ivarName] = value;
        } else {
            ivarDict[ivarName] = @"值为nil";
        }
    }
    // 打印ivar
    for (NSString *ivarName in ivarDict.allKeys) {
        NSLog(@"ivarName:%@, ivarValue:%@",ivarName, ivarDict[ivarName]);
    }
    
    
    
    // 2.打印所有properties
    unsigned int propertyCount = 0;
    // 用一个字典装propertyName和value
    NSMutableDictionary *propertyDict = [NSMutableDictionary dictionary];
    objc_property_t *propertyList = class_copyPropertyList([self.classPro class], &propertyCount);
    for(int j = 0; j < propertyCount; j++){
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(propertyList[j])];
        id value = [self.classPro valueForKey:propertyName];
        
        if (value) {
            propertyDict[propertyName] = value;
        } else {
            propertyDict[propertyName] = @"值为nil";
        }
    }
    // 打印property
    for (NSString *propertyName in propertyDict.allKeys) {
        NSLog(@"propertyName:%@, propertyValue:%@",propertyName, propertyDict[propertyName]);
    }
    
    
    // 3.打印所有methods
    unsigned int methodCount = 0;
    // 用一个字典装methodName和arguments
    NSMutableDictionary *methodDict = [NSMutableDictionary dictionary];
    Method *methodList = class_copyMethodList([self.classPro class], &methodCount);
    for(int k = 0; k < methodCount; k++){
        SEL methodSel = method_getName(methodList[k]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSel)];
        
        unsigned int argumentNums = method_getNumberOfArguments(methodList[k]);
        
        methodDict[methodName] = @(argumentNums - 2); // -2的原因是每个方法内部都有self 和 selector 两个参数
    }
    // 打印method
    for (NSString *methodName in methodDict.allKeys) {
        NSLog(@"methodName:%@, argumentsCount:%@", methodName, methodDict[methodName]);
    }
    
    
    [self changeAge];
    
    BOOL wBool = [self hasProperty:@"_name"];
    BOOL bBool = [self hasProperty:@"address"];
    NSLog(@"weight属性：%@  birthday属性：%@",wBool == YES ? @"有" : @"无",bBool== YES ? @"有" : @"无");
}

#pragma mark 动态变量控制
-(void)changeAge{
    unsigned int count = 0;
    //动态获取XiaoMing类中的所有属性[当然包括私有]
    Ivar *ivar = class_copyIvarList([GetClassPropertyObjc class], &count);
    //遍历属性找到对应age字段
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        if ([name isEqualToString:@"_address"]) {
            //修改对应的字段值成20
            object_setIvar(self.classPro, var, @"北京");
            break;
        }
    }
    NSLog(@"波仔的现居地址为%@",self.classPro.address);
}


#pragma mark 在NSObject的分类中增加方法来避免使用KVC赋值的时候出现崩溃
/*
 *  判断类中是否有该属性
 *  @param property 属性名称
 *  @return 判断结果
 */

/*
 在有些时候我们需要通过KVC去修改某个类的私有变量，但是又不知道该属性是否存在，如果类中不存在该属性，那么通过KVC赋值就会crash，这时也可以通过运行时进行判断。同样我们在NSObject的分类中增加如下方法。
 */
-(BOOL)hasProperty:(NSString *)property {
    BOOL flag = NO;
    u_int count = 0;
    Ivar *ivars = class_copyIvarList([self.classPro class], &count);
    for (int i = 0; i < count; i++) {
        const char *propertyName = ivar_getName(ivars[i]);
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        if ([propertyString isEqualToString:property]){
            flag = YES;
        }
    }
    return flag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
