#import <Foundation/Foundation.h>

@interface WWDelegateCascader: NSObject

@property (nonatomic, strong, nullable) id delegate;
@property (nonatomic, weak, nullable) id proxy;

@end
