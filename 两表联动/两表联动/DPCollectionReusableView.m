//
//  DPCollectionReusableView.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/29.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "DPCollectionReusableView.h"

@implementation DPCollectionReusableView
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor lightGrayColor];
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, [UIScreen mainScreen].bounds.size.width - 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}
@end
