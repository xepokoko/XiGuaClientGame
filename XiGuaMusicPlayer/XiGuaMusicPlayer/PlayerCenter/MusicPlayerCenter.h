//
//  MusicPlayerCenter.h
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "MusicModel.h"

NS_ASSUME_NONNULL_BEGIN

/// 单例模式，负责管理整个 app 的音乐播放
@interface MusicPlayerCenter : NSObject

//模型
@property (nonatomic, strong)MusicModel *model;

//播放器
@property (nonatomic, retain)AVAudioPlayer *player;

///  播放状态（播放/暂停）
@property (nonatomic, assign, getter=isPlaying)BOOL playing;

//播放时间计时器
@property (assign, nonatomic)NSTimer *progressTimer;

//单例方法
+ (instancetype)defaultCenter;


@end

NS_ASSUME_NONNULL_END
