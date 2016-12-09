//
//  ViewController.h
//  NewBle
//
//  Created by chengshuo on 16/1/7.
//  Copyright © 2016年 chengshuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyBluetoothClass.h"

@interface ViewController : UIViewController <MyBlueToothDelegate,UITableViewDataSource,UITableViewDelegate> {
    MyBluetoothClass *localManager;
    UITableView *deviceList;
    BOOL isScaning;
    
    /*
     对外部完全隐藏成员，声明成私有成员
     */
    
    
}

@property (weak, nonatomic) IBOutlet UIButton *scanButton;

@property (weak, nonatomic) IBOutlet UITextView *showInfo;


@end

