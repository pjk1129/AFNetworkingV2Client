/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIButton+WebCache.h"
#import "objc/runtime.h"

static char operationKey;

@implementation UIButton (WebCache)

- (void)setImageWithURLString:(NSString *)urlStr forState:(UIControlState)state
{
    [self setImageWithURLString:urlStr forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr
                     forState:(UIControlState)state
             placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURLString:urlStr forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr
                     forState:(UIControlState)state
             placeholderImage:(UIImage *)placeholder
                      options:(SDWebImageOptions)options
{
    [self setImageWithURLString:urlStr forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr
                     forState:(UIControlState)state
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURLString:urlStr forState:state placeholderImage:nil options:0 completed:completedBlock];
}
- (void)setImageWithURLString:(NSString *)urlStr
                     forState:(UIControlState)state
             placeholderImage:(UIImage *)placeholder
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURLString:urlStr forState:state placeholderImage:placeholder options:0 completed:completedBlock];
}

- (void)setImageWithURLString:(NSString *)urlStr
                     forState:(UIControlState)state
             placeholderImage:(UIImage *)placeholder
                      options:(SDWebImageOptions)options
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    NSURL  *URL = nil;
    if ([urlStr isKindOfClass:[NSString class]]) {
        URL = [NSURL URLWithString:urlStr];
    }
    
    [self setImageWithURL:URL
                 forState:state
         placeholderImage:placeholder
                  options:options
                completed:completedBlock];

}

- (void)setImageWithURL:(NSURL *)url
               forState:(UIControlState)state
       placeholderImage:(UIImage *)placeholder
                options:(SDWebImageOptions)options
              completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];

    [self setImage:placeholder forState:state];

    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if (!wself) return;
            void (^block)(void) = ^
            {
                __strong UIButton *sself = wself;
                if (!sself) return;
                if (image)
                {
                    [sself setImage:image forState:state];
                }
                if (completedBlock && finished)
                {
                    completedBlock(image, error, cacheType);
                }
            };
            if ([NSThread isMainThread])
            {
                block();
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


#pragma mark -  Background Image API
- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
{
    [self setBackgroundImageWithURLString:urlStr forState:state placeholderImage:nil options:0 completed:nil];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
                       placeholderImage:(UIImage *)placeholder
{
    [self setBackgroundImageWithURLString:urlStr forState:state placeholderImage:placeholder options:0 completed:nil];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
                       placeholderImage:(UIImage *)placeholder
                                options:(SDWebImageOptions)options
{
    [self setBackgroundImageWithURLString:urlStr forState:state placeholderImage:placeholder options:options completed:nil];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
                              completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURLString:urlStr forState:state placeholderImage:nil options:0 completed:completedBlock];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
                       placeholderImage:(UIImage *)placeholder
                              completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURLString:urlStr
                                 forState:state
                         placeholderImage:placeholder
                                  options:0
                                completed:completedBlock];
}

- (void)setBackgroundImageWithURLString:(NSString *)urlStr
                               forState:(UIControlState)state
                       placeholderImage:(UIImage *)placeholder
                                options:(SDWebImageOptions)options
                              completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setBackgroundImageWithURL:[NSURL URLWithString:urlStr]
                           forState:state
                   placeholderImage:placeholder
                            options:options
                          completed:completedBlock];
}

- (void)setBackgroundImageWithURL:(NSURL *)url
                         forState:(UIControlState)state
                 placeholderImage:(UIImage *)placeholder
                          options:(SDWebImageOptions)options
                        completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];

    [self setBackgroundImage:placeholder forState:state];

    if (url)
    {
        __weak UIButton *wself = self;
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if (!wself) return;
            void (^block)(void) = ^
            {
                __strong UIButton *sself = wself;
                if (!sself) return;
                if (image)
                {
                    [sself setBackgroundImage:image forState:state];
                }
                if (completedBlock && finished)
                {
                    completedBlock(image, error, cacheType);
                }
            };
            if ([NSThread isMainThread])
            {
                block();
            }
            else
            {
                dispatch_sync(dispatch_get_main_queue(), block);
            }
        }];
        objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}


- (void)cancelCurrentImageLoad
{
    // Cancel in progress downloader from queue
    id<SDWebImageOperation> operation = objc_getAssociatedObject(self, &operationKey);
    if (operation)
    {
        [operation cancel];
        objc_setAssociatedObject(self, &operationKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (void)resetImage
{
    [self cancelCurrentImageLoad];
    [self setImage:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateNormal];

}


@end
