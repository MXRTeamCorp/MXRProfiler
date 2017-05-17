//
//  MXRProfilerNetFlowCellView.h
//  easywayout
//
//  Created by weiqing.tang on 2017/5/17.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXRNetFlowInfo.h"
@interface MXRProfilerNetFlowCellView : UITableViewCell

-(void)setData:(MXRNetFlowInfo*)info;
@end
