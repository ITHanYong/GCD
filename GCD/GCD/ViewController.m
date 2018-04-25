//
//  ViewController.m
//  GCD
//
//  Created by HanYong on 2018/4/24.
//  Copyright © 2018年 HanYong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self GCD];
    [self asyncserial];
}

- (void)GCD{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       
        NSLog(@"GCD - start");
        
        // 异步追加任务
        for (int i = 0; i < 2; ++i) {
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"%d---%@",i,[NSThread currentThread]);      // 打印当前线程
        }
        
        NSLog(@" ----- ");
        
        //main - 优先级最低、在异步线程队列中最后执行  main里面顺序执行
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // 追加在主线程中执行的任务
            [NSThread sleepForTimeInterval:2];              // 模拟耗时操作
            NSLog(@"main---%@",[NSThread currentThread]);      // 打印当前线程
            
        });
        
        NSLog(@"GCD - end");
    });
}

//异步 - 串行
- (void)asyncserial{
    
    [NSThread sleepForTimeInterval:2];
    NSLog(@"asyncserial - start");
    
    //异步多线程等方法
    dispatch_async(dispatch_queue_create("GCD", DISPATCH_QUEUE_SERIAL), ^{
        
        NSLog(@"in - start - 1");
        NSLog(@"in - start - 2");
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"main - 1");
        });
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"main - 2");
        });
        
        NSLog(@"in - end");
    });
    
    [NSThread sleepForTimeInterval:2];
    NSLog(@"asyncserial - end");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
