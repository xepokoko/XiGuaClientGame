//
//  MusicModel.h
//  XiGuaMusicPlayer
//
//  Created by little_Fking_cute on 2022/4/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MusicModel : NSObject

//歌曲名字
@property (nonatomic, strong)NSString *songName;
//歌手名字
@property (nonatomic, strong)NSString *singerName;
//专辑封面
@property (nonatomic, strong)NSString *coverImg;
//是否收藏
@property (assign, getter = isFavorite)Boolean favorite;

- (instancetype) initWithDict:(NSDictionary *)dict;

+ (instancetype) musicModelWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
