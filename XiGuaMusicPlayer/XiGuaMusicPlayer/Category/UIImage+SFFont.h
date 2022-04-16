//
//  UIImage+SFFont.h
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SFFont)

/// 返回设定了大小的 SF 图片
+ (UIImage *)systemImageNamed:(NSString *)imageNamed configurationWithFontOfSize:(int)fontSize;

@end

NS_ASSUME_NONNULL_END
