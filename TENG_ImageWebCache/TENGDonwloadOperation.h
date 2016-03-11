//
//  TENGDonwloadOperation.h
//  TENG_ImageWebCache
//
//  Created by craneteng on 16/2/20.
//  Copyright © 2016年 craneteng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TENGDonwloadOperation : NSOperation
+(instancetype )downloadWithURLStr:(NSString *)URLString andFinishedBlock:(void (^)(UIImage *image))finishedBlock;
@end
