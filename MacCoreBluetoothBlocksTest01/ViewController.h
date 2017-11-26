//
//  ViewController.h
//  MacCoreBluetoothBlocksTest01
//
//  Created by John Carlson on 5/8/17.
//  Copyright © 2017 John Carlson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreBluetooth/CoreBluetooth.h>

#include "CoreBluetoothHelper.h"

@interface ViewController : NSViewController <CoreBluetoothHelperDelegate>
{
    CoreBluetoothHelper *coreBluetoothHelper;
}


@property (unsafe_unretained) IBOutlet NSTextView *textDisplay;

@end

