//
//  CBPeripheral+MyPeripheral.h
//  NewBle
//
//  Created by chengshuo on 16/1/14.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

@interface CBPeripheral (MyPeripheral) 
@property (retain , nonatomic) NSNumber *curRSSI;

@end
