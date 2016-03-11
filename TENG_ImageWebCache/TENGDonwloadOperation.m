//
//  TENGDonwloadOperation.m
//  TENG_ImageWebCache
//
//  Created by craneteng on 16/2/20.
//  Copyright © 2016年 craneteng. All rights reserved.
//

#import "NSString+Sandbox.h"
#import "TENGDonwloadOperation.h"
@interface TENGDonwloadOperation()
@property(nonatomic,strong)void (^finishedBlock)(UIImage *);
@property(nonatomic,copy)NSString *URLString;

@end


@implementation TENGDonwloadOperation

-(void)main{
    @autoreleasepool {
        //模拟耗时操作
        [NSThread sleepForTimeInterval:2];
        
        if (self.isCancelled) {
            return;
        }
        //请求数据
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString]];
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            NSLog(@"正在下载操作，线程：%@，文件地址：%@",[NSThread currentThread],self.URLString);
            //归档
            [data writeToFile:[self.URLString appendCache] atomically:YES];
            UIImage *image = [UIImage imageWithData:data];
            
            self.finishedBlock(image);
        }];
        
        
        
        
        
        
    }
}
#pragma mark - 下载操作
+(instancetype )downloadWithURLStr:(NSString *)URLString andFinishedBlock:(void (^)(UIImage *image))finishedBlock{
    //创建操作
    TENGDonwloadOperation * operation = [[TENGDonwloadOperation alloc]init];
    operation.finishedBlock = finishedBlock;
    operation.URLString = URLString;
    return operation;
}
@end
