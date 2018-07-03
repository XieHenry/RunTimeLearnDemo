//
//  DicToModelViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/29.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "DicToModelViewController.h"
#import "StatusesModel.h"
#import "NSObject+Model.h"

@interface DicToModelViewController ()
@property (nonatomic,strong) NSMutableArray *statuses;
@end

@implementation DicToModelViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 解析Plist文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"statuses.plist" ofType:nil];
    
    NSDictionary *statusDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    // 获取字典数组
    NSArray *dictArr = statusDict[@"statuses"];
    
    // 自动生成模型的属性字符串
    //    [NSObject resolveDict:dictArr[0][@"user"]];
    
    
    _statuses = [NSMutableArray array];
    
    // 遍历字典数组
    for (NSDictionary *dict in dictArr) {
        
        StatusesModel *status = [StatusesModel modelWithDict:dict];
        
        [_statuses addObject:status];
    }
    
    // 测试数据
    NSLog(@"%@",_statuses);

    
    for (int i =0; i<_statuses.count; i++) {
        StatusesModel *model = _statuses[i];
        NSLog(@"姓名:%@",model.name);
    }

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
