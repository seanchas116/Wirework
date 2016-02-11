#import <Foundation/Foundation.h>

@interface WWMethodInterceptor: NSObject

@property (nonatomic, strong, nullable) id target;

- (BOOL)canInterceptSelector:(_Nonnull SEL)selector;
- (void)didInterceptSelector:(_Nonnull SEL)selector;

@end
