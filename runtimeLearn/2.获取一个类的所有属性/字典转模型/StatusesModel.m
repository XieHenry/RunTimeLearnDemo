//
//  StatusesModel.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/29.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "StatusesModel.h"

@implementation StatusesModel

+ (instancetype)statusWithDict:(NSDictionary *)dict {
    StatusesModel *status = [[self alloc] init];
    [status setValuesForKeysWithDictionary:dict];
    
    return status;
}

@end
