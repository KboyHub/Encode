//
//  Person.m
//  Encode
//  利用runtime运行时 可以进行遍历类的所有成员变量 文件归档、字典模型转换
//  利用runtime运行时 可以动态创建一个类
//  利用runtime运行时 可以动态为类添加、修改属性和方法 现在流行的热修复JSPatch
//  Created by yankang on 2017/3/12.
//  Copyright © 2017年 yankang. All rights reserved.
//

#import "Person.h"

@implementation Person

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        //一、获取类的成员变量
        unsigned int count = 0;
        Ivar *ivars = class_copyIvarList([Person class], &count);
        for (int i = 0; i<count; i++) {
            //1.取出对应的成员变量
            Ivar ivar = ivars[i];
            //2.查看成员变量
            const char *name = ivar_getName(ivar);
            //3.从文件中取出值
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            //4.将值赋值给类的成员变量
            [self setValue:value forKey:key];
        }
        //二、实现copy 要记得释放
        free(ivars);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    //一、获取类的成员变量
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([Person class], &count);
    for (int i = 0; i<count; i++) {
        //1.取出对应的成员变量
        Ivar ivar = ivars[i];
        //2.查看成员变量
        const char *name = ivar_getName(ivar);
        //3.归档 从类中取值
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        //4.将值归档到文件中
        [aCoder encodeObject:value forKey:key];
    }
    //二、实现copy 要记得释放
    free(ivars);
}

@end
