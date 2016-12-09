//
//  MyBluetoothClass.m
//  NewBle
//
//  Created by chengshuo on 16/1/7.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import "MyBluetoothClass.h"

@implementation MyBluetoothClass

@synthesize peripherals;
@synthesize bluetoothManager;
@synthesize delegate;
@synthesize  activePeripherals;

#pragma mark my methods

- (void) SetUp {
    bluetoothManager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}

- (BOOL)ScanPeripheralsUntilOvertime:(float)Time {
    if ([bluetoothManager state] != CBCentralManagerStatePoweredOn) {
        printf("CoreBluetooth is not correctly initialized !\n");
        [delegate ScanStoped];
        return NO;
    }
    
    [NSTimer scheduledTimerWithTimeInterval:Time target:self selector:@selector(TimeUp) userInfo:nil repeats:NO];
    [self BeforeScan];
    [bluetoothManager scanForPeripheralsWithServices:nil options:0];
    return YES;
}

- (void) BeforeScan {
    for (MyDevice *tempDevice in activePeripherals) {
        [bluetoothManager cancelPeripheralConnection:tempDevice.thePeripheral];
    }
    [activePeripherals removeAllObjects];
    [peripherals removeAllObjects];
    [delegate DidFoundPeripheral];
    
}

- (void) TimeUp {
    [bluetoothManager stopScan];
    [delegate ScanStoped];
}

- (void) Connect2PeripheralWithId:(int)index {
    MyDevice *tempDevice = [peripherals objectAtIndex:index];
    [bluetoothManager connectPeripheral:tempDevice.thePeripheral options:nil];
}

- (NSInteger) NumberOfPeripherals {
    return [peripherals count];
}

- (NSInteger) NumberOfActivePeripherals {
    return [activePeripherals count];
}

- (void) DisconnectFromPeripheralAtIndex:(int)row {
    
#pragma mark
    //要断开的设备组在这里处理

}

- (NSString *) GetInfoAtIndex:(int)row WithFlag:(int)flag {
    MyDevice *tempDevice;
    if (!flag) {
        tempDevice = [peripherals objectAtIndex:row];
    }
    else {
        tempDevice = [activePeripherals objectAtIndex:row];
    }
    return [tempDevice GetDeviceInfo];
}

#pragma mark iOS bluetooth protocol

- (void) centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if((__bridge CFUUIDRef )peripheral.identifier == NULL) return;
    if(peripheral.name.length < 1) return;
    printf("Now we found device!\n");
    if (!peripherals) {
        peripherals = [[NSMutableArray alloc]init];
    }
    
    for (int i = 0; i < [peripherals count]; i++) {
        MyDevice *tempDevicePointer = [peripherals objectAtIndex:i];
        if((__bridge CFUUIDRef )tempDevicePointer.thePeripheral.identifier == NULL) continue;
        CFUUIDBytes b1 = CFUUIDGetUUIDBytes((__bridge CFUUIDRef )tempDevicePointer.thePeripheral.identifier);
        CFUUIDBytes b2 = CFUUIDGetUUIDBytes((__bridge CFUUIDRef )peripheral.identifier);
        if (memcmp(&b1, &b2, 16) == 0) {
            MyDevice *tempDevice = [[MyDevice alloc]InitWithPeripheral:peripheral AndRSSI:RSSI];
            [peripherals replaceObjectAtIndex:i withObject:tempDevice];
            tempDevice = nil;
            return;
        }
    }
    MyDevice *tempDevice = [[MyDevice alloc]InitWithPeripheral:peripheral AndRSSI:RSSI];
    [peripherals addObject:tempDevice];
    tempDevice = nil;
    
    [delegate DidFoundPeripheral];
    NSLog(@"所有设备:\n%@\n",peripherals);
    
    
}

- (void) centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    if((__bridge CFUUIDRef )peripheral.identifier == NULL) return;
    if(peripheral.name.length < 1) return;
    MyDevice *tempDevice = [[MyDevice alloc]InitWithPeripheral:peripheral AndRSSI:0];
    if (!activePeripherals) {
        activePeripherals = [[NSMutableArray alloc]init];
    }
    for (int i = 0;i < [activePeripherals count]; i++) {
        MyDevice *tempDevicePointer = [activePeripherals objectAtIndex:i];
        if((__bridge CFUUIDRef )tempDevicePointer.thePeripheral.identifier == NULL) continue;
        CFUUIDBytes b1 = CFUUIDGetUUIDBytes((__bridge CFUUIDRef )tempDevicePointer.thePeripheral.identifier);
        CFUUIDBytes b2 = CFUUIDGetUUIDBytes((__bridge CFUUIDRef )peripheral.identifier);
        if (memcmp(&b1, &b2, 16) == 0) {
            [activePeripherals replaceObjectAtIndex:i withObject:tempDevice];
            tempDevice = nil;
            return;
        }
    }
    [activePeripherals addObject:tempDevice];
    tempDevice = nil;

#pragma mark
   //扫描服务及特征值
   
    
    [delegate ConnectSuccessful];
}

- (void) centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [delegate DidDisconnected];
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central {}

- (void) centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    [delegate Failed2ConnectPeripheral:peripheral WithError:error];
}

@end
