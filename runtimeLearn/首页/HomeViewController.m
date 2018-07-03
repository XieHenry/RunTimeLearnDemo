//
//  HomeViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/26.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableViewCell.h"


#import "ExchangeMethodObject.h"
#import "DynamicAddMethodObject.h"
#import "AddTheClassViewController.h"
#import "GetClassPropertyVC.h"
#import "DicToModelViewController.h"
#import "GuiJieDangViewController.h"
#import "SetPropertyObjc.h"
#import "SetPropertyObjc+Category.h"
#import "PushHomeViewController.h"
#import "UsedMethodViewController.h"




@interface HomeViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) NSArray *headerArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    [self.view addSubview:self.homeTableView];
}


-(UITableView *)homeTableView {
    if (_homeTableView == nil) {
        _homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH(), SCREEN_HEIGHT()) style:UITableViewStylePlain];
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.estimatedRowHeight = 100; //  随便设个值
        _homeTableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _homeTableView;
}


-(NSArray *)headerArray {
    if (_headerArray == nil) {
        _headerArray = @[@"1.动态添加一个类",@"2.获取一个类的所有属性",@"3.交换方法",@"4.动态添加方法",@"5.利用运行时set和get这两个API，可以让类别可以添加属性",@"6.万能界面跳转",@"7.插件开发",@"8.Jspath热更新",@"9.常用类"];
    }
    return _headerArray;
}


-(NSArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = @[@[@"1:动态添加一个类"],@[@"2.1:打印一个类的所有ivar, property 和 method（简单直接的使用）",@"2.2:自动的归档和解档",@"2.3:字典转模型"],@[@"3.利用runtime的动态交换方法实现"],@[@"4.动态添加方法"],@[@"5.利用运行时set和get这两个API，可以让类别可以添加属性",],@[@"6.万能界面跳转"],@[@"7.插件开发"],@[@"8.Jspath热更新也是使用运行时，基本上算是黑科技，在线修复版本bug，微信都使用了这个技术"],@[@"9.常用类"]];
    }
    return _dataArray;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    if (!cell) {
        cell = [[HomeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"headerCell"];
    }
    
    cell.leftlabel.text =  self.dataArray[indexPath.section][indexPath.row];
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.homeTableView.frame.size.width, 40)];
    headerView.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, headerView.frame.size.width-60, 20)];
    titleLabel.text =  self.headerArray[section];
    [headerView addSubview:titleLabel];
    
    
    return headerView;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //1.动态添加一个类
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AddTheClassViewController *vc = [[AddTheClassViewController alloc] init];
            vc.titleString = self.dataArray[indexPath.section][indexPath.row];;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    //2.获取一个类的所有属性
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            GetClassPropertyVC *vc = [[GetClassPropertyVC alloc] init];
            vc.titleString = self.dataArray[indexPath.section][indexPath.row];;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 1) {
            GuiJieDangViewController *vc = [[GuiJieDangViewController alloc] init];
            vc.titleString = self.dataArray[indexPath.section][indexPath.row];;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (indexPath.row == 2) {
            DicToModelViewController *vc = [[DicToModelViewController alloc] init];
            vc.titleString = self.dataArray[indexPath.section][indexPath.row];;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
    //3.利用runtime的动态交换方法实现
    else if (indexPath.section == 2) {
        [ExchangeMethodObject run];
        [ExchangeMethodObject study];
    }
    
    //4.动态添加方法
    else if (indexPath.section == 3) {
        
        // 默认DynamicAddMethodObject，没有实现eat方法，可以通过performSelector调用，但是会报错。
        // 动态添加方法就不会报错
        DynamicAddMethodObject *d = [[DynamicAddMethodObject alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [d performSelector:@selector(eat)];
#pragma clang diagnostic pop
    }
    
    //5.利用运行时set和get这两个API，可以让类别可以添加属性
    else if (indexPath.section == 4) {
        SetPropertyObjc *s = [[SetPropertyObjc alloc] init];
        s.setProperty = @"给分类添加属性";
        NSLog(@"%@",s.setProperty);
    }
    
    //6.万能界面跳转
    else if (indexPath.section == 5) {
        PushHomeViewController *vc = [[PushHomeViewController alloc] init];
        vc.titleString = self.dataArray[indexPath.section][indexPath.row];;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //7.插件开发
    else if (indexPath.section == 6) {
        /*
        插件入门
        
        XCode 有个很坑爹的地方，就是它并不官方支持插件开发，官方没有文档，XCode 也没有开源，但由于 XCode 是 Objective-C 写的，OC 动态性太强大，导致在这么封闭的情况下民间还是可以做出各种插件，其核心开发方式就是：
        
        dump 出 Xcode 所有头文件，知道 Xcode 里有哪些类和接口。
        
        通过头文件方法名猜测方法的作用，swizzle 这些方法，插入自己的代码实现插件逻辑。
        
        通过 NSNotificationCenter 监听各种事件的发生。
        
        更详细的开发教程网上有不少文章，有兴趣的自行搜索吧。
         */
    }
    
    //8.Jspath热更新
    else if (indexPath.section == 7) {
        /*Jspath 热更新 也是使用运行时，jspatch 基本上算是黑科技，在线修复版本bug，微信都使用了这个技术，详情百度“JSPatch”*/
    }
    
    //9.常用类
    else if (indexPath.section == 8) {
        UsedMethodViewController *vc = [[UsedMethodViewController alloc] init];
        vc.titleString = self.dataArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
