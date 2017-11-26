//
//  CoreBluetoothHelper.m
//  MacCoreBluetoothBlocksTest01
//
//  Created by John Carlson on 5/20/17.
//  Copyright © 2017 John Carlson. All rights reserved.
//

#import "CoreBluetoothHelper.h"

@implementation CoreBluetoothHelper
{
    //NSString *statusReport;
}

@synthesize delegate;

- (void)setDelegate:(id <CoreBluetoothHelperDelegate>)aDelegate {
    if (delegate != aDelegate) {
        delegate = aDelegate;
        
        //statusReport = [delegate respondsToSelector:@selector(CoreBluetoothHelper:statusUpdate:)];
    }
}



- (CoreBluetoothHelper *) init
{
    self = [super init];
    
    myCentralManager =
    [[CBCentralManager alloc] initWithDelegate:self queue:nil options:nil];
    
    //NSLog(@"CBCentralManager allocated.");
    self.statusReport = @"\n\n\nCBCentralManager allocated.";
    [self.delegate statusUpdate:self.statusReport];
    
    return self;
}



- (void) startScan
{
    //[myCentralManager scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"6B872736-F93E-4176-B3B1-143636CABB00"]] options:nil];  // iRig Blueboard
    
    //[myCentralManager scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"03B80E5A-EDE8-4B33-A751-6CE34EC4C700"]] options:nil];  // Roli Lightpad Block
    
    //[myCentralManager scanForPeripheralsWithServices:[NSArray arrayWithObject:[CBUUID UUIDWithString:@"03B80E5A-EDE8-4B33-A751-6CE34EC4C700"]] options:nil];  // Roli Control Block
    
    [myCentralManager scanForPeripheralsWithServices:nil options:nil];
    
    //NSLog(@"\n\n\nscanning...");
    self.statusReport = @"\n\n\nscanning...";
    [self.delegate statusUpdate:self.statusReport];
}



- (void) stopScan
{
    [myCentralManager stopScan];
    
    //NSLog(@"\n\n\nscanning stopped.");
    self.statusReport = @"\n\n\nscanning stopped.";
    [self.delegate statusUpdate:self.statusReport];
}



- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //Do something when a peripheral is discovered.
    
    //NSLog(@"\n\n\nDid discover peripheral. \nperipheral: \n%@ \nrssi: \n%@, \nUUID: \n%@ \nadvertisementData: \n%@ ", peripheral, RSSI, peripheral.identifier, advertisementData);
    self.statusReport = [NSString stringWithFormat:@"\n\n\nDid discover peripheral. \nperipheral: \n%@ \nrssi: \n%@, \nUUID: \n%@ \nadvertisementData: \n%@ ", peripheral, RSSI, peripheral.identifier, advertisementData];
    [self.delegate statusUpdate:self.statusReport];
    
    //if (_discoveredPeripheral != peripheral) {
    // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
    //}
    
    _discoveredPeripheral = peripheral;
    
    // And connect
    [myCentralManager connectPeripheral:peripheral options:nil];
    
    //NSLog(@"\n\n\nConnecting to peripheral\n %@", peripheral);
    self.statusReport = [NSString stringWithFormat:@"\n\n\nConnecting to peripheral\n%@", peripheral];
    [self.delegate statusUpdate:self.statusReport];
}




- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    
}





- (void)centralManager:(CBCentralManager *)central
  didConnectPeripheral:(CBPeripheral *)peripheral {
    
    //NSLog(@"\n\n\n%@ connected", peripheral);
    self.statusReport = [NSString stringWithFormat:@"\n\n\n%@ connected", peripheral];
    [self.delegate statusUpdate:self.statusReport];
    
    peripheral.delegate = self;
    
    [peripheral discoverServices:nil];
    
    //[peripheral setNotifyValue:YES forCharacteristic:interestingCharacteristic];
}



- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverServices:(NSError *)error {
    
    for (CBService *service in peripheral.services) {
        //NSLog(@"Discovered service %@", service);
        self.statusReport = [NSString stringWithFormat:@"Discovered service %@", service];
        [self.delegate statusUpdate:self.statusReport];

        
        //
        [peripheral discoverCharacteristics:nil forService:service];
        //NSLog(@"Discovering characteristics for service %@", service);
        self.statusReport = [NSString stringWithFormat:@"Discovering characteristics for service %@", service];
        [self.delegate statusUpdate:self.statusReport];
    }
}




- (void)peripheral:(CBPeripheral *)peripheral
didDiscoverCharacteristicsForService:(CBService *)service
             error:(NSError *)error {
    
    for (CBCharacteristic *characteristic in service.characteristics) {
        //NSLog(@"Discovered characteristic %@", characteristic);
        self.statusReport = [NSString stringWithFormat:@"Discovered characteristic %@", characteristic];
        [self.delegate statusUpdate:self.statusReport];
        
        
        [peripheral readValueForCharacteristic:characteristic];
        
        //NSLog(@"Reading value for characteristic %@", characteristic);
        self.statusReport = [NSString stringWithFormat:@"Reading value for characteristic %@", characteristic];
        [self.delegate statusUpdate:self.statusReport];
        
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}




- (void)peripheral:(CBPeripheral *)peripheral
didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    
    NSData *data = characteristic.value;
    
    // parse the data as needed
    //NSLog(@"data = %@", data);
    self.statusReport = [NSString stringWithFormat:@"\ndata = %@", data];
    [self.delegate statusUpdate:self.statusReport];
}




- (void)centralManager:(CBCentralManager *)central
didDisconnectPeripheral:(CBPeripheral *)peripheral
                 error:(NSError *)error{
    
    [myCentralManager connectPeripheral:peripheral options:nil];
    
    NSLog(@"\n\n\nConnecting to peripheral\n %@", peripheral);
}


@end
