//
//  GetClassPropertyObjc.h
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetClassPropertyObjc : NSObject

{
    @public
    NSString *_name;
    int _age;
}

@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) float weight;

-(void)setWeight:(float)weight;
-(float)weight;


-(void)setAddress:(NSString *)address;
-(NSString *)address;

@end
