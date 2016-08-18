//
//  UIImage+Extension.h


#import <UIKit/UIKit.h>

@class ALAsset;
@interface UIImage(Extension)

+ (instancetype)circleImageWithImage:(UIImage *)oldImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  缩放图片
 *
 *  @param image 需要缩放的原始图片
 *  @param size  缩放后的图片尺寸
 *
 *  @return 缩放后的图片
 */
+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;
/**
 *  缩放图片
 *
 *  @param size 缩放后的图片尺寸
 *
 *  @return 缩放后的图片
 */
- (UIImage *)scaleToSize:(CGSize)size;
/**
 *  给图片添加环形边框
 *
 *  @param name        图片名称
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 *
 *  @return 加了边框的图片
 */
+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  下载网络图片，并创建缓存
 *
 *  @param url     图片url
 *  @param success 成功
 *  @param failure 失败
 */
+ (void)loadWebImageWithURL:(NSURL *)url success:(void (^)(UIImage *image))success failure:(void (^)(NSError *error))failure;
+ (void)loadWebImageWithURL:(NSURL *)url successWithImage:(void (^)(UIImage *image, NSURL *url))success failure:(void (^)(NSError *error))failure;
/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;



+ (UIImage *)fixOrientation:(UIImage *)aImage;

- (UIImage *)fixOrientation;
+ (void)getThumbnailImageWithUrl:(NSURL*)url result:(void(^)(UIImage*image))result;
+ (void)getImageWithUrl:(NSURL*)url result:(void(^)(UIImage*image))result;
+ (UIImage *)getImageWithAsset:(ALAsset*)asset;
/**
 *  @author Sail
 *
 *  @brief 裁剪图片
 *
 *  @param rect 裁剪区域
 *
 *  @return 裁剪之后的图片
 */
- (UIImage *)cropImageInRect:(CGRect)rect;
/**
 *  @author Sail
 *
 *  @brief 裁剪成正方形，已图片中心点为准
 *
 *  @return 
 */
- (UIImage *)cropImageToSquare;
@end
