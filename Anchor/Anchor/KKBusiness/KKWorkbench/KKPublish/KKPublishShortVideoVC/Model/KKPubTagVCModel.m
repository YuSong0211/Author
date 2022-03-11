//
//  KKPubTagVCModel.m
//  KK
//
//  Created by ProgramMa on 2021/7/13.
//

#import "KKPubTagVCModel.h"
#import "AppVersionMgr.h"
#define NoMemberVideo 10
#define NoMemberComment 10
#define NoMemberDown 3

#define Member_1Video 99999
#define Member_1Comment 99999
#define Member_1Down 10

#define Member_2Video 99999
#define Member_2Comment 99999
#define Member_2Down 99999

@implementation KKAppConfiguration

//问题类型数组
+(NSMutableArray< KKAppConfiguration*> *)convertModelAppConfigurationList:(appvapiEnterResponse * _Nonnull)HostList{
    
    NSMutableArray<KKAppConfiguration*>*newList = [[NSMutableArray alloc] init];
    for(appvapiAppConfiguration* item in HostList.config.appConfigurationsArray){
        KKAppConfiguration* av = [KKAppConfiguration initWithAppConfigurationMessage:item];
        [newList addObject:av];
    }
    return newList;
}
+(KKAppConfiguration*)initWithAppConfigurationMessage:(appvapiAppConfiguration *)item{
    
    KKAppConfiguration* model = [[KKAppConfiguration alloc] init];
    model.configurationItemKey = item.configurationItemKey;
    model.configurationItemValue = item.configurationItemValue;
    return model;
}

-(void)convertModelAppConfigurationItem:(appvapiEnterResponse * _Nonnull)HostList{
    
    for(appvapiAppConfiguration* item in HostList.config.appConfigurationsArray){
        if ([item.configurationItemKey isEqualToString:@"enableServiceAccess"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableServiceAccess = false;
            }else{
                self.enableServiceAccess = true;
            }
        }
        if ([item.configurationItemKey isEqualToString:@"enableCommentAudit"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableCommentAudit = false;
            }else{
                self.enableCommentAudit = true;
            }
    
        }
        if ([item.configurationItemKey isEqualToString:@"enableVideoAudit"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableVideoAudit = false;
            }else{
                self.enableVideoAudit = true;
            }
        }
        if ([item.configurationItemKey isEqualToString:@"enableCommunityAudit"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableCommunityAudit = false;
            }else{
                self.enableCommunityAudit = true;
            }
            
        }
        if ([item.configurationItemKey isEqualToString:@"enableVip"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableVip = false;
            }else{
                self.enableVip = true;
            }
        }
        if ([item.configurationItemKey isEqualToString:@"hybirdversion"]) {
            self.hybirdversion = item.configurationItemValue;
        }
        if ([item.configurationItemKey isEqualToString:@"enablePublishContent"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enablePublishContent = false;
            }else{
                self.enablePublishContent = true;
            }
        }
        if ([item.configurationItemKey isEqualToString:@"enableLive"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableLive = false;
            }else{
                self.enableLive = true;
            }
        }
        if ([item.configurationItemKey isEqualToString:@"enableGrandStar"]) {
            if ([item.configurationItemValue isEqualToString:@"0"]) {
                self.enableGrandStar = false;
            }else{
                self.enableGrandStar = true;
            }
        }
    }
    
}

@end

@implementation KKMemberVipListInfo

//问题类型数组
+(NSMutableArray< KKMemberVipListInfo*> *)convertModelwithMemberVIPList:(appvapiEnterResponse * _Nonnull)HostList{
    
    NSMutableArray<KKMemberVipListInfo*>*newList = [[NSMutableArray alloc] init];
    for(appvapiVipProduct* item in HostList.config.vipProductAllInfo.vipProductsArray){
        KKMemberVipListInfo* av = [KKMemberVipListInfo initWithHotWordMessage:item];
        [newList addObject:av];
    }
    return newList;
}
+(KKMemberVipListInfo *)initWithHotWordMessage:(appvapiVipProduct *)item{
    
    KKMemberVipListInfo* model = [[KKMemberVipListInfo alloc] init];
    model.id_p = item.id_p;
    model.hasId_p = item.hasId_p;
    model.type = item.type;
    model.memberValidTimeType = item.memberValidTimeType;
    return model;
    
}

@end

@implementation KKMemberBenefitsInfo

//标签数组
+(NSMutableArray< KKMemberBenefitsInfo*> *)convertModelwithMemderList:(appvapiEnterResponse * _Nonnull)TagList{
    
    NSMutableArray<KKMemberBenefitsInfo*>*newList = [[NSMutableArray alloc] init];
    for(appvapiVipRightInterests* item in TagList.config.vipProductAllInfo.vipRightInterestssArray){
        KKMemberBenefitsInfo* av = [KKMemberBenefitsInfo initWithMemberMessage:item];
        [newList addObject:av];
    }
    return newList;
}
//初始化标签信息
+ (KKMemberBenefitsInfo *)initWithMemberMessage:(appvapiVipRightInterests *)tag{
    KKMemberBenefitsInfo* model = [[KKMemberBenefitsInfo alloc] init];
    model.id_p = tag.id_p;
    model.vipProductType = tag.vipProductType;
    model.vipRightInterestsKey = tag.vipRightInterestsKey;
    model.vipRightInterestsValue = tag.vipRightInterestsValue;
    return model;
}

@end


@implementation KKPubTagVCDataModel

//标签数组
+(NSMutableArray< KKPubTagVCDataModel*> *)convertModelwithTagList:(appvapiEnterResponse * _Nonnull)TagList{
    
    NSMutableArray<KKPubTagVCDataModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentTag* item in TagList.config.systemTagArray){
        KKPubTagVCDataModel* av = [KKPubTagVCDataModel initWithTagMessage:item];
        [newList addObject:av];
    }
    return newList;
}

//初始化标签信息
+ (KKPubTagVCDataModel *)initWithTagMessage:(appvapiContentTag *)tag{
    KKPubTagVCDataModel* model = [[KKPubTagVCDataModel alloc] init];
    model.tagModel = tag;
    model.title = tag.tagName;
    model.isSelect = 1;
    model.tagID = tag.id_p.id_p;
    model.backgroundImgURL = tag.backgroundImgURL;
    model.id_p = tag.id_p.id_p;
    model.hasBackground = tag.hasBackground;
    model.isMain = tag.isMain;
    
    return model;
}

//帖子标签数组
+(NSMutableArray< KKPubTagVCDataModel*> *)convertModelwithCommunityTagList:(appvapiEnterResponse * _Nonnull)TagList{
    
    NSMutableArray<KKPubTagVCDataModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiContentTag* item in TagList.config.postTagArray){
        KKPubTagVCDataModel* av = [KKPubTagVCDataModel initWithTagMessage:item];
        [newList addObject:av];
    }
    return newList;
}


@end
@implementation KKPubTagVCModel

+ (instancetype)shareToolGetManager {
    
    static KKPubTagVCModel *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

//init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tagArr = [[NSMutableArray alloc] init];
        self.tagImageArr = [[NSMutableArray alloc]init];
        self.memberInfoArr = [[NSMutableArray alloc]init];
        self.vipsArray = [[NSMutableArray alloc]init];
        self.AppConfigurationArr = [[NSMutableArray alloc]init];
        self.communityTagList = [[NSMutableArray alloc]init];
    }
    return self;
}

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"data":[KKPubTagVCDataModel class]};
}

-(void)requestTagList:(appvapiEnterResponse *)message{
    self.enterResponse = message;
    [self.tagArr removeAllObjects];
    [self.tagImageArr removeAllObjects];
    [self.memberInfoArr removeAllObjects];
    [self.vipsArray removeAllObjects];
    [self.AppConfigurationArr removeAllObjects];
    [self.communityTagList removeAllObjects];
    NSMutableArray *array = [KKPubTagVCDataModel convertModelwithTagList:message];
    [self.tagArr addObjectsFromArray:array];
    if (self.tagArr.count >0) {
        for (KKPubTagVCDataModel *dataModel in self.tagArr) {
            if (dataModel.tagModel.isHot) {
                [self.tagImageArr addObject:dataModel];
            }
        }
    }
    
    NSMutableArray *arrCommunity = [KKPubTagVCDataModel convertModelwithCommunityTagList:message];
    [self.communityTagList addObjectsFromArray:arrCommunity];
    
    //self.shareUrl = message.shareURL;
    KKAppConfiguration *appModel = [[KKAppConfiguration alloc]init];
    [appModel convertModelAppConfigurationItem:message];
    self.enableVip = appModel.enableVip;
    self.enableVideoAudit = appModel.enableVideoAudit;
    self.enableCommentAudit = appModel.enableCommentAudit;
    self.enableServiceAccess = appModel.enableServiceAccess;
    self.enableCommunityAudit = appModel.enableCommunityAudit;
    self.enablePublishContent = appModel.enablePublishContent;
    self.enableLive = appModel.enableLive;
    self.hybirdversion = appModel.hybirdversion;
    self.enableGrandStar = appModel.enableGrandStar;
    [AppVersionMgr checkHybridgeVersion:self.hybirdversion];
    NSMutableArray *array3 = [KKAppConfiguration convertModelAppConfigurationList:message];
    [self.AppConfigurationArr addObjectsFromArray:array3];
    NSMutableArray *arr1   = [KKMemberBenefitsInfo convertModelwithMemderList:message];
    [self.memberInfoArr addObjectsFromArray:arr1];
    
    [self getMemberInfo:self.reloadBlock];
    NSMutableArray *array2 = [KKMemberInfoItemModel convertModelwithMemberVIPList:message.config.vipProductAllInfo.vipProductsArray];
    [self.vipsArray addObjectsFromArray:array2];
    
    NSLog(@"%@",self.tagArr);
    
}


-(void)getMemberInfo:(reloadMemberInfo)infoBlock{
    self.reloadBlock = infoBlock;
    if (!kArrayIsEmpty(self.memberInfoArr)) {
        appvapiUserInfoBasic *userInfo = self.enterResponse.userInfo;
        if ([KKTool isPastDueByComparisonTimestamp:[userInfo memberExpirationTime]]) {
            for (KKMemberBenefitsInfo *model in self.memberInfoArr) {
                if (model.vipProductType == 0) {
                    if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment) {
                        self.commemtCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView){
                        self.videoCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload){
                        self.downCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }
                }
            }
        }else{
            for (KKMemberBenefitsInfo *model in self.memberInfoArr) {
                if ([userInfo memberLevel] == model.vipProductType) {
                    if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment) {
                        self.commemtCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView){
                        self.videoCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload){
                        self.downCount = [model.vipRightInterestsValue intValue];
                        
                    }
                }
            }
        }
        
    }else{
        appvapiUserInfoBasic *userInfo = self.enterResponse.userInfo;
        if ([userInfo memberLevel] == 0) {
            self.videoCount = NoMemberVideo;
            self.commemtCount = NoMemberComment;
            self.downCount = NoMemberDown;
            
        }else if ([userInfo memberLevel] == 1){
            self.videoCount = Member_1Video;
            self.commemtCount = Member_1Comment;
            self.downCount = Member_1Down;
            
            
        }else if ([userInfo memberLevel] == 2){
            self.videoCount = Member_2Video;
            self.commemtCount = Member_2Comment;
            self.downCount = Member_2Down;
            
        }
        
    }
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}



-(void)getMemberReloadInfo:(reloadMemberInfo)infoBlock{
    self.reloadBlock = infoBlock;
    if (!kArrayIsEmpty(self.memberInfoArr)) {
        
        if ([KKTool isPastDueByComparisonTimestamp:[KKUserInfo share].member_expiration_time]) {
            for (KKMemberBenefitsInfo *model in self.memberInfoArr) {
                if (model.vipProductType == 0) {
                    if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment) {
                        self.commemtCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView){
                        self.videoCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload){
                        self.downCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }
                }
            }
        }else{
            for (KKMemberBenefitsInfo *model in self.memberInfoArr) {
                if ([KKUserInfo share].member_level == model.vipProductType) {
                    if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyEmberVideoComment) {
                        self.commemtCount = [model.vipRightInterestsValue intValue];
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoView){
                        self.videoCount = [model.vipRightInterestsValue intValue];
                        
                        
                    }else if (model.vipRightInterestsKey == appvapiVipRightInterestsKey_VipRightInterestsKeyMemberVideoDownload){
                        self.downCount = [model.vipRightInterestsValue intValue];
                        
                    }
                }
            }
        }
        
    }else{
        
        if ([KKUserInfo share].member_level== 0) {
            self.videoCount = NoMemberVideo;
            self.commemtCount = NoMemberComment;
            self.downCount = NoMemberDown;
            
        }else if ([KKUserInfo share].member_level == 1){
            self.videoCount = Member_1Video;
            self.commemtCount = Member_1Comment;
            self.downCount = Member_1Down;
            
            
        }else if ([KKUserInfo share].member_level == 2){
            self.videoCount = Member_2Video;
            self.commemtCount = Member_2Comment;
            self.downCount = Member_2Down;
            
        }
        
    }
    if (self.reloadBlock) {
        self.reloadBlock();
    }
}

-(void)gettimeConfig:(getTimeBlcok)blcok{
    
    serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest *req = [serviceapplinkConfigApigetTimeConfigGetTimeConfigRequest createRequest];
    [[NetWorkMgr createMgrWithMessage:req]sendRequest:^(serviceapplinkServerTime *  _Nonnull message) {
        if (blcok) {
            blcok(message.timestampMills, message.timezone);
        }
    } failed:^(requestErrorCode errorCode) {
        
    }];
    
    
}


@end

@implementation KKMemberInfoItemModel

////问题类型数组
+(NSMutableArray< KKMemberInfoItemModel*> *)convertModelwithMemberVIPList:(NSMutableArray<appvapiVipProduct*> * _Nonnull)HostList{

    NSMutableArray<KKMemberInfoItemModel*>*newList = [[NSMutableArray alloc] init];
    for(appvapiVipProduct* item in HostList){
        KKMemberInfoItemModel* av = [KKMemberInfoItemModel initWithVIPCenterMessage:item];
        [newList addObject:av];
    }
    return newList;
}
+(KKMemberInfoItemModel *)initWithVIPCenterMessage:(appvapiVipProduct *)item{

    KKMemberInfoItemModel* model = [[KKMemberInfoItemModel alloc] init];
    model.id_p = item.id_p;
    model.hasId_p = item.hasId_p;
    model.type = item.type;
    //model.price = item.price;
    //model.salePriceInfo = item.salePriceInfo;
    model.memberValidTimeType = item.memberValidTimeType;
    return model;

}


@end

