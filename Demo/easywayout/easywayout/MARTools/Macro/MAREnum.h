//
//  MAREnum.h
//  easywayout
//
//  Created by Martin.Liu on 2017/1/5.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#ifndef MAREnum_h
#define MAREnum_h

typedef NS_ENUM(NSInteger, MARVehicleType) {
    MARVehicleTypeNone = 0,
};


typedef NS_ENUM(NSInteger, Enum_Notification_Type)
{
    kNOTIFICATION_loginSuccess                      = 1,
    kNOTIFICATION_logout                            ,
    kNOTIFICATION_reverseParkspaceSuccess           ,
    kNOTIFICATION_reverseParkspaceAction            ,
};

#endif /* MAREnum_h */
