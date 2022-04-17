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

typedef enum MusicPlayMode {
    MusicPlayModeRepeat = 0,    // 顺序
    MusicPlayModeRepeatOne,     // 单曲循环
    MusicPlayModeShuffle        // 随机播放
} MusicPlayMode;

@protocol MusicPlayerCenterDelegate <NSObject>

/// 从 musicList 中选取下一首
- (void)playNextMusicWithPlayMode:(MusicPlayMode)playMode;
/// 选取上一首
- (void)playLastMusicWithPlayMode:(MusicPlayMode)playMode;

@optional
/// 更新喜欢的歌曲
- (void)updateLikeMusic:(MusicModel *)music;

@end


/// 单例模式，负责管理整个 app 的音乐播放
/// 各种按钮点击完通过 defaultCenter 获取完单例使用下面的方法
@interface MusicPlayerCenter : NSObject

/// 播放音乐
- (void)playMusic;

/// 播放或暂停
- (void)togglePlayPause;

/// 播放下一首
- (void)playNextMusic;

/// 播放上一首
- (void)playLastMusic;

/// 代理
/// 播放上一首、下一首歌需要去实现代理的对象中寻找歌曲
@property (nonatomic, weak)id<MusicPlayerCenterDelegate> delegate;


/// 模型
@property (nonatomic, strong)MusicModel *music;

/// 播放器
@property (nonatomic, retain)AVAudioPlayer *player;

/// 播放状态（播放/暂停）
@property (nonatomic, assign, getter=isPlaying)BOOL playing;

/// 播放模式（顺序/单曲循环/随机）
@property (nonatomic, assign)MusicPlayMode playMode;

/// 计时器（一秒钟更新一次播放进度）（可优化）
@property (assign, nonatomic)NSTimer *progressTimer;

/// 单例方法
+ (instancetype)defaultCenter;

@end

NS_ASSUME_NONNULL_END
