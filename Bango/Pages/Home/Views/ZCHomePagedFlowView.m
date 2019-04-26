//
//  ZCHomePagedFlowView.m
//  Bango
//
//  Created by zchao on 2019/4/25.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCHomePagedFlowView.h"
#import "NewPagedFlowView.h"

@interface ZCHomePagedFlowView ()<NewPagedFlowViewDelegate,NewPagedFlowViewDataSource>
@property(nonatomic, strong) NewPagedFlowView *pageFlowView;
/**
 *  图片数组
 */
@property (nonatomic, strong) NSMutableArray *imageArray;

@end

@implementation ZCHomePagedFlowView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
//        self.imageArray = [NSMutableArray array];
//        for (int index = 0; index < 3; index++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Yosemite%02d",index]];
//            [self.imageArray addObject:image];
//        }

        [self addSubview:self.pageFlowView];
    }
    return self;
}


#pragma mark NewPagedFlowView Delegate

- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    return self.lunbos.count;
}

- (PGIndexBannerSubiew *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index {
    PGIndexBannerSubiew *bannerView = [flowView dequeueReusableCell];
    if (!bannerView) {
        bannerView = [[PGIndexBannerSubiew alloc] init];
        bannerView.tag = index;
        bannerView.layer.cornerRadius = 4.f;
        bannerView.layer.masksToBounds = YES;
    }
    
    ZCHomeAdvModel *model = self.lunbos[index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.adv_image]];
    return bannerView;
}

- (void)didSelectCell:(PGIndexBannerSubiew *)subView withSubViewIndex:(NSInteger)subIndex {
    ZCHomeAdvModel *model = self.lunbos[subIndex];

    ZCWebViewController *webView = [[ZCWebViewController alloc] init];
    webView.urlString = model.adv_url;
    [[self viewController].navigationController pushViewController:webView animated:YES];
}


#pragma mark - setter && getter

- (void)setLunbos:(NSArray<__kindof ZCHomeAdvModel *> *)lunbos {
    if (_lunbos == lunbos) return;
    
    _lunbos = lunbos.copy;
    [self.pageFlowView reloadData];
}

- (NewPagedFlowView *)pageFlowView {
    if (!_pageFlowView) {
        _pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, WidthRatio(10), self.frame.size.width, self.frame.size.height-WidthRatio(20))];
        _pageFlowView.delegate = self;
        _pageFlowView.dataSource = self;
        _pageFlowView.minimumPageAlpha = 0.1;
        _pageFlowView.isCarousel = YES;
        _pageFlowView.orientation = NewPagedFlowViewOrientationHorizontal;
        _pageFlowView.isOpenAutoScroll = YES;
        _pageFlowView.leftRightMargin = WidthRatio(16);
//        _pageFlowView.topBottomMargin = 20;
    }
    return _pageFlowView;
}


@end
