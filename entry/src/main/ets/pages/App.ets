import { DataSource } from '../data/DataSource';
import { AppType, AppInfo } from '../model/Types';

@Component
export default struct App {
  appType: AppType
  @State appList: AppInfo[] = []

  aboutToAppear() {
    DataSource.getAppList(this.appType, (data)=>{
      this.appList = data;
    })
  }

  @Builder NavigationTitle() {
    Column() {
      Text(this.appType == AppType.app ? '应用' : '游戏')
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
        .margin({left: -25})
    }.alignItems(HorizontalAlign.Start)
  }

  build() {
    Column() {
      // 页面标题
      Navigation()
        .title(this.NavigationTitle())
        .hideToolBar(true)
        .height(56)
        .width('100%')
        .titleMode(NavigationTitleMode.Mini)
        .hideBackButton(true)
        .border({width: {bottom: 0.5}, color: '#c9c9c9'})
        .padding({left: 15, right: 15})

      // 应用列表
      Scroll() {
        Stack({ alignContent: Alignment.Top }) {
          Column() {
            List({ space: 15, initialIndex: 0 }) {
              ForEach(this.appList, (item: AppInfo) => {
                ListItem() {
                  // 应用信息行
                  Flex({
                    direction: FlexDirection.Row,
                    justifyContent: FlexAlign.SpaceBetween,
                    alignItems: ItemAlign.Center
                  }) {
                    // 左 应用图标
                    Column() {
                      Image(item.icon || $r('app.media.icon'))
                    }
                    .width(55)
                    .height('100%')
                    .border({width: 0.7, radius: 13, color: '#ebebeb'})
                    .flexShrink(0)

                    // 中 应用信息
                    Column() {
                      Text(item.name).fontSize(16).margin({top: 2, bottom: 5})
                      Text(item.desc)
                        .fontSize(12).maxLines(2).textOverflow({overflow: TextOverflow.Ellipsis})
                    }
                    .height('100%')
                    .margin({left: 10, right: 10})
                    .alignItems(HorizontalAlign.Start)
                    .flexGrow(1)
                    .justifyContent(FlexAlign.Start)

                    // 右 安装按钮
                    Column() {
                      Button('安装').width('100%').height(26).fontSize(14).fontColor('#3478f6').backgroundColor('#eeeeee')
                    }
                    .width(60)
                    .height('100%')
                    .flexShrink(0)
                    .justifyContent(FlexAlign.Center)
                  }
                  .height(55)
                }
              }, (item: AppInfo, index) => index + JSON.stringify(item))
            }
            .width('auto')
            .height('auto')
            .padding({left: 15, right: 15})
            .divider({
              strokeWidth: 0.5,
              color: '#cccccc',
              startMargin: 65,
              endMargin: 0
            })
          }
          .width('100%')
          .margin({top: 7.5, bottom: 7.5})
          .backgroundColor('#FFFFFF')
        }
      }
      .edgeEffect(EdgeEffect.Spring)
      .width('100%')
      .height('100%')
      .padding({bottom: 56})
    }
  }
}
