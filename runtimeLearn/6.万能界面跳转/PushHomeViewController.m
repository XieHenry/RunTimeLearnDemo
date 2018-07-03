//
//  PushHomeViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/7/2.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "PushHomeViewController.h"

@interface PushHomeViewController ()

@end

@implementation PushHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //这些写在AppDelegate里比较合适，在此是为了结构好看
    // 延时，等待所有控件加载完
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self test];
    });
    
}

- (void)test
{
    // 这个规则肯定事先跟服务端沟通好，跳转对应的界面需要对应的参数
    NSDictionary *userInfo = @{
                               @"class": @"PushViewController",
                               @"property": @{
                                       @"ID": @"123",
                                       @"type": @"12"
                                       }
                               };
    
    [self push:userInfo];
}

#pragma mark 接收推送消息
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    // 这个规则肯定事先跟服务端沟通好，跳转对应的界面需要对应的参数
    //NSDictionary *userInfo = @{
    //                           @"class": @"HSFeedsViewController",
    //                           @"property": @{
    //                                        @"ID": @"123",
    //                                        @"type": @"12"
    //                                   }
    //                           };
    
    [self push:userInfo];
}

/**
 *  跳转界面
 */
- (void)push:(NSDictionary *)params
{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        // 检测这个对象是否存在该属性
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
    
    // 获取导航控制器 AppDelegate.h 里面需要这么写
//    UITabBarController *tabVC = (UITabBarController *)self.view.window.rootViewController;
//    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
    
    // 跳转到对应的控制器
    [self.navigationController pushViewController:instance animated:YES];
}

/**
 *  检测对象是否存在该属性
 */
- (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)verifyPropertyName
{
    unsigned int outCount, i;
    
    // 获取对象里的属性列表
    objc_property_t * properties = class_copyPropertyList([instance
                                                           class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property =properties[i];
        //  属性名转成字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:verifyPropertyName]) {
            free(properties);
            return YES;
        }
    }
    free(properties);
    
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
