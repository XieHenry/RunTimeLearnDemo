//
//  UsedMethodViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/27.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "UsedMethodViewController.h"
#import "UsedMethodObject.h"
#import "HomeTableViewCell.h"

@interface UsedMethodViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *usedTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *headerArray;
@end

@implementation UsedMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.usedTableView];

    /*
     UsedMethodObject *u = [[UsedMethodObject alloc] init];
     
     //1.获取类
     Class personClass = object_getClass([UsedMethodObject class]);
     
     //2.SEL是selector在Objc中的表示
     SEL oriSEL = @selector(testMethod1);
     
     
     //3.获取实例方法：
     Method sMethod = class_getInstanceMethod([UsedMethodObject class], @selector(testMethod1));
     
     //4.获取类方法
     Method lMethod = class_getClassMethod([UsedMethodObject class], @selector(testMethod2));
     
     
     //5.添加方法：
     SEL changeSEL = @selector(testMethod3);
     BOOL addSucc = class_addMethod([UsedMethodObject class], oriSEL, (IMP)changeSEL, "v@:");
     
     //6.替换原方法实现：
     class_replaceMethod([UsedMethodObject class], oriSEL, method_getImplementation(changeSEL), method_getTypeEncoding(changeSEL));
     
     //7.交换两个方法：
     method_exchangeImplementations(oriSEL, changeSEL);
     
     
     //8.获取一个类的属性列表（返回值是一个数组）：
     unsigned int count1 = 0;
     objc_property_t *propertyList = class_copyPropertyList([UsedMethodObject class], &count1);
     
     
     //9.获取一个类的方法列表（返回值是一个数组）：
     unsigned int count2 = 0;
     Method *methodList = class_copyMethodList([UsedMethodObject class], &count2);
     
     //10获取一个类的成员变量列表（返回值是一个数组）：
     unsigned int count3 = 0;
     Ivar * ivars = class_copyIvarList([UsedMethodObject class], &count3);
     //    for (int i=0; i<count3; i++) {
     //        Ivar ivar = ivars[i];//C 语言指针和数组很像!但是和数组不一样!
     //        const char * name = ivar_getName(ivar);
     //        NSLog(@"%s",name);
     //    }
     
     //11.获取成员变量的名字：
     const char * name = ivar_getName(ivars[0]);
     
     //12.获取成员变量的类型：
     const char *type = ivar_getTypeEncoding(ivars[0]);
     
     //13.获取一个类的协议列表（返回值是一个数组）：
     unsigned int count4 = 0;
     __unsafe_unretained Protocol *protocolList = class_copyProtocolList([UsedMethodObject class], &count4);
     
     //14.set方法：
     //将值value 跟对象object 关联起来（将值value 存储到对象object 中）
     //参数 object：给哪个对象设置属性
     //参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节
     //参数 value：给属性设置的值
     //参数policy：存储策略 （assign 、copy 、 retain就是strong）
     //void objc_setAssociatedObject(id object , const void *key ,id value ,objc_AssociationPolicy policy)
     
     
     //15.利用参数key 将对象object中存储的对应值取出来:
     id a = objc_getAssociatedObject(id object , const void *key);
     */
}

-(UITableView *)usedTableView {
    if (_usedTableView == nil) {
        self.usedTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT()) style:UITableViewStylePlain];
        self.usedTableView.delegate = self;
        self.usedTableView.dataSource = self;
        self.usedTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.usedTableView.estimatedRowHeight = 100; //  随便设个值
        self.usedTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _usedTableView;
}


-(NSArray *)headerArray {
    if (_headerArray == nil) {
        _headerArray = @[@"1.获取类",@"2.SEL是selector在Objc中的表示",@"3.获取类方法",@"4.获取实例方法",@"5.添加方法",@"6.替换原方法实现",@"7.交换两个方法",@"8.获取一个类的属性列表（返回值是一个数组）",@"9.获取一个类的方法列表（返回值是一个数组）",@"10.获取一个类的成员变量列表（返回值是一个数组）",@"11.获取成员变量的名字",@"12.获取成员变量的类型",@"13.获取一个类的协议列表（返回值是一个数组）",@"14.set方法",@"15.利用参数key 将对象object中存储的对应值取出来"];
    }
    return _headerArray;
}


-(NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@"Class personClass = object_getClass([UsedMethodObject class]);",@"SEL oriSEL = @selector(testMethod1);",@"Method sMethod = class_getInstanceMethod([UsedMethodObject class], @selector(testMethod1));",@"Method lMethod = class_getClassMethod([UsedMethodObject class], @selector(testMethod2));",@"SEL changeSEL = @selector(testMethod3);\nBOOL addSucc = class_addMethod([UsedMethodObject class], oriSEL, (IMP)changeSEL, \" v@:\" );",@"class_replaceMethod([UsedMethodObject class], oriSEL, method_getImplementation(changeSEL), method_getTypeEncoding(changeSEL));",@"method_exchangeImplementations(oriSEL, changeSEL);",@"unsigned int count1 = 0;\nobjc_property_t *propertyList = class_copyPropertyList([UsedMethodObject class], &count1);",@"unsigned int count2 = 0;\nMethod *methodList = class_copyMethodList([UsedMethodObject class], &count2);",@"unsigned int count3 = 0;\nIvar * ivars = class_copyIvarList([UsedMethodObject class], &count3);\n /*\nfor (int i=0; i<count3; i++) {\n Ivar ivar = ivars[i];//C 语言指针和数组很像!但是和数组不一样!\n const char * name = ivar_getName(ivar);\n NSLog(@\"%s\",name);\n }\n */",@"const char * name = ivar_getName(ivars[0]);",@"const char *type = ivar_getTypeEncoding(ivars[0]);",@"unsigned int count4 = 0;\n__unsafe_unretained Protocol *protocolList = class_copyProtocolList([UsedMethodObject class], &count4);",@"/*\n将值value 跟对象object 关联起来（将值value 存储到对象object 中）\n参数 object：给哪个对象设置属性\n参数 key：一个属性对应一个Key，将来可以通过key取出这个存储的值，key 可以是任何类型：double、int 等，建议用char 可以节省字节\n参数 value：给属性设置的值\n参数policy：存储策略 （assign 、copy 、 retain就是strong）\n*/\nvoid objc_setAssociatedObject(id object , const void *key ,id value ,objc_AssociationPolicy policy)",@"id a = objc_getAssociatedObject(id object , const void *key);"];
    }
    return _dataArray;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell"];
    }

   NSString *nameStr = [self.dataArray[indexPath.section] stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    cell.leftlabel.text = nameStr;

    return cell;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.usedTableView.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor grayColor];

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, headerView.frame.size.width-60, 20)];
    titleLabel.text =  self.headerArray[section];
    [headerView addSubview:titleLabel];

    return headerView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
