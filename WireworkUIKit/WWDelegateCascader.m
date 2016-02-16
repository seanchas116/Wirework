#import "WWDelegateCascader.h"

@implementation WWDelegateCascader

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
    if (_delegate && [_delegate respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:_delegate];
    }
    if (_proxy && [_proxy respondsToSelector:selector]) {
        [anInvocation invokeWithTarget:_proxy];
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if (_delegate && [_delegate respondsToSelector:aSelector]) {
        return YES;
    }
    if (_proxy && [_proxy respondsToSelector:aSelector]) {
        return YES;
    }
    return [super respondsToSelector:aSelector];
}

- (NSMethodSignature*)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [_delegate methodSignatureForSelector:selector];
    }
    if (!signature) {
        signature = [_proxy methodSignatureForSelector:selector];
    }
    return signature;
}

@end
