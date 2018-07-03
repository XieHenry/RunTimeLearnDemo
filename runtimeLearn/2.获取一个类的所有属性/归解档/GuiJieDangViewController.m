//
//  GuiJieDangViewController.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "GuiJieDangViewController.h"
#import "GuiJieDangObjc.h"

@interface GuiJieDangViewController ()

@end

@implementation GuiJieDangViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *titleArray = @[@"存数据",@"取数据"];
    for (int i=0; i<titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        button.frame = CGRectMake((SCREEN_WIDTH()-100)/2, (SCREEN_HEIGHT()-200)/2+100*i, 100, 40);
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitle:titleArray[i] forState:(UIControlStateNormal)];
        button.tag = 100 +i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:button];
    }
 

}


-(void)buttonClick:(UIButton *)button {
    if (button.tag == 100) {
        GuiJieDangObjc * p = [[GuiJieDangObjc alloc]init];
        p.name = @"波仔";
        p.age = 18;
        
        NSString * temp = NSTemporaryDirectory();
        NSString * filePath = [temp stringByAppendingPathComponent:@"bozai.txt"];
        NSLog(@"%@",temp);
        
        [NSKeyedArchiver archiveRootObject:p toFile:filePath];
    } else {
        NSString * temp = NSTemporaryDirectory();
        NSString * filePath = [temp stringByAppendingPathComponent:@"bozai.txt"];
        
        GuiJieDangObjc * p = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"%@今年 %d岁",p.name,p.age);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
