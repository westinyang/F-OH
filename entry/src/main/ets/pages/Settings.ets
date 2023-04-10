/*
 * Copyright (C) 2023 westinyang https://gitee.com/ohos-dev
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import router from '@ohos.router';

@Component
export default struct Settings {
  aboutToAppear(): void {

  }

  @Builder NavigationTitle() {
    Column() {
      Text('设置')
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
        .margin({left: -25})
    }.alignItems(HorizontalAlign.Start)
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      Column() {
        // 页面标题
        Navigation()
          .title(this.NavigationTitle())
          .hideToolBar(true)
          .height(56)
          .width('100%')
          .titleMode(NavigationTitleMode.Mini)
          .hideBackButton(true)
//          .border({width: {bottom: 0.5}, color: '#c9c9c9'})
          .padding({left: 15, right: 15})

        Scroll() {
          Column() {
            // 第一组
            Column() {
              List() {
                ListItem() {
                  Row() {
                    Text('下载管理').fontSize(16).fontColor('#FF182431').margin({ left: 14 })
                    Blank();
                    Text('待开发').fontSize(14).fontColor('#99182431').margin({ right: 4 })
                    Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
                  }
                  .width('100%').height(48).onClick(() => {
                  })
                }.padding({top:2, bottom: 2})

                ListItem() {
                  Row() {
                    Text('应用管理').fontSize(16).fontColor('#FF182431').margin({ left: 14 })
                    Blank();
                    Text('待开发').fontSize(14).fontColor('#99182431').margin({ right: 4 })
                    Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
                  }
                  .width('100%').height(48).onClick(() => {
                  })
                }.padding({top:2, bottom: 2})

                ListItem() {
                  Row() {
                    Text('应用元数据管理').fontSize(16).fontColor('#FF182431').margin({ left: 14 })
                    Blank();
                    Text('待开发').fontSize(14).fontColor('#99182431').margin({ right: 4 })
                    Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
                  }
                  .width('100%').height(48).onClick(() => {
                  })
                }.padding({top:2, bottom: 2})
              }
              .divider({ strokeWidth: 0.5, color: '#cccccc', startMargin: 14, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff')

            // 第二组
            Column() {
              List() {
                ListItem() {
                  Row() {
                    Text('关于').fontSize(16).fontColor('#FF182431').margin({ left: 14 })
                    Blank();
                    Text('').fontSize(14).fontColor('#99182431').margin({ right: 4 })
                    Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
                  }
                  .width('100%').height(48).onClick(() => {
                    router.pushUrl({
                      url: 'pages/About',
                      params: {}
                    });
                  })
                }.padding({top: 2, bottom: 2})
              }
              .divider({ strokeWidth: 0.5, color: '#cccccc', startMargin: 14, endMargin: 14 })
            }.borderRadius(18).backgroundColor('#fff').margin({top: 10})

          }.width('100%').padding({left: 15, right: 15})
        }
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .height('auto')
        .margin({bottom: 56})
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%').backgroundColor('#f3f4f6')
  }
}