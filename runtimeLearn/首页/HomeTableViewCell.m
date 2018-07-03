//
//  HomeTableViewCell.m
//  runtimeLearn
//
//  Created by XieHenry on 2018/6/28.
//  Copyright © 2018年 XieHenry. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.leftlabel = [UILabel new];
        self.leftlabel.textColor = [UIColor blackColor];
        self.leftlabel.font = [UIFont systemFontOfSize:15];
        self.leftlabel.numberOfLines = 0;
        [self.contentView addSubview:self.leftlabel];
        
        [self.leftlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(40);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
            make.top.equalTo(self.contentView.mas_top).offset(22);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-22);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:lineView];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-0);
            make.height.mas_equalTo(0.5);
        }];
    }
    return self;
}

@end
