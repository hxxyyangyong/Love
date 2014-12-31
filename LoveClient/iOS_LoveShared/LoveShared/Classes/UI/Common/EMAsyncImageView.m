//  EMAsyncImageView.m
//  Created by erwin on 11/05/12.

/*
 
 Copyright (c) 2012 eMaza Mobile. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining
 a copy of this software and associated documentation files (the
 "Software"), to deal in the Software without restriction, including
 without limitation the rights to use, copy, modify, merge, publish,
 distribute, sublicense, and/or sell copies of the Software, and to
 permit persons to whom the Software is furnished to do so, subject to
 the following conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
 LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
 OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
 WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */


#import "EMAsyncImageView.h"

@interface EMAsyncImageView()

@property (nonatomic, strong) NSURLConnection			*connection;

@property (nonatomic, strong) UIActivityIndicatorView	*spinner;
@property (nonatomic, strong) NSString					*filePath;

@property (nonatomic, assign) BOOL	isInResuableCell;

@end

@implementation EMAsyncImageView {
    
}

//@synthesize imageUrl, imageSize,imageType,imageCacheKey;
//@synthesize connection, data, spinner, filePath,isInResuableCell;


- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setup];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if (self = [super initWithCoder:aDecoder]) {
		[self setup];
	}
	return self;
}

- (void)setup {
    
	self.imageType = @"";
	self.imageSize = self.bounds.size;
	self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	_spinner.frame = self.frame;
	_spinner.center = self.center;
	_spinner.hidesWhenStopped = TRUE;
	
//	CALayer *layer = self.layer;
//	layer.cornerRadius = 10;
//	self.clipsToBounds = TRUE;
    _spinner.userInteractionEnabled = NO;
}



- (void)loadImageWithUrl:(NSString *)url andSize:(CGSize)size
{
    NSLog(@"图片请求地址  %@", url);
    [self.connection cancel];
    self.connection = nil;
	if (!url) {
		self.isInResuableCell = TRUE;
		[_connection cancel];
		_imageUrl = nil;
		self.filePath = nil;
		self.image = nil;
		return;
	}
    
	_imageUrl = url;
    _imageSize = size;
//    if (!_imageCache) {
//        _imageCache = [GLImageCache sharedCommonImageCache];
//    }
//    if ([self.imageCache hasDataForKey:[self imageCacheKey]]) {
//        self.data = [NSMutableData dataWithData:[self.imageCache getDataForkey:_imageCacheKey]];
//        self.image = [UIImage imageWithData:_data];
//		[self setNeedsLayout];
//        self.data = nil;
//    }else{
        [self downloadImage];
//    }
}

- (void)downloadImage {
	[self.superview addSubview:_spinner];
	[_spinner startAnimating];
	self.data = [NSMutableData data];
	NSURL *url = [NSURL URLWithString:_imageUrl];
	NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
	self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)theConnection	didReceiveData:(NSData *)incrementalData {
    if (!_data) self.data = [NSMutableData data];
    [_data appendData:incrementalData];
}

- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error {
//	NSString *url = theConnection.currentRequest.URL.absoluteString;
//	NSString *msg = [NSString stringWithFormat:@"Error:\n%@\n\nWith this url:\n%@", [error description], url];
//	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Image Download Error" message:msg delegate:self cancelButtonTitle:@"Bummer" otherButtonTitles:nil];
//	[alert show];
}

- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	[_spinner stopAnimating];
	self.connection = nil;
	
	if ([theConnection.currentRequest.URL.absoluteString isEqualToString:self.imageUrl]) {
		UIImage *image = [UIImage imageWithData:_data];
        if (image) {
            self.image = image;
            [self setNeedsLayout];
           // [self.imageCache addOrUpdateData:_data forKey:self.imageCacheKey];
            if (_imageDownLoadOverCallBack.target && [_imageDownLoadOverCallBack.target respondsToSelector:_imageDownLoadOverCallBack.action]) {
                [_imageDownLoadOverCallBack.target
                 performSelectorOnMainThread:_imageDownLoadOverCallBack.action
                 withObject:self.data waitUntilDone:YES];
            }
        }
	}
	self.data = nil;
}


- (NSString*)filePath {
    
	if (!_filePath) {
		//self.filePath = [self.imageCache.cachePath stringByAppendingPathComponent:self.imageCacheKey];
	}
	return _filePath;
}

- (void)dealloc {
    [_connection cancel];
}


- (NSString *)imageCacheKey
{
    NSString *retCachekey = nil;
//    [NSString stringWithFormat:@"%@_%d_%d%@%@",
//                                               [self.imageUrl md5Hash],
//                                               (int)self.imageSize.width,
//                                               (int)self.imageSize.height,
//                               (self.imageType.length > 0 ? @".":@""),self.imageType];
    return retCachekey;
}

+ (NSString *)imageCacheKeyWithImageId:(long long)imageId size:(CGSize)size imageType:(NSString *)imageType
{
//    NSString *before = [NSString stringWithFormat:@"%@?%@=%lld&picSize=%d", @"downloadFile", @"fileId", imageId, 0, nil];
//    NSString *retUrl  = [NSString urlcombineWithBefore:D_Login_BaseUrl after:before];
    
    NSString *retCachekey = nil;
//    [NSString stringWithFormat:@"%@_%d_%d%@%@",
//                             [retUrl md5Hash],
//                             (int)size.width,
//                             (int)size.height,
//                             (imageType.length > 0 ? @".": @""),
//                             imageType];
    return retCachekey;
}
@end
