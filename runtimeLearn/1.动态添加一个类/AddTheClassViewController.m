//
//  AddTheClassViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/27.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "AddTheClassViewController.h"
#import <objc/message.h>

@interface AddTheClassViewController ()

@end

@implementation AddTheClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    /*（“KVO”的实现是利用了runtime能够动态添加类）
     
     原来当你对一个对象进行观察时, 系统会自动新建一个类继承自原类, 然后重写被观察属性的setter方法. 然后重写的setter方法会负责在调用原setter方法前后通知观察者. 然后把原对象的isa指针指向这个新类, 我们知道, 对象是通过isa指针去查找自己是属于哪个类, 并去所在类的方法列表中查找方法的, 所以这个时候这个对象就自然地变成了新类的实例对象.
     
     就像KVO一样, 系统是在程序运行的时候根据你要监听的类, 动态添加一个新类继承自该类, 然后重写原类的setter方法并在里面通知observer的.
     */
    
    
    
    // 创建一个类(size_t extraBytes该参数通常指定为0, 该参数是分配给类和元类对象尾部的索引ivars的字节数。)
    Class clazz = objc_allocateClassPair([NSObject class], "GoodPerson", 0);
    
    // 添加ivar
    // @encode(aType) : 返回该类型的C字符串
    class_addIvar(clazz, "_name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    
    class_addIvar(clazz, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
    
    // 注册该类
    objc_registerClassPair(clazz);
    
    // 创建实例对象
    id object = [[clazz alloc] init];
    
    // 设置ivar
    [object setValue:@"Tracy" forKey:@"name"];
    
    Ivar ageIvar = class_getInstanceVariable(clazz, "_age");
    object_setIvar(object, ageIvar, @18);
    
    // 打印对象的类和内存地址
    NSLog(@"%@", object);
    
    // 打印对象的属性值
    NSLog(@"name = %@, age = %@", [object valueForKey:@"name"], object_getIvar(object, ageIvar));
    
    // 当类或者它的子类的实例还存在，则不能调用objc_disposeClassPair方法
    object = nil;
    
    // 销毁类
    objc_disposeClassPair(clazz);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
