/*
 快速创建单例宏
 */
// 1. .h文件宏 singletonInterface(参数)
#define singletonInterface(className)           + (instancetype)shared##className;

// 2. .m文件宏 singletonImplementation(参数)

// 判断 是否是 ARC
#if __has_feature(objc_arc)
#define singletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [super allocWithZone:zone]; \
    }); \
    return instance; \
} \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return instance; \
}
#else 
// MRC 部分
#define singletonImplementation(className) \
static id instance; \
+ (instancetype)allocWithZone:(struct _NSZone *)zone { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [super allocWithZone:zone]; \
    }); \
    return instance; \
} \
+ (instancetype)shared##className { \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        instance = [[self alloc] init]; \
    }); \
    return instance; \
} \
- (id)copyWithZone:(NSZone *)zone { \
    return instance; \
} \
- (oneway void)release {} \
- (instancetype)retain {return instance;} \
- (instancetype)autorelease {return instance;} \
- (NSUInteger)retainCount {return ULONG_MAX;}

#endif