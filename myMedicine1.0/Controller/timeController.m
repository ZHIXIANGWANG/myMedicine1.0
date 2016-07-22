//
//  timeController.m
//  myMedicine1.0
//
//  Created by pollysoft on 16/7/13.
//  Copyright © 2016年 microi. All rights reserved.
//

#import "timeController.h"

@interface timeController ()
@property (weak, nonatomic) IBOutlet UIButton *timeButton;
@property (strong,nonatomic) NSString *timeString;
@property (nonatomic, strong) UIView *fatherView;// 传入的父控件, 确定datePicker往哪儿加
- (IBAction)ShowRollerDate:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *afterButton;
@property (weak, nonatomic) IBOutlet UIButton *beforeButton;
- (IBAction)beforeDayAction:(id)sender;
- (IBAction)afterDayAction:(id)sender;

- (void)doneRemove:(id)sender;
- (void)showViewWithAnimation:(UIView *)view YPostion:(float)yPosition;
- (void)hideViewWithAnimation:(UIView *)view;

@end

@implementation timeController
{
    UIDatePicker *datePicker;
    UIToolbar *toolBar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:_timeButton];
    [self.view bringSubviewToFront:_afterButton];
    [self.view bringSubviewToFront:_beforeButton];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    [_timeButton setTitle:[format stringFromDate:[NSDate date]] forState:UIControlStateNormal];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





- (IBAction)ShowRollerDate:(id)sender {
    
   
    [self.view addSubview:self.fatherView];

    
//    if (_fatherView &&!toolBar && !datePicker) {// 这里需要判断, 因为toolbar, datePicker你只需要建立一次, 不需要重新创建
    
        toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.f, [UIScreen mainScreen].bounds.size.height -210.f-40.f, [UIScreen mainScreen].bounds.size.width, 40.f)];
        toolBar.barStyle = UIBarStyleBlackTranslucent;
        toolBar.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [toolBar sizeToFit];
        
        UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(doneRemove:)];
//        UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneRemove:)];
        UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil ];
        
        NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft, doneBtn, nil ];
        [toolBar setItems:array animated:YES];
        
        [self.fatherView addSubview:toolBar];
        //[_fatherView bringSubviewToFront:toolBar];

        [self showViewWithAnimation:toolBar YPostion:([UIScreen mainScreen].bounds.size.height - 210.f - 40.f)];// 出现的时候需加入动画, 根据Y轴
        
        datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-210.f, [UIScreen mainScreen].bounds.size.width, 210.f)];
    //设置datepick的默认时间为当天
        datePicker.calendar = [NSCalendar currentCalendar];
       [datePicker setBackgroundColor:[UIColor whiteColor]];
        datePicker.datePickerMode = UIDatePickerModeDate;
        [_fatherView addSubview:datePicker];
       // [_fatherView bringSubviewToFront:datePicker];
        [self showViewWithAnimation:datePicker YPostion:([UIScreen mainScreen].bounds.size.height - 210.f)];// 出现的时候需加入动画, 根据Y轴
       
    NSLog(@"%@",@"执行成功");
//    }
    
}




- (IBAction)beforeDayAction:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    datePicker.date = [self preDate:datePicker.date];
    [_timeButton setTitle:[format stringFromDate:datePicker.date] forState:UIControlStateNormal];
    NSLog(@"%@",datePicker.date);
    
}

- (IBAction)afterDayAction:(id)sender {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    datePicker.date = [self nextDate:datePicker.date];
    [_timeButton setTitle:[format stringFromDate:datePicker.date] forState:UIControlStateNormal];
}
//移除toolbar和datepicker
- (void)doneRemove:(id)sender {
    if (_fatherView && toolBar && datePicker) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd"];
        [_timeButton setTitle:[format stringFromDate:datePicker.date] forState:UIControlStateNormal];
        
        [self hideViewWithAnimation:toolBar];
        
        [self hideViewWithAnimation:datePicker];
        [self.view sendSubviewToBack:_fatherView];
    }
    
}

//显示动画
- (void)showViewWithAnimation:(UIView *)view YPostion:(float)yPosition
{
    CGRect rect_origin = view.frame;
    rect_origin.origin.y = [UIScreen mainScreen].bounds.size.height;
    view.frame = rect_origin;
    //    view.alpha = 0.5f;
    
    [UIView animateWithDuration:0.5f animations:^{
        CGRect rect_current = view.frame;
        rect_current.origin.y = yPosition;
        view.frame = rect_current;
        //        view.alpha = 1.0f;
    } completion:^(BOOL finished){
        
    }];
}

//隐藏动画
- (void)hideViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.5f animations:^{
        CGRect rect_current = view.frame;
        rect_current.origin.y = ([UIScreen mainScreen].bounds.size.height);
        view.frame = rect_current;
    } completion:^(BOOL finished){
        [view setHidden:YES];
    }];
}

-(NSDate *)preDate:(NSDate *)date{

    NSDate *pre = [date dateByAddingTimeInterval:-(60*24*60)];
    return pre;

}
-(NSDate *)nextDate:(NSDate *)date{
    NSDate *next = [date dateByAddingTimeInterval:(60*24*24)];
    return next;

}

-(UIView *)fatherView{
    if(!_fatherView){
        _fatherView = [[UIView alloc]initWithFrame:CGRectMake(0,0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
       // [_fatherView setBackgroundColor:[UIColor redColor]];
    }

    return _fatherView;

}

    @end
 

