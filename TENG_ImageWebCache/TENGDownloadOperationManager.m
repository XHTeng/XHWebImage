//
//  TENGDownloadOperationManager.m
//  TENG_ImageWebCache
//
//  Created by craneteng on 16/2/20.
//  Copyright © 2016年 craneteng. All rights reserved.
//

#import "TENGDownloadOperationManager.h"
#import "Singleton.h"
#import "TENGDonwloadOperation.h"
#import "NSString+Sandbox.h"


@interface TENGDownloadOperationManager()
@property(nonatomic,strong)NSMutableDictionary *operationCache;
@property(nonatomic,copy)NSString *currentOperation;
@property(nonatomic,strong)NSOperationQueue *queue;
//图片缓存池
@property(nonatomic,strong)NSCache *imageCache;
@end

@implementation TENGDownloadOperationManager
singletonImplementation(TENGDownloadOperationManager)
-(NSCache *)imageCache{
    if (_imageCache == nil) {
        _imageCache = [[NSCache alloc]init];
        _imageCache.countLimit = 5;
    }
    return _imageCache;
}
//懒加载操作缓存池
-(NSMutableDictionary *)operationCache{
    if (_operationCache == nil) {
        _operationCache = [[NSMutableDictionary alloc]initWithCapacity:5];
    }
    return _operationCache;
}
//懒加载队列
-(NSOperationQueue *)queue{
    if (_queue == nil) {
        _queue = [NSOperationQueue new];
    }
    return _queue;
}
-(void)downloadManagerWithURLStr:(NSString *)URLString andFinishedBlock:(void (^)(UIImage *image1))finishedBlock111{
    //从缓存中取
    UIImage *cacheImage = [self loadImageCacheWithURLString:URLString];
    if (cacheImage) {
        finishedBlock111(cacheImage);
        return;
    }
    
    //老师代码分成两部筛选
    //1、在ImageView类扩展中去掉不同操作（判断地址）
    //2、在Manager方法中判断，操作缓存池中是否有相同的操作，有则返回
    //只执行最后一次操作
    [self.operationCache[self.currentOperation] cancel];
    
    
    //创建操作
    TENGDonwloadOperation *operation = [TENGDonwloadOperation downloadWithURLStr:URLString andFinishedBlock:^(UIImage *image) {
        finishedBlock111(image);
        NSLog(@"从网上下载");
        //缓存到内存
        [self.imageCache setObject:image forKey:URLString];
        //清空缓存池
        [self.operationCache removeObjectForKey:URLString];
    }];
    [self.queue addOperation:operation];
    
    //记录当前操作
    self.currentOperation = URLString;
    //添加到缓存池
    [self.operationCache setValue:operation forKey:URLString];
}
-(UIImage *)loadImageCacheWithURLString:(NSString *)URLString{
    //从缓存池中取
    UIImage * RAMcacheImage = [self.imageCache objectForKey:URLString];
    if (RAMcacheImage) {
        NSLog(@"从内存中加载");
        return RAMcacheImage;
    }
    //从磁盘上取
    UIImage *diskImage = [UIImage imageWithContentsOfFile:[URLString appendCache] ];
    if (diskImage) {
        //放到缓存中
        [self.imageCache setObject:diskImage forKey:URLString];
        return diskImage;
    }
    return nil;
}
@end
