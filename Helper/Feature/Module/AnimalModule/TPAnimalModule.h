//
//  TPAnimalModule.h
//  Helper
//
//  Created by Topredator on 2024/12/25.
//

#import <Foundation/Foundation.h>

/// 动物表名
#define TABLE_NAME_ANIMAL  @"Animal_"
/// 领养表
#define TABLE_NAME_ADOPT  @"Adopt_"

typedef NS_ENUM(NSUInteger, TPAnimalModuleMessageType) {
    /// 动物注册
    TPAnimalModuleRegist = 300000,
    /// 动物信息编辑
    TPAnimalModuleAnimalEdit,
    /// 获取用户名下动物
    TPAnimalModuleFetchUserAnimal,
    /// 获取用户名下更多动物
    TPAnimalModuleFetchUserAnimalDatas,
    
    /// 管理员发布领养
    TPAnimalModulePublicAdopt,
    /// 获取 所有类型 领养数据(刷新)
    TPFetchAdoptDatas,
    /// 获取所有类型的领养数据(更多)
    TPFetchAdoptMoreDatas,
    
    TPFetchAllAdoptDatas,
    TPFetchAllAdoptMoreDatas,
    TPFetchCatAdoptDatas,
    TPFetchCatAdoptMoreDatas,
    TPFetchDogAdoptDatas,
    TPFetchDogAdoptMoreDatas,
    
    
    
};


@interface TPAnimalModule : NSObject <TPDBModuleProtocol>

@end


