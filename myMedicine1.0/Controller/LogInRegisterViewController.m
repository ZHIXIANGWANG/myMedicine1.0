//
//  LogInRegisterViewController.m
//  myMedicine1.0
//
//  Created by pollysoft on 16/7/15.
//  Copyright © 2016年 microi. All rights reserved.
//

#import "LogInRegisterViewController.h"

@interface LogInRegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;

@end

@implementation LogInRegisterViewController
- (IBAction)LogInActin:(id)sender {
    
    NSString *userName = _userName.text;
    NSString *userPassword = _userPassword.text;
    if ([userName isEqualToString:@"admin"] && [userPassword isEqualToString:@"123"]) {
        
        //获取storyboard: 通过bundle根据storyboard的名字来获取我们的storyboard
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        //由storyboard根据myView的storyBoardID来获取我们要切换的视图
        UIViewController *timeViewController = [story instantiateViewControllerWithIdentifier:@"timeController"];
        //由navigationController推向我们要推向的view
        [self.navigationController pushViewController: timeViewController animated:YES];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

@end
