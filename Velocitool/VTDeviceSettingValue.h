//
//  VTDeviceSettingValue.h
//  Velocitool
//
//  Created by Alec Stewart on 6/27/10.
//  Copyright 2010 Velocitek. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface VTDeviceSettingValue : NSObject {
	
	NSString *displayValue;
	NSNumber *numericalValue;
	BOOL isDefaultValue;

}

@property (readwrite, retain) NSString *displayValue;
@property (readwrite, retain) NSNumber *numericalValue;

- (id)initWithDisplayAndNumericalValues:(NSString *)dispVal numericalValue:(NSNumber *)numVal;
+ (id)deviceSettingValueWithDisplayAndNumericalValues:(NSString *)dispVal numericalValue:(NSNumber *)numVal;

@end
