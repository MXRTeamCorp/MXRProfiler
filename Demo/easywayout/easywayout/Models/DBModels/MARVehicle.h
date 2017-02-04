//
//  MARVehicle.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MARBaseDBModel.h"

@interface MARVehicle : MARBaseDBModel

@property (nonatomic, assign) MARVehicleType *type; // 车辆类型
@property (nonatomic, strong) NSString *prefixLicenseNumber;  // 车牌前面两位 苏E
@property (nonatomic, strong) NSString *suffixLicenseNumber;    // 车牌后面的号码

@end
