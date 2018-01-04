
#import <UIKit/UIKit.h>

@interface UIView (Extension)
/**
 *  快速设置控件的位置
 */
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

/**
 *  快速根据xib创建View
 */
+ (instancetype)viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)intersectsWithView:(UIView *)view;

@end
