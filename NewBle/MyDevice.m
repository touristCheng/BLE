//
//  MyDevice.m
//  NewBle
//
//  Created by chengshuo on 16/1/14.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import "MyDevice.h"

@implementation MyDevice

- (id) InitWithPeripheral:(CBPeripheral *)Peripheral AndRSSI:(NSNumber *)RSSI {
    self.thePeripheral = Peripheral;
    self.curRSSI = RSSI;
    return self;
}

- (NSString *) GetDeviceInfo {
    return [NSString stringWithFormat:@"%@  - - - - - - RSSI:%@",self.thePeripheral.name,self.curRSSI];
}

@end
