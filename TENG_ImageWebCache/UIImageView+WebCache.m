//
//  UIImageView+WebCache.m
//  TENG_ImageWebCache
//
//  Created by craneteng on 16/2/20.
//  Copyright © 2016年 craneteng. All rights reserved.
//

#import "UIImageView+WebCache.h"
#import "TENGDownloadOperationManager.h"
@implementation UIImageView (WebCache)
-(void)teng_setWebCacheImageViewWithURLStr:(NSString *)URLSrting{
    TENGDownloadOperationManager *opration = [TENGDownloadOperationManager sharedTENGDownloadOperationManager];
    [opration downloadManagerWithURLStr:URLSrting andFinishedBlock:^(UIImage *image) {
        self.image = image;
    }];
}

@end

