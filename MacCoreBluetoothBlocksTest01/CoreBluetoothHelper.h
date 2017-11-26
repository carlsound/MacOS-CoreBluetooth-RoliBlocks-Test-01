//
//  CoreBluetoothHelper.h
//  MacCoreBluetoothBlocksTest01
//
//  Created by John Carlson on 5/20/17.
//  Copyright © 2017 John Carlson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>




@protocol CoreBluetoothHelperDelegate<NSObject>

- (void) statusUpdate:(NSString *) statusReport;

@end



@interface CoreBluetoothHelper : NSObject <CBCentralManagerDelegate>
{
    CBCentralManager *myCentralManager;
    
    // Delegate to respond back
    id <CoreBluetoothHelperDelegate> _delegate;
}

@property (nonatomic,strong) id <CoreBluetoothHelperDelegate> delegate;

@property (nonatomic, retain) NSString *statusReport;

@property (strong, nonatomic) CBPeripheral *discoveredPeripheral;

- (CoreBluetoothHelper *) init;

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral;

- (void) startScan;

- (void) stopScan;

@end
