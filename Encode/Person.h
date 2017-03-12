//
//  Person.h
//  Encode
//
//  Created by yankang on 2017/3/12.
//  Copyright © 2017年 yankang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface Person : NSObject<NSCoding>

@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;
@property (nonatomic,copy)NSString *phoneNumber;


@end
