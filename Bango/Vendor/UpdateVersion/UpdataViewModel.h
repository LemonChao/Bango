//
//  UpdataViewModel.h
//  Bango
//
//  Created by zchao on 2019/4/22.
//  Copyright © 2019 zchao. All rights reserved.
//

#import "ZCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface ZCUpdateModel : ZCBaseModel <NSCopying>

@property(nonatomic, copy) NSString *aid;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *ver_no;
@property(nonatomic, copy) NSString *ver_nod;
@property(nonatomic, copy) NSString *type;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *force_update;
@property(nonatomic, copy) NSString *remark;
@property(nonatomic, copy) NSString *createdate;
@property(nonatomic, copy) NSString *edit_time;
@property(nonatomic, copy) NSString *is_update;

@end


@interface UpdataViewModel : ZCBaseViewModel

@property(nonatomic, strong) RACCommand *updateCmd;

@property(nonatomic, strong) ZCUpdateModel *model;

@end



NS_ASSUME_NONNULL_END
