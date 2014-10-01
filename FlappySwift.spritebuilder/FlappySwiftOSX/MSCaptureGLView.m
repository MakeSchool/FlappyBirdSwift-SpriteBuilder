//
//  MSCaptureGLView.m
//  FlappySwift
//
//  Created by Gerald Monaco on 10/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MSCaptureGLView.h"

@implementation MSCaptureGLView {
    NSMutableArray *buffers;
    NSTask        *encoder;
    CGSize         size;
    NSFileHandle  *file;
    int            i;
    dispatch_queue_t queue;
    NSFileHandle     *stdout;
}

- (void)awakeFromNib
{
    stdout = [NSFileHandle fileHandleWithStandardOutput];
    queue = dispatch_queue_create("com.ms.render", NULL);
    buffers = [[NSMutableArray alloc] initWithCapacity:2];
    
    NSArray *arguments = [[NSProcessInfo processInfo] arguments];
    
    size = [self convertRectToBacking:self.bounds].size;
    for (int j = 0; j < 2; ++j) {
        [buffers addObject:[NSMutableData dataWithLength:size.width*size.height*3]];
    }
    
    NSFileHandle *stdin = [NSFileHandle fileHandleWithStandardInput];
    stdin.readabilityHandler = ^(NSFileHandle *file) {
        NSError *error = nil;
        NSDictionary *obj = [NSJSONSerialization JSONObjectWithData:file.availableData options:0 error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([obj objectForKey:@"start"] != nil) {
                [[CCDirector sharedDirector] resume];
            }
            else if ([obj objectForKey:@"down"] != nil) {
                NSDictionary *props = (NSDictionary *)[obj objectForKey:@"down"];
                
                [[CCDirector sharedDirector].responderManager mouseDown:[NSEvent mouseEventWithType:NSLeftMouseDown location:CGPointMake([[props valueForKey:@"x"] integerValue], [[props valueForKey:@"y"] integerValue]) modifierFlags:256 timestamp:0 windowNumber:0 context:nil eventNumber:nil clickCount:0 pressure:0]];
            }
            else if ([obj objectForKey:@"up"]) {
                NSDictionary *props = (NSDictionary *)[obj objectForKey:@"up"];
                
                [[CCDirector sharedDirector].responderManager mouseDown:[NSEvent mouseEventWithType:NSLeftMouseUp location:CGPointMake([[props valueForKey:@"x"] integerValue], [[props valueForKey:@"y"] integerValue]) modifierFlags:256 timestamp:0 windowNumber:0 context:nil eventNumber:nil clickCount:0 pressure:0]];
            }
        });
    };
}

-(void) unlockOpenGLContext
{
    [super unlockOpenGLContext];
    
    NSMutableData *buffer = [buffers lastObject];
    if (!buffer)
        return;
    
    [buffers removeLastObject];
    
    glReadBuffer(GL_BACK);
    glReadPixels(0, 0, size.width, size.height, GL_RGB, GL_UNSIGNED_BYTE, [buffer mutableBytes]);
    
    dispatch_async(queue, ^{
        @try {
            unsigned char* planes[1];
            planes[0] = [buffer mutableBytes];
            
            NSBitmapImageRep *representation = [[NSBitmapImageRep alloc] initWithBitmapDataPlanes:planes
                                                                                       pixelsWide:size.width
                                                                                       pixelsHigh:size.height
                                                                                    bitsPerSample:8
                                                                                  samplesPerPixel:3
                                                                                         hasAlpha:NO
                                                                                         isPlanar:NO
                                                                                   colorSpaceName:NSDeviceRGBColorSpace
                                                                                      bytesPerRow:(size.width * 3)
                                                                                     bitsPerPixel:24];
            
            NSImage* image = [[NSImage alloc] initWithSize:size];
            [image setFlipped:YES];
            [image lockFocus];
            [representation drawInRect:NSMakeRect(0,0,size.width,size.height)];
            [image unlockFocus];
            
            NSData *imageData = [image TIFFRepresentation];
            NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
            NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.0] forKey:NSImageCompressionFactor];
            imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
            
            unsigned long size = [imageData length];
            [stdout writeData:[NSData dataWithBytes:&size length:sizeof(size)]];
            [stdout writeData:imageData];
        }
        @catch (NSException *exception) {
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [buffers addObject:buffer];
        });
    });
}

@end
