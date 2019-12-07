//
//  TYSMGLBlankView.m
//  OpenGLES
//
//  Created by jele lam on 8/12/2019.
//  Copyright © 2019 CookiesJ. All rights reserved.
//

#import "TYSMGLBlankView.h"
#import <OpenGLES/ES2/gl.h>

@interface TYSMGLBlankView ()
@property (nonatomic, strong) EAGLContext *glContext;
@end

@implementation TYSMGLBlankView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        // 创建 CAEAGLLayer
        CAEAGLLayer *glLayer = (CAEAGLLayer *)self.layer;
        glLayer.drawableProperties = @{
            kEAGLDrawablePropertyRetainedBacking    : @(YES),
            kEAGLDrawablePropertyColorFormat        : kEAGLColorFormatRGBA8
            
        };
        
        // 分配一个 2.0 的 GLES 上下文
        self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        // 并使其成为当前上下文
        [EAGLContext setCurrentContext:self.glContext];
        
        // 配置帧缓存
        GLuint frameBuffer;
        glGenFramebuffers(1, &frameBuffer);
        glBindFramebuffer(GL_FRAMEBUFFER, frameBuffer);
        
        // 配置渲染缓存
        GLuint renderBuffer;
        glGenRenderbuffers(1, &renderBuffer);
        glBindRenderbuffer(GL_RENDERBUFFER, renderBuffer);
        
        // 关联当前渲染上下文和渲染窗口
        [self.glContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:(CAEAGLLayer *)self.layer];
        
        // 将渲染缓存的内容装载到帧缓存对象中
        glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, renderBuffer);
        
        
        // 测试帧缓冲区的完整性。仅当帧缓冲区的配置更改时才需要执行此测试。
        GLenum status = glCheckFramebufferStatus(GL_FRAMEBUFFER);
        NSAssert1(status == GL_FRAMEBUFFER_COMPLETE, @"无法制作完整的帧缓冲区对象 %x",status);
        //        if (status != GL_FRAMEBUFFER_COMPLETE) {
        //            NSLog(@"无法制作完整的帧缓冲区对象 %x",status);
        //        }
        
        glClearColor(0.2f, 0.3f, 0.3f, 1.f);
        glClear(GL_COLOR_BUFFER_BIT);
        
        [self.glContext presentRenderbuffer:GL_RENDERBUFFER];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - Layer

+ (Class)layerClass {
    return [CAEAGLLayer class];
}

@end

