//
//  MyBluetoothClass.h
//  NewBle
//
//  Created by chengshuo on 16/1/7.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CFNetwork/CFNetwork.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import "MyDevice.h"

@protocol MyBlueToothDelegate

@required
- (void) ScanStoped;   //更新UIview，扫描停止，按钮恢复

- (void) Failed2ConnectPeripheral:(CBPeripheral *)Peripheral WithError:(NSError *)error; //连接不了设备，出现警告

- (void) DidDisconnected; //断开后更新界面

- (void) ConnectSuccessful; //连接成功

- (void) DidFoundPeripheral; //扫面完成，获取数组，更新界面

@end


@interface MyBluetoothClass : NSObject <CBCentralManagerDelegate,CBPeripheralDelegate> {}

@property (strong , nonatomic) CBCentralManager *bluetoothManager;
@property (strong , nonatomic) NSMutableArray *activePeripherals;
@property (assign , nonatomic) id <MyBlueToothDelegate> delegate;
@property (strong , nonatomic)  NSMutableArray *peripherals;


- (void) SetUp;

- (BOOL) ScanPeripheralsUntilOvertime:(float)Time;

- (void) Connect2PeripheralWithId:(int)index;

- (void) DisconnectFromPeripheralAtIndex:(int)row;

- (NSString *) GetInfoAtIndex:(int)row WithFlag:(int)flag;

- (NSInteger) NumberOfPeripherals;

- (NSInteger) NumberOfActivePeripherals;

@end
