//
//  UsedMethodObject.h
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/27.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UsedMethodObject : NSObject
{
    NSString *age;
    NSString *money;
}
//实例方法
-(void)testMethod1;
//类方法
+(void)testMethod2;

-(void)testMethod3;



@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@end
