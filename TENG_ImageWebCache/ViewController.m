//
//  ViewController.m
//  TENG_ImageWebCache
//
//  Created by craneteng on 16/2/20.
//  Copyright © 2016年 craneteng. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "HMAppInfo.h"

@interface ViewController ()

@property (nonatomic, strong) NSArray *appInfos;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

//懒加载数据
- (NSArray *)appInfos {
    if (_appInfos == nil) {
        _appInfos = [HMAppInfo appInfos];
    }
    return _appInfos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //随机取一个模型
    int index = arc4random_uniform((u_int32_t)self.appInfos.count);
    HMAppInfo *appInfo = self.appInfos[index];
    
    [self.imageView teng_setWebCacheImageViewWithURLStr:appInfo.icon];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
