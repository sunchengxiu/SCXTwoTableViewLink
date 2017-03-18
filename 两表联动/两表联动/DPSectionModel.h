//
//  DPSectionModel.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+DPModel.h"
@interface DPSectionModel : NSObject
/******  name *****/
@property(nonatomic,copy)NSString *name;

/******  icon *****/
@property(nonatomic,copy)NSString *icon;

/******  array *****/
@property(nonatomic,strong)NSArray *spus;
@end
