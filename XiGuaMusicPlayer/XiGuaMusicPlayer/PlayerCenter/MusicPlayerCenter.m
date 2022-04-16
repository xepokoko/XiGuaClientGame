//
//  MusicPlayerCenter.m
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import "MusicPlayerCenter.h"


static MusicPlayerCenter *playerCenter;

@implementation MusicPlayerCenter


- (BOOL)isPlaying {
    if (!_playing) {
        _playing = NO;
    }
    return _playing;
}

- (int)playMode {
    if (!_playMode) {
        _playMode = 0;
    }
    return _playMode % 3;
}


/// 单例
+ (instancetype)defaultCenter {
    if (playerCenter == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            playerCenter = [[self alloc] init];
        });
    }
    return playerCenter;
}
@end
