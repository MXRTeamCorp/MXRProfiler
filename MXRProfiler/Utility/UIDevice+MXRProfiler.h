//
//  UIDevice+MXRProfiler.h
//  easywayout
//
//  Created by Martin.Liu on 2017/2/9.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMXRMachieNameIPhone1G      @"iPhone 1G"
#define kMXRMachieNameIPhone3G      @"iPhone 3G"
#define kMXRMachieNameIPhones3GS    @"iPhone 3GS"
#define kMXRMachieNameIPhone4GSM    @"iPhone 4 (GSM)"
#define kMXRMachieNameIPhone4       @"iPhone 4"
#define kMXRMachieNameIPhone4CDMA   @"iPhone 4 (CDMA)"
#define kMXRMachieNameIPhone4S      @"iPhone 4S"
#define kMXRMachieNameIPhone5       @"iPhone 5"
#define kMXRMachieNameIPhone5C      @"iPhone 5c"
#define kMXRMachieNameIPhone5S      @"iPhone 5s"
#define kMXRMachieNameIPhone6Plus   @"iPhone 6 Plus"
#define kMXRMachieNameIPhone6       @"iPhone 6"
#define kMXRMachieNameIPhone6S      @"iPhone 6s"
#define kMXRMachieNameIPhone6SPlus  @"iPhone 6s Plus"
#define kMXRMachieNameIPhoneSE      @"iPhone SE"
#define kMXRMachieNameIPhone7       @"iPhone 7"
#define kMXRMachieNameIPhone7Plus   @"iPhone 7 Plus"

#define kMXROldMachies              (@[kMXRMachieNameIPhone1G, \
                                        kMXRMachieNameIPhone3G, \
                                        kMXRMachieNameIPhones3GS,\
                                        kMXRMachieNameIPhone4GSM,\
                                        kMXRMachieNameIPhone4,\
                                        kMXRMachieNameIPhone4CDMA,\
                                        kMXRMachieNameIPhone4S\
                                    ])

#define kMXRIphone5SeriesMachies    (@[kMXRMachieNameIPhone5, \
                                        kMXRMachieNameIPhone5C, \
                                        kMXRMachieNameIPhone5S,\
                                        kMXRMachieNameIPhoneSE\
                                    ])

#define kMXRIphone6SeriesMachies    (@[kMXRMachieNameIPhone6, \
                                        kMXRMachieNameIPhone6Plus, \
                                        kMXRMachieNameIPhone6S\
                                    ])

#define kMXRIphone7SeriesMachies    (@[kMXRMachieNameIPhone6, \
                                        kMXRMachieNameIPhone6Plus, \
                                        kMXRMachieNameIPhone6S\
                                    ])

#define kMXRISOldMachie()           ([kMXROldMachies containsObject:[UIDevice currentDevice].mxr_machineModelName])
#define kMXRISIphone5Series()       ([kMXRIphone5SeriesMachies containsObject:[UIDevice currentDevice].mxr_machineModelName])
#define kMXRISIphone6Series()       ([kMXRIphone6SeriesMachies containsObject:[UIDevice currentDevice].mxr_machineModelName])
#define kMXRISIphone7Series()       ([kMXRIphone7SeriesMachies containsObject:[UIDevice currentDevice].mxr_machineModelName])

#define kMXRIsIOSLater(_value_)     ([UIDevice currentDevice].systemVersion.doubleValue >= _value_)

@interface UIDevice (MXRProfiler)

/// The device's machine model.  e.g. "iPhone6,1" "iPad4,6"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *mxr_machineModel;

/// The device's machine model name. e.g. "iPhone 5s" "iPad mini 2"
/// @see http://theiphonewiki.com/wiki/Models
@property (nonatomic, readonly) NSString *mxr_machineModelName;

@end
