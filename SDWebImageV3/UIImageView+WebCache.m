/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImageView+WebCache.h"
#import "objc/runtime.h"

static char operationKey;
static char operationArrayKey;

@implementation UIImageView (WebCache)

- (void)setImageWithURLString:(NSString *)urlStr
{
    [self setImageWithURLString:urlStr placeholderImage:nil options:0 progress:nil completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr placeholderImage:(UIImage *)placeholder
{
    [self setImageWithURLString:urlStr placeholderImage:placeholder options:0 progress:nil completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr
             placeholderImage:(UIImage *)placeholder
                      options:(SDWebImageOptions)options
{
    [self setImageWithURLString:urlStr placeholderImage:placeholder options:options progress:nil completed:nil];
}

- (void)setImageWithURLString:(NSString *)urlStr completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURLString:urlStr placeholderImage:nil options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURLString:(NSString *)urlStr
             placeholderImage:(UIImage *)placeholder
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURLString:urlStr placeholderImage:placeholder options:0 progress:nil completed:completedBlock];
}

- (void)setImageWithURLString:(NSString *)urlStr
             placeholderImage:(UIImage *)placeholder
                      options:(SDWebImageOptions)options
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    [self setImageWithURLString:urlStr placeholderImage:placeholder options:options progress:nil completed:completedBlock];
}

- (void)setImageWithURLString:(NSString *)urlStr
             placeholderImage:(UIImage *)placeholder
                      options:(SDWebImageOptions)options
                     progress:(SDWebImageDownloaderProgressBlock)progressBlock
                    completed:(SDWebImageCompletedBlock)completedBlock
{
    NSURL  *URL = nil;
    if ([urlStr isKindOfClass:[NSString class]]) {
        URL = [NSURL URLWithString:urlStr];
    }

    [self setImageWithURL:URL
         placeholderImage:placeholder
                  options:options
                 progress:progressBlock
                completed:completedBlock];
}
- (void)setImageWithURL:(NSURL *)url
       placeholderImage:(UIImage *)placeholder
                options:(SDWebImageOptions)options
               progress:(SDWebImageDownloaderProgressBlock)progressBlock
              completed:(SDWebImageCompletedBlock)completedBlock
{
    [self cancelCurrentImageLoad];

    self.image = placeholder;
    
    if (url)
    {
        __weak UIImageView *wself = self;        
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if (!wself) return;
            void (^block)(void) = ^
            {
                __strong UIImageView *sself = wself;
                if (!sself) return;
                if (image)
                {
                    sself.image = image;
                    [sself setNeedsLayout];
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

- (void)setAnimationImagesWithURLs:(NSArray *)arrayOfURLs
{
    [self cancelCurrentArrayLoad];
    __weak UIImageView *wself = self;

    NSMutableArray *operationsArray = [[NSMutableArray alloc] init];

    for (NSURL *logoImageURL in arrayOfURLs)
    {
        id<SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:logoImageURL options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
        {
            if (!wself) return;
            void (^block)(void) = ^
            {
                __strong UIImageView *sself = wself;
                [sself stopAnimating];
                if (sself && image)
                {
                    NSMutableArray *currentImages = [[sself animationImages] mutableCopy];
                    if (!currentImages)
                    {
                        currentImages = [[NSMutableArray alloc] init];
                    }
                    [currentImages addObject:image];

                    sself.animationImages = currentImages;
                    [sself setNeedsLayout];
                }
                [sself startAnimating];
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
        [operationsArray addObject:operation];
    }

    objc_setAssociatedObject(self, &operationArrayKey, [NSArray arrayWithArray:operationsArray], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

- (void)cancelCurrentArrayLoad
{
    // Cancel in progress downloader from queue
    NSArray *operations = objc_getAssociatedObject(self, &operationArrayKey);
    for (id<SDWebImageOperation> operation in operations)
    {
        if (operation)
        {
            [operation cancel];
        }
    }
    objc_setAssociatedObject(self, &operationArrayKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetImage
{
    [self cancelCurrentImageLoad];
    self.image = nil;
}

@end
