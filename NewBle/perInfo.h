//
//  perInfo.h
//  NewBle
//
//  Created by chengshuo on 16/1/13.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface perInfo : NSObject {
    NSString *name;
    NSString *curRSSI;
    int state;
}

- (id)InitWithName:(NSString *)pName AndRSSI:(NSNumber *)PRSSI;

- (NSString *)GetInfo;

@end
