//
//  Copyright (c) 2017 Open Whisper Systems. All rights reserved.
//

#import "MIMETypeUtil.h"
#if TARGET_OS_IPHONE
#import "UIImage+contentTypes.h"
#import <MobileCoreServices/MobileCoreServices.h>
#else
#import <CoreServices/CoreServices.h>
#endif

NSString *const OWSMimeTypeApplicationOctetStream = @"application/octet-stream";
NSString *const OWSMimeTypeImagePng = @"image/png";
NSString *const OWSMimeTypeOversizeTextMessage = @"text/x-signal-plain";
NSString *const OWSMimeTypeUnknownForTests = @"unknown/mimetype";

@implementation MIMETypeUtil

+ (NSDictionary *)supportedVideoMIMETypesToExtensionTypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"video/3gpp" : @"3gp",
            @"video/3gpp2" : @"3g2",
            @"video/mp4" : @"mp4",
            @"video/quicktime" : @"mov",
            @"video/x-m4v" : @"m4v"
        };
    });
    return result;
}

+ (NSDictionary *)supportedAudioMIMETypesToExtensionTypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"audio/aac" : @"m4a",
            @"audio/x-m4p" : @"m4p",
            @"audio/x-m4b" : @"m4b",
            @"audio/x-m4a" : @"m4a",
            @"audio/wav" : @"wav",
            @"audio/x-wav" : @"wav",
            @"audio/x-mpeg" : @"mp3",
            @"audio/mpeg" : @"mp3",
            @"audio/mp4" : @"mp4",
            @"audio/mp3" : @"mp3",
            @"audio/mpeg3" : @"mp3",
            @"audio/x-mp3" : @"mp3",
            @"audio/x-mpeg3" : @"mp3",
            @"audio/amr" : @"amr",
            @"audio/aiff" : @"aiff",
            @"audio/x-aiff" : @"aiff",
            @"audio/3gpp2" : @"3g2",
            @"audio/3gpp" : @"3gp"
        };
    });
    return result;
}

+ (NSDictionary *)supportedImageMIMETypesToExtensionTypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"image/jpeg" : @"jpeg",
            @"image/pjpeg" : @"jpeg",
            OWSMimeTypeImagePng : @"png",
            @"image/tiff" : @"tif",
            @"image/x-tiff" : @"tif",
            @"image/bmp" : @"bmp",
            @"image/x-windows-bmp" : @"bmp"
        };
    });
    return result;
}

+ (NSDictionary *)supportedAnimatedMIMETypesToExtensionTypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"image/gif" : @"gif",
        };
    });
    return result;
}

+ (NSDictionary *)supportedBinaryDataMIMETypesToExtensionTypes
{
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            OWSMimeTypeApplicationOctetStream : @"dat",
        };
    });
    return result;
}

+ (NSDictionary *)supportedVideoExtensionTypesToMIMETypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"3gp" : @"video/3gpp",
            @"3gpp" : @"video/3gpp",
            @"3gp2" : @"video/3gpp2",
            @"3gpp2" : @"video/3gpp2",
            @"mp4" : @"video/mp4",
            @"mov" : @"video/quicktime",
            @"mqv" : @"video/quicktime",
            @"m4v" : @"video/x-m4v"
        };
    });
    return result;
}

+ (NSDictionary *)supportedAudioExtensionTypesToMIMETypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"3gp" : @"audio/3gpp",
            @"3gpp" : @"@audio/3gpp",
            @"3g2" : @"audio/3gpp2",
            @"3gp2" : @"audio/3gpp2",
            @"aiff" : @"audio/aiff",
            @"aif" : @"audio/aiff",
            @"aifc" : @"audio/aiff",
            @"cdda" : @"audio/aiff",
            @"amr" : @"audio/amr",
            @"mp3" : @"audio/mp3",
            @"swa" : @"audio/mp3",
            @"mp4" : @"audio/mp4",
            @"mpeg" : @"audio/mpeg",
            @"mpg" : @"audio/mpeg",
            @"wav" : @"audio/wav",
            @"bwf" : @"audio/wav",
            @"m4a" : @"audio/x-m4a",
            @"m4b" : @"audio/x-m4b",
            @"m4p" : @"audio/x-m4p"
        };
    });
    return result;
}

+ (NSDictionary *)supportedImageExtensionTypesToMIMETypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"png" : OWSMimeTypeImagePng,
            @"x-png" : OWSMimeTypeImagePng,
            @"jfif" : @"image/jpeg",
            @"jfif" : @"image/pjpeg",
            @"jfif-tbnl" : @"image/jpeg",
            @"jpe" : @"image/jpeg",
            @"jpe" : @"image/pjpeg",
            @"jpeg" : @"image/jpeg",
            @"jpg" : @"image/jpeg",
            @"tif" : @"image/tiff",
            @"tiff" : @"image/tiff"
        };
    });
    return result;
}

+ (NSDictionary *)supportedAnimatedExtensionTypesToMIMETypes {
    static NSDictionary *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = @{
            @"gif" : @"image/gif",
        };
    });
    return result;
}

+ (BOOL)isSupportedVideoMIMEType:(NSString *)contentType {
    return [[self supportedVideoMIMETypesToExtensionTypes] objectForKey:contentType] != nil;
}

+ (BOOL)isSupportedAudioMIMEType:(NSString *)contentType {
    return [[self supportedAudioMIMETypesToExtensionTypes] objectForKey:contentType] != nil;
}

+ (BOOL)isSupportedImageMIMEType:(NSString *)contentType {
    return [[self supportedImageMIMETypesToExtensionTypes] objectForKey:contentType] != nil;
}

+ (BOOL)isSupportedAnimatedMIMEType:(NSString *)contentType {
    return [[self supportedAnimatedMIMETypesToExtensionTypes] objectForKey:contentType] != nil;
}

+ (BOOL)isSupportedBinaryDataMIMEType:(NSString *)contentType
{
    return [[self supportedBinaryDataMIMETypesToExtensionTypes] objectForKey:contentType] != nil;
}

+ (BOOL)isSupportedVideoFile:(NSString *)filePath {
    return [[self supportedVideoExtensionTypesToMIMETypes] objectForKey:[filePath pathExtension]] != nil;
}

+ (BOOL)isSupportedAudioFile:(NSString *)filePath {
    return [[self supportedAudioExtensionTypesToMIMETypes] objectForKey:[filePath pathExtension]] != nil;
}

+ (BOOL)isSupportedImageFile:(NSString *)filePath {
    return [[self supportedImageExtensionTypesToMIMETypes] objectForKey:[filePath pathExtension]] != nil;
}

+ (BOOL)isSupportedAnimatedFile:(NSString *)filePath {
    return [[self supportedAnimatedExtensionTypesToMIMETypes] objectForKey:[filePath pathExtension]] != nil;
}

+ (NSString *)getSupportedExtensionFromVideoMIMEType:(NSString *)supportedMIMEType {
    return [[self supportedVideoMIMETypesToExtensionTypes] objectForKey:supportedMIMEType];
}

+ (NSString *)getSupportedExtensionFromAudioMIMEType:(NSString *)supportedMIMEType {
    return [[self supportedAudioMIMETypesToExtensionTypes] objectForKey:supportedMIMEType];
}

+ (NSString *)getSupportedExtensionFromImageMIMEType:(NSString *)supportedMIMEType {
    return [[self supportedImageMIMETypesToExtensionTypes] objectForKey:supportedMIMEType];
}

+ (NSString *)getSupportedExtensionFromAnimatedMIMEType:(NSString *)supportedMIMEType {
    return [[self supportedAnimatedMIMETypesToExtensionTypes] objectForKey:supportedMIMEType];
}

+ (NSString *)getSupportedExtensionFromBinaryDataMIMEType:(NSString *)supportedMIMEType
{
    return [[self supportedBinaryDataMIMETypesToExtensionTypes] objectForKey:supportedMIMEType];
}

+ (NSString *)getSupportedMIMETypeFromVideoFile:(NSString *)supportedVideoFile {
    return [[self supportedVideoExtensionTypesToMIMETypes] objectForKey:[supportedVideoFile pathExtension]];
}

+ (NSString *)getSupportedMIMETypeFromAudioFile:(NSString *)supportedAudioFile {
    return [[self supportedAudioExtensionTypesToMIMETypes] objectForKey:[supportedAudioFile pathExtension]];
}

+ (NSString *)getSupportedMIMETypeFromImageFile:(NSString *)supportedImageFile {
    return [[self supportedImageExtensionTypesToMIMETypes] objectForKey:[supportedImageFile pathExtension]];
}

+ (NSString *)getSupportedMIMETypeFromAnimatedFile:(NSString *)supportedAnimatedFile {
    return [[self supportedAnimatedExtensionTypesToMIMETypes] objectForKey:[supportedAnimatedFile pathExtension]];
}

#pragma mark full attachment utilities
+ (BOOL)isAnimated:(NSString *)contentType {
    return [MIMETypeUtil isSupportedAnimatedMIMEType:contentType];
}

+ (BOOL)isBinaryData:(NSString *)contentType
{
    return [MIMETypeUtil isSupportedBinaryDataMIMEType:contentType];
}

+ (BOOL)isImage:(NSString *)contentType {
    return [MIMETypeUtil isSupportedImageMIMEType:contentType];
}

+ (BOOL)isVideo:(NSString *)contentType {
    return [MIMETypeUtil isSupportedVideoMIMEType:contentType];
}

+ (BOOL)isAudio:(NSString *)contentType {
    return [MIMETypeUtil isSupportedAudioMIMEType:contentType];
}

+ (NSString *)filePathForAttachment:(NSString *)uniqueId
                         ofMIMEType:(NSString *)contentType
                           inFolder:(NSString *)folder {
    if ([self isVideo:contentType]) {
        return [MIMETypeUtil filePathForVideo:uniqueId ofMIMEType:contentType inFolder:folder];
    } else if ([self isAudio:contentType]) {
        return [MIMETypeUtil filePathForAudio:uniqueId ofMIMEType:contentType inFolder:folder];
    } else if ([self isImage:contentType]) {
        return [MIMETypeUtil filePathForImage:uniqueId ofMIMEType:contentType inFolder:folder];
    } else if ([self isAnimated:contentType]) {
        return [MIMETypeUtil filePathForAnimated:uniqueId ofMIMEType:contentType inFolder:folder];
    } else if ([self isBinaryData:contentType]) {
        return [MIMETypeUtil filePathForBinaryData:uniqueId ofMIMEType:contentType inFolder:folder];
    } else if ([contentType isEqualToString:OWSMimeTypeOversizeTextMessage]) {
        // We need to use a ".txt" file extension since this file extension is used
        // by UIActivityViewController to determine which kinds of sharing are
        // appropriate for this text.
        // be used outside the app.
        return [self filePathForData:uniqueId withFileExtension:@"txt" inFolder:folder];
    } else if ([contentType isEqualToString:OWSMimeTypeUnknownForTests]) {
        // This file extension is arbitrary - it should never be exposed to the user or
        // be used outside the app.
        return [self filePathForData:uniqueId withFileExtension:@"unknown" inFolder:folder];
    }

    NSString *fileExtension = [self fileExtensionForMIMEType:contentType];
    if (fileExtension) {
        return [self filePathForData:uniqueId withFileExtension:fileExtension inFolder:folder];
    }

    DDLogError(@"Got asked for path of file %@ which is unsupported", contentType);
    return nil;
}

+ (NSURL *)simLinkCorrectExtensionOfFile:(NSURL *)mediaURL ofMIMEType:(NSString *)contentType {
    if ([self isAudio:contentType]) {
        // Audio files in current framework require changing to have extension for player
        return [self changeFile:mediaURL
                toHaveExtension:[[self supportedAudioMIMETypesToExtensionTypes] objectForKey:contentType]];
    }
    return mediaURL;
}

+ (NSURL *)changeFile:(NSURL *)originalFile toHaveExtension:(NSString *)extension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *newPath =
        [originalFile.URLByDeletingPathExtension.absoluteString stringByAppendingPathExtension:extension];
    if (![fileManager fileExistsAtPath:newPath]) {
        NSError *error = nil;
        [fileManager createSymbolicLinkAtPath:newPath withDestinationPath:[originalFile path] error:&error];
        return [NSURL URLWithString:newPath];
    }
    return originalFile;
}

+ (NSString *)filePathForImage:(NSString *)uniqueId ofMIMEType:(NSString *)contentType inFolder:(NSString *)folder {
    return [[folder stringByAppendingFormat:@"/%@", uniqueId]
        stringByAppendingPathExtension:[self getSupportedExtensionFromImageMIMEType:contentType]];
}

+ (NSString *)filePathForVideo:(NSString *)uniqueId ofMIMEType:(NSString *)contentType inFolder:(NSString *)folder {
    return [[folder stringByAppendingFormat:@"/%@", uniqueId]
        stringByAppendingPathExtension:[self getSupportedExtensionFromVideoMIMEType:contentType]];
}

+ (NSString *)filePathForAudio:(NSString *)uniqueId ofMIMEType:(NSString *)contentType inFolder:(NSString *)folder {
    return [[folder stringByAppendingFormat:@"/%@", uniqueId]
        stringByAppendingPathExtension:[self getSupportedExtensionFromAudioMIMEType:contentType]];
}

+ (NSString *)filePathForAnimated:(NSString *)uniqueId ofMIMEType:(NSString *)contentType inFolder:(NSString *)folder {
    return [[folder stringByAppendingFormat:@"/%@", uniqueId]
        stringByAppendingPathExtension:[self getSupportedExtensionFromAnimatedMIMEType:contentType]];
}

+ (NSString *)filePathForBinaryData:(NSString *)uniqueId ofMIMEType:(NSString *)contentType inFolder:(NSString *)folder
{
    return [[folder stringByAppendingFormat:@"/%@", uniqueId]
        stringByAppendingPathExtension:[self getSupportedExtensionFromBinaryDataMIMEType:contentType]];
}

+ (NSString *)filePathForData:(NSString *)uniqueId
            withFileExtension:(NSString *)fileExtension
                     inFolder:(NSString *)folder
{
    return [[folder stringByAppendingFormat:@"/%@", uniqueId] stringByAppendingPathExtension:fileExtension];
}

#if TARGET_OS_IPHONE

+ (NSString *)getSupportedImageMIMETypeFromImage:(UIImage *)image {
    return [image contentType];
}

+ (BOOL)getIsSupportedTypeFromImage:(UIImage *)image {
    return [image isSupportedImageType];
}

#endif

+ (NSString *)utiTypeForMIMEType:(NSString *)mimeType
{
    CFStringRef utiType
    = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, (__bridge CFStringRef)mimeType, NULL);
    return (__bridge_transfer NSString *)utiType;
}

+ (NSString *)fileExtensionForUTIType:(NSString *)utiType
{
    CFStringRef fileExtension
    = UTTypeCopyPreferredTagWithClass((__bridge CFStringRef) utiType, kUTTagClassFilenameExtension);
    return (__bridge_transfer NSString *)fileExtension;
}

+ (NSString *)fileExtensionForMIMEType:(NSString *)mimeType
{
    NSString *utiType = [self utiTypeForMIMEType:mimeType];
    if (!utiType) {
        return nil;
    }
    NSString *fileExtension = [self fileExtensionForUTIType:utiType];
    return fileExtension;
}

+ (NSSet<NSString *> *)utiTypesForMIMETypes:(NSArray *)mimeTypes
{
    NSMutableSet<NSString *> *result = [NSMutableSet new];
    for (NSString *mimeType in mimeTypes) {
        [result addObject:[self utiTypeForMIMEType:mimeType]];
    }
    return result;
}

+ (NSSet<NSString *> *)supportedVideoUTITypes
{
    OWSAssert([NSThread isMainThread]);
    static NSSet<NSString *> *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [self utiTypesForMIMETypes:[self supportedVideoMIMETypesToExtensionTypes].allKeys];
    });
    return result;
}

+ (NSSet<NSString *> *)supportedAudioUTITypes
{
    OWSAssert([NSThread isMainThread]);
    static NSSet<NSString *> *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [self utiTypesForMIMETypes:[self supportedAudioMIMETypesToExtensionTypes].allKeys];
    });
    return result;
}

+ (NSSet<NSString *> *)supportedImageUTITypes
{
    OWSAssert([NSThread isMainThread]);
    static NSSet<NSString *> *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [self utiTypesForMIMETypes:[self supportedImageMIMETypesToExtensionTypes].allKeys];
    });
    return result;
}

+ (NSSet<NSString *> *)supportedAnimatedImageUTITypes
{
    OWSAssert([NSThread isMainThread]);
    static NSSet<NSString *> *result = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        result = [self utiTypesForMIMETypes:[self supportedAnimatedMIMETypesToExtensionTypes].allKeys];
    });
    return result;
}

@end
