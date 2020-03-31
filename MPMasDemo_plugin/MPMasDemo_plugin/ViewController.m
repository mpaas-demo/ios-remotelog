

#import "ViewController.h"
#import <MPMasAdapter/MPMasAdapter.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"移动分析";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(30, 150, [UIScreen mainScreen].bounds.size.width-60, 44);
    button.backgroundColor = [UIColor blueColor];
    [button setTitle:@"行为日志" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendBehaviorLog) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectOffset(button.frame, 0, 80);
    button1.backgroundColor = [UIColor blueColor];
    [button1 setTitle:@"报活日志" forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(sendReportActive) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectOffset(button1.frame, 0, 80);
    button2.backgroundColor = [UIColor blueColor];
    [button2 setTitle:@"性能日志" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(sendPerformanceLog) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectOffset(button2.frame, 0, 80);
    button3.backgroundColor = [UIColor blueColor];
    [button3 setTitle:@"卡顿报告（需在真机且非xcode调试）" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(sendPerformanceLog1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    UIButton *button4 = [UIButton buttonWithType:UIButtonTypeCustom];
    button4.frame = CGRectOffset(button3.frame, 0, 80);
    button4.backgroundColor = [UIColor blueColor];
    [button4 setTitle:@"卡死报告" forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(sendPerformanceLog2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UIButton *button5 = [UIButton buttonWithType:UIButtonTypeCustom];
    button5.frame = CGRectOffset(button4.frame, 0, 80);
    button5.backgroundColor = [UIColor blueColor];
    [button5 setTitle:@"闪退报告" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(sendCrashLog) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
}

- (void)sendBehaviorLog {
    [MPRemoteLoggingInterface writeLogWithBizType:@"myBiz" eventId:@"log_test_case" extParam:@{@"logkey":@"logValue"}];

    
}

- (void)sendReportActive {
    [[MPAnalysisHelper sharedInstance] writeLogForReportActive];
}

- (void)sendPerformanceLog {
    NSArray *params = @[@"param1", @"param2", @"param3", @{@"key1":@"value1", @"key2":@"value2"}];
    [APRemoteLogger writePerformanceLogWithType:APLogTypeMemory subType:@"demo" extraParams:params];
}

- (void)sendPerformanceLog1 {
    // 模拟卡顿
    sleep(10);
}

- (void)sendPerformanceLog2 {
    // 模拟程序卡死
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sleep(30);
    });
}

- (void)sendCrashLog {
    NSArray *arr = @[@"1", @"2"];
    [arr objectAtIndex:3];
}



@end

