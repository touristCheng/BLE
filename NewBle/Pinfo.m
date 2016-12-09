//
//  Pinfo.m
//  NewBle
//
//  Created by chengshuo on 16/1/13.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pinfo : NSObject {
    NSString *name;
    NSString *curRSSI;
    int state;
}

- (id)InitWithName:(NSString *)pName AndRSSI:(NSNumber *)PRSSI;

- (NSString *)GetInfo;

@end

@implementation Pinfo

- (id)InitWithName:(NSString *)pName AndRSSI:(NSNumber *)PRSSI {
    name = pName;
    curRSSI = [NSString stringWithFormat:@"%@",PRSSI];
    return self;
}

- (NSString *)GetInfo {
    return [NSString stringWithFormat:@"%@       %@",name,curRSSI];
}

@end