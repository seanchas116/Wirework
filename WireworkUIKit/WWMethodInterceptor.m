#import "WWMethodInterceptor.h"

@implementation WWMethodInterceptor

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = anInvocation.selector;
    if ([self canInterceptSelector:selector]) {
        [self didInterceptSelector:selector];
    }
    if (_target && [_target respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:_target];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self canInterceptSelector:aSelector]) {
        return YES;
    }
    if (_target && [_target respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [_target methodSignatureForSelector:selector];
    }
    return signature;
}

- (BOOL)canInterceptSelector:(SEL)selector
{
    return NO;
}

- (void)didInterceptSelector:(SEL)selector
{
}

@end
