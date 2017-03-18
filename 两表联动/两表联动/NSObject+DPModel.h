//
//  NSObject+DPModel.h
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol keyValue <NSObject>

@optional


/**
 当一个模型中含有数组时候，调用此方法，循环遍历
 */
+ (NSDictionary *)objectClassInArray;
/**
 替换和系统冲突的关键字
 */
+ (NSDictionary *)replacedKeyFromPropertyName;

@end
@interface NSObject (DPModel)<keyValue>
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
@end
