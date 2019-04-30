//
//  UIScrollView+MJRefreshExtension.m
//  THYG
//
//  Created by Mac on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "UIScrollView+MJRefreshExtension.h"
#import <objc/runtime.h>

@interface UIScrollView ()

@property (nonatomic, strong) NSNumber *pageIndex;

@property (nonatomic, weak) id <YYRefreshExtensionDelegate> reDelegate;

@end

@implementation UIScrollView (MJRefreshExtension)

- (void)addHeaderWithHeaderClass:(NSString *)headerClassName beginRefresh:(BOOL)beginRefresh delegate:(id<YYRefreshExtensionDelegate>)delegate animation:(BOOL)animation {
    
    __weak typeof(self) weakSelf = self;
    
    self.reDelegate = delegate;
    
    if (headerClassName == nil || [headerClassName isEqualToString:@""]) {
        
        MJRefreshNormalHeader * header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            __strong typeof(self) strongSelf = weakSelf;
            
            if([strongSelf.reDelegate respondsToSelector:@selector(onRefreshing:)]) {
                [strongSelf.reDelegate performSelector:@selector(onRefreshing:) withObject:self];
            }
        }];
        header.mj_h = 70.0;
        self.mj_header = header;
        
    } else {
        Class headerClass = NSClassFromString(headerClassName);
        MJRefreshHeader *header =(MJRefreshHeader *)[headerClass headerWithRefreshingBlock:^{
            __strong typeof(self) strongSelf = weakSelf;
            if([strongSelf.reDelegate respondsToSelector:@selector(onRefreshing:)])
                [strongSelf.reDelegate performSelector:@selector(onRefreshing:) withObject:self];
        }];
        self.mj_header =  header;
    }
    
    if (beginRefresh && animation) {
        //有动画的刷新
        [self beginHeaderRefresh];
        
    } else if (beginRefresh && !animation){
        //刷新，但是没有动画
        [self.mj_header executeRefreshingCallback];
    }
}

- (void)addFooterWithFooterClass:(NSString *)footerClassName automaticallyRefresh:(BOOL)automaticallyRefresh delegate:(id<YYRefreshExtensionDelegate>)delegate {
    
    __weak typeof(self) weakSelf = self;
    self.reDelegate = delegate;
    if (footerClassName == nil || [footerClassName isEqualToString:@""]) {
        if (automaticallyRefresh) {
            MJRefreshAutoNormalFooter * footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
                __strong typeof(self) strongSelf = weakSelf;
                if([strongSelf.reDelegate respondsToSelector:@selector(onLoadingMoreData:pageNum:)])
                    [strongSelf.reDelegate performSelector:@selector(onLoadingMoreData:pageNum:) withObject:self withObject:self.pageIndex];
            }];
            footer.automaticallyRefresh = automaticallyRefresh;
            footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
            footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
            [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
            [footer setTitle:@"无更多数据~" forState:MJRefreshStateNoMoreData];
            self.mj_footer = footer;
            
        } else {
            MJRefreshBackNormalFooter * footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                __strong typeof(self) strongSelf = weakSelf;
                if([strongSelf.reDelegate respondsToSelector:@selector(onLoadingMoreData:pageNum:)]) {
                    [strongSelf.reDelegate performSelector:@selector(onLoadingMoreData:pageNum:) withObject:self withObject:self.pageIndex];
                }
            }];
            
            footer.stateLabel.font = [UIFont systemFontOfSize:13.0];
            footer.stateLabel.textColor = [UIColor colorWithWhite:0.400 alpha:1.000];
            [footer setTitle:@"加载中…" forState:MJRefreshStateRefreshing];
            [footer setTitle:@"这是我的底线啦~" forState:MJRefreshStateNoMoreData];
            
            self.mj_footer = footer;
        }
        
    } else {
        Class headerClass = NSClassFromString(footerClassName);
        
        if (automaticallyRefresh) {
            MJRefreshAutoFooter *footer =(MJRefreshAutoFooter *)[headerClass footerWithRefreshingBlock:^{
                __strong typeof(self) strongSelf = weakSelf;
                if([strongSelf.reDelegate respondsToSelector:@selector(onLoadingMoreData:pageNum:)])
                    [strongSelf.reDelegate performSelector:@selector(onLoadingMoreData:pageNum:) withObject:self withObject:self.pageIndex];
                
            }];
            footer.automaticallyRefresh = automaticallyRefresh;
            self.mj_footer = footer;
            
        } else {
            MJRefreshFooter *footer =(MJRefreshFooter *)[headerClass footerWithRefreshingBlock:^{
                __strong typeof(self) strongSelf = weakSelf;
                if([strongSelf.reDelegate respondsToSelector:@selector(onLoadingMoreData:pageNum:)])
                    [strongSelf.reDelegate performSelector:@selector(onLoadingMoreData:pageNum:) withObject:self withObject:self.pageIndex];
                
            }];
            self.mj_footer = footer;
        }
    }
    
}

#pragma mark - action
- (void)beginHeaderRefresh {
    [self resetPageNum];
    [self.mj_header beginRefreshing];
}

- (void)beginFooterRefresh {
    [self.mj_footer beginRefreshing];
}

- (void)endHeaderRefresh {
    [self.mj_header endRefreshing];
    [self resetNoMoreData];
}

- (void)endFooterRefresh {
    [self.mj_footer endRefreshing];
}

- (void)endHeaderRefreshWithChangePageIndex:(BOOL)change {
    [self resetPageNum];
    if (change) {
        self.pageIndex = @(self.pageIndex.integerValue+1);
    }
    [self endHeaderRefresh];
}

- (void)endFooterRefreshWithChangePageIndex:(BOOL)change {
    if (change) {
        self.pageIndex = @(self.pageIndex.integerValue+1);
    }
    [self endFooterRefresh];
}

- (void)noMoreData {
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)resetNoMoreData {
    [self.mj_footer resetNoMoreData];
}

- (void)removeHeaderRefresh {
    self.mj_header = nil;
}

- (void)removeFooterRefresh {
    self.mj_footer = nil;
}

- (void)resetPageNum {
    self.pageIndex = @(1);
}

#pragma mark - sett && gett
static void *pagaIndexKey = &pagaIndexKey;
- (NSNumber *)pageIndex {
    return objc_getAssociatedObject(self, &pagaIndexKey);
}

- (void)setPageIndex:(NSNumber *)pageIndex {
    objc_setAssociatedObject(self, &pagaIndexKey, pageIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static void *reDelegateKey = &reDelegateKey;
- (void)setReDelegate:(id<YYRefreshExtensionDelegate>)reDelegate {
    objc_setAssociatedObject(self, &reDelegateKey, reDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<YYRefreshExtensionDelegate>)reDelegate {
    return objc_getAssociatedObject(self, &reDelegateKey);
}

@end
