//
//  perInfo.m
//  NewBle
//
//  Created by chengshuo on 16/1/13.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import "perInfo.h"

@implementation perInfo

- (id)InitWithName:(NSString *)pName AndRSSI:(NSNumber *)PRSSI {
    name = pName;
    curRSSI = [NSString stringWithFormat:@"%@",PRSSI];
    
    return self;
}

- (NSString *)GetInfo {
    return [NSString stringWithFormat:@"%@            RSSI: %@",name,curRSSI];
}

@end
