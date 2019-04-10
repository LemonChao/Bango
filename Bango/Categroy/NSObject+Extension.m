//
//  NSObject+Extension.m
//  AFNTest
//
//  Created by 张海彬 on 2017/3/17.
//  Copyright © 2017年 张海彬. All rights reserved.
//

#import "NSObject+Extension.h"
//#import <objc/Object.h>

@implementation NSObject (Extension)
@dynamic properties;
@dynamic propertiesDictionary;

-(NSMutableArray *)properties
{
    NSMutableArray *array =[NSMutableArray array] ;
    unsigned int count;
    //获取属性列表//利用这个属性可以实现给Model类赋值
    objc_property_t * propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i=0; i<count; i++)
    {
        const char * propertyname = property_getName(propertyList[i]);
        NSString *str = [NSString stringWithUTF8String:propertyname];
        [array addObject:str];
    }
    return array;
}
- (NSMutableDictionary *)propertiesDictionary
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    for (NSString *name in self.properties)
    {
        if ([[self valueForKey:name] isKindOfClass:[NSString class]])
        {
            NSString *str = [self valueForKey:name];
            if (str.length == 0)
            {
                str = @"";
            }
            [dict setObject:str forKey:name];
        }
        else
        {
            if ([self valueForKey:name] != nil)
            {
                [dict setObject:[self valueForKey:name] forKey:name];
            }
        }
    }
    return dict;
}


@end
