//
//  NSObject+DPModel.m
//  两表联动
//
//  Created by 孙承秀 on 16/11/28.
//  Copyright © 2016年 孙先森丶. All rights reserved.
//

#import "NSObject+DPModel.h"
#import <objc/runtime.h>
@implementation NSObject (DPModel)
#pragma mark -- runtimemodel解析
+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self, &count);
    for (int i = 0 ; i < count; i ++) {
        Ivar propertyName = ivarList[i];
        // 带有下划线的名字
        NSString *name = [NSString stringWithUTF8String:ivar_getName(propertyName)];
        // 不带有下划线的名字
        NSString *key = [name substringFromIndex:1];
        
        // key对应的value
        id value = dict[key];
        if (!value) {
            
            // 是否调用了替换关键字的方法，如果调用了，即时更改关键字的名字
            if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
                NSString *newKey = [self replacedKeyFromPropertyName][key];
                value = dict[newKey];
            }
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            
            NSString *classType = [NSString stringWithUTF8String:ivar_getTypeEncoding(propertyName)];
            classType = [classType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
            classType = [classType stringByReplacingOccurrencesOfString:@"@" withString:@""];
            Class class = NSClassFromString(classType);
            if (class) {
                value = [self modelWithDictionary:value];
            }
        }
        if ([value isKindOfClass:[NSArray class]]) {
            if ([self respondsToSelector:@selector(objectClassInArray)]) {
                NSString *modelClassName = [self objectClassInArray][key];
                NSMutableArray *models = [NSMutableArray array];
                for (NSDictionary *dic in value) {
                    Class class = NSClassFromString(modelClassName);
                    id model = [class modelWithDictionary:dic];
                    [models addObject:model];
                }
                value = models;
            }
        }
        if (value) {
            [obj setValue:value forKey:key];
        }
    }
    free(ivarList);
    return obj;
}
@end
