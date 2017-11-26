//
//  ViewController.m
//  MacCoreBluetoothBlocksTest01
//
//  Created by John Carlson on 5/8/17.
//  Copyright © 2017 John Carlson. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    //_textDisplay = [NSTextView alloc];
    
    coreBluetoothHelper = [[CoreBluetoothHelper alloc]init];
    coreBluetoothHelper.delegate = self;
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)startStopDeviceScan:(NSButton *)sender {
    if(NSOnState == sender.state)
    {
        [coreBluetoothHelper startScan];
    }
    else
    {
        [coreBluetoothHelper stopScan];
    }
}

- (void) statusUpdate:(NSString *) statusReport;
{
    [[_textDisplay.textStorage mutableString] appendString: statusReport];
    //[_textDisplay.textStorage statusReport];
    //[_textDisplay setString: statusReport];
    //NSLog(@"stausReport = %@", statusReport);
}


@end
