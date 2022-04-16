//
//  MusicPlayerView.h
//  XiGuaMusicPlayer
//
//  Created by 谢恩平 on 2022/4/16.
//

#import <UIKit/UIKit.h>
#import "UIImage+SFFont.h"
#import "MusicPlayerCenter.h"

NS_ASSUME_NONNULL_BEGIN

@interface MusicPlayerView : UIView

@property (nonatomic, strong) UIButton *lastSongBtn;

@property (nonatomic, strong) UIButton *nextSongBtn;

@property (nonatomic, strong) UIButton *playBtn;

@end

NS_ASSUME_NONNULL_END
