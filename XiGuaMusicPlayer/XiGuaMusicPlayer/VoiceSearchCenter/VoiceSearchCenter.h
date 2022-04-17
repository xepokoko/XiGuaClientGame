//
//  VoiceSearchCenter.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface VoiceSearchCenter : NSObject

@property (nonatomic, strong) UIView *view;


+ (instancetype)defaultCenter;
- (void)setFrameWithRect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
