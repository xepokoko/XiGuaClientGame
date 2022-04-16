//
//  UIImage+SFFont.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "UIImage+SFFont.h"

@implementation UIImage (SFFont)

+ (UIImage *)systemImageNamed:(NSString *)imageNamed configurationWithFontOfSize:(int)fontSize {
    UIImage *image = [[UIImage systemImageNamed:imageNamed] imageWithConfiguration:[UIImageSymbolConfiguration configurationWithFont:[UIFont systemFontOfSize:fontSize]]];
    return image;
}


@end
