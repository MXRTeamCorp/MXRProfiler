//
//  MarReserveParkSpaceViewController.m
//  easywayout
//
//  Created by Martin.Liu on 2017/1/7.
//  Copyright © 2017年 MAIERSI. All rights reserved.
//

#import "MarReserveParkSpaceViewController.h"
#import "MARReserveParkSpaceResultViewController.h"
@interface MarReserveParkSpaceViewController ()

#pragma mark IB Property
@property (weak, nonatomic) IBOutlet UIButton *reserveDateButton;
@property (weak, nonatomic) IBOutlet UIButton *reserveTimeButton;

#pragma mark IB Action
- (IBAction)clickReserveButtonAction:(id)sender;

#pragma mark Custom Property
@property (nonatomic, strong) NSString *dateString;
@property (nonatomic, strong) NSString *timeString;

@end

@implementation MarReserveParkSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"预约车位";
    [self setDateTimeStringAfterHalfHour];
    [self.reserveDateButton setTitle:self.dateString forState:UIControlStateNormal];
    [self.reserveTimeButton setTitle:self.timeString forState:UIControlStateNormal];
}

- (void)setDateTimeStringAfterHalfHour
{
    NSDate *date = [NSDate new];
    NSTimeInterval aTimeInterval = [date timeIntervalSinceReferenceDate] + 60 * 30;
    date = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy/MM/ddhh:mm";
    NSString *dateTimeString = [dateFormatter stringFromDate:date];
    if (dateTimeString.length == 15) {
        NSUInteger seperateIndex = 10;  // need > 1
        NSString *dateString = [dateTimeString substringToIndex:seperateIndex];
        NSString *timeString = [dateTimeString substringFromIndex:seperateIndex];
        const char *constDateCString = [dateString UTF8String];
        if (strlen(constDateCString) == seperateIndex) {
            char *tempDateCString = malloc(sizeof(char*) * (seperateIndex * 2)); // seperateIndex-1个空格和一个结束符'\0'
            char *dateCString = tempDateCString;
            for (int i = 0; i < seperateIndex; i++) {
                *tempDateCString = *constDateCString;
                if (i != seperateIndex - 1) {
                    tempDateCString++;
                    *tempDateCString = ' ';
                }
                else
                {
                    tempDateCString++;
                    *tempDateCString = '\0';
                }
                constDateCString++;
                tempDateCString++;
            }
            constDateCString = NULL;
            tempDateCString = NULL;

            self.dateString = [NSString stringWithCString:dateCString encoding:NSUTF8StringEncoding];
            free(dateCString);
        }
        
        const char *constTimeCString = [timeString UTF8String];
        char *tempTimeCString = malloc(sizeof(char*) * (5 + 2 + 1)); // 2个空格和一个结束符'\0'
        char *timeCString = tempTimeCString;
        for (int i = 0; i < 5; i++) {
            *tempTimeCString = *constTimeCString;
            if (i == 0 || i == 3) {
                tempTimeCString++;
                *tempTimeCString = ' ';
            }
            else if (i == 4)
            {
                tempTimeCString++;
                *tempTimeCString = '\0';
            }
            
            constTimeCString++;
            tempTimeCString++;
        }
        constTimeCString = NULL;
        tempTimeCString = NULL;
        self.timeString = [NSString stringWithCString:timeCString encoding:NSUTF8StringEncoding];
        free(timeCString);
    }
    
}

- (NSString *)dateString
{
    return _dateString ?: @"";
}

- (NSString *)timeString
{
    return _timeString ?: @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)clickReserveButtonAction:(id)sender {
    MARReserveParkSpaceResultViewController *reserveResultVC = (MARReserveParkSpaceResultViewController *)VCBySBNameAndSBID(kSBNAME_MAIN, kSBID_VCNAME_ReserveParkSpaceResult);
    reserveResultVC.parkSpaceName = self.parkSpaceName;
    reserveResultVC.dateString = self.dateString;
    reserveResultVC.timeString = self.timeString;
    [self.navigationController pushViewController:reserveResultVC animated:YES];
}
@end
