//
//  ViewController.m
//  NewBle
//
//  Created by chengshuo on 16/1/7.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import "ViewController.h"

#define timeup 5

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    localManager = [[MyBluetoothClass alloc]init];
    [localManager SetUp];
    localManager.delegate = self;
    
    CGRect table = CGRectMake(40, 180, 240, 80);
    deviceList = [[UITableView alloc]initWithFrame:table];
    deviceList.delegate = self;
    deviceList.dataSource = self;
    [self.view addSubview:deviceList];
    
    
#pragma mark
    //添加约束
    
    
    isScaning = NO;
    // Do any additional setup after loading the view, typically from a nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAllButUpsideDown;
}



- (IBAction)Tap2Scan:(id)sender {
    if (isScaning) {
        return;
    }
    
    isScaning = YES;
    _showInfo.text = @"";
    [_scanButton setTitle:@"扫描中..." forState:UIControlStateNormal];
    BOOL powerOn = [localManager ScanPeripheralsUntilOvertime:timeup];
    if (!powerOn) {
        
        //
        //
        
        
    }
}

#pragma mark my protocol

- (void) ScanStoped {
    isScaning = NO;
    [_scanButton setTitle:@"开始扫描" forState:UIControlStateNormal];
    
}

- (void) DidFoundPeripheral {
    
    [deviceList reloadData];
}

- (void) ConnectSuccessful {
#pragma mark
    //测试，之后重写
    
    
    
    for (MyDevice *tempDevice in localManager.activePeripherals) {
        NSString *tempStr = [NSString stringWithFormat:@"%@\n\n\n%@",_showInfo.text,tempDevice.thePeripheral.description];
        _showInfo.text = tempStr;
        tempStr = nil;
    }
}


- (void) Failed2ConnectPeripheral:(CBPeripheral *)Peripheral WithError:(NSError *)error {
    
#pragma maek
    
    
    //连接失败时被调用
    //弹出警告
}

- (void) DidDisconnected {
    
#pragma mark
    //断开连接后被调用
    
}

#pragma mark tabel protocol

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [localManager NumberOfPeripherals];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    int row = (int)[indexPath row];
    
    cell.textLabel.text = [localManager GetInfoAtIndex:row WithFlag:0];
    
    NSLog(@"更新  %@",[localManager GetInfoAtIndex:row WithFlag:0]);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    [localManager Connect2PeripheralWithId:(int)row];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
