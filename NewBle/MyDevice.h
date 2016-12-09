//
//  MyDevice.h
//  NewBle
//
//  Created by chengshuo on 16/1/14.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface MyDevice : NSObject

@property (retain , nonatomic) CBPeripheral *thePeripheral;
@property (retain , nonatomic) NSNumber *curRSSI;

- (id)InitWithPeripheral:(CBPeripheral*)Peripheral AndRSSI:(NSNumber *)RSSI;

- (NSString *)GetDeviceInfo;

@end