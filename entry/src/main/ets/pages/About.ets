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

import WindowStageUtil from '../util/WindowStageUtil';

const APP_VERSION = "1.1.3";

@Entry
@Component
export default struct About {
  @Builder NavigationTitle() {
    Column() {
      Text('关于')
        .fontColor('#182431')
        .fontSize(26)
        .fontWeight(500)
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
          .hideBackButton(false)

        Scroll() {
          Column() {
            this.LogoAndVersionComponent()
            this.AppInfoComponent()
          }.width('100%').padding({left: 15, right: 15})
        }
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .height('auto')
        .margin({bottom: 56})
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%').backgroundColor('#f3f4f6').padding({top: WindowStageUtil.STATUS_BAR_HEIGHT})
  }

  @Builder LogoAndVersionComponent() {
    Column() {
      Image($r("app.media.icon"))
        .height(72)
        .width(72)
        .border({width: 0.7, radius: 16, color: '#ebebeb'})
      Text($r('app.string.EntryAbility_label'))
        .fontSize(18)
        .fontColor('#182431')
        .fontWeight(500)
        .padding({ top: 8 })
      Text('版本：' + APP_VERSION)
        .fontSize(14)
        .fontColor('#99182431')
        .margin({top: 1})
    }
    .alignItems(HorizontalAlign.Center)
    .align(Alignment.Top)
    .padding({
      top: 62,
      bottom: 62
    })
  }

  @Builder AppInfoComponent() {
    // 第一组
    Column() {
      List() {
        ListItem() {
          Row() {
            Column() {
              Text('应用简介').fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
              Text('OpenHarmony自由开源软件的应用中心').fontSize(14).fontColor('#99182431').alignSelf(ItemAlign.Start).margin({top: 2})
            }.margin({ left: 14 }).alignItems(HorizontalAlign.Center)
            Blank();
            Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
          }
          .width('100%').height(48).onClick(() => {
          })
        }.padding({top:4, bottom: 4})

        ListItem() {
          Row() {
            Column() {
              Text('开源社区').fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
              Text('https://gitee.com/ohos-dev').fontSize(14).fontColor('#99182431').alignSelf(ItemAlign.Start).margin({top: 2})
            }.margin({ left: 14 }).alignItems(HorizontalAlign.Center)
            Blank();
            Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
          }
          .width('100%').height(48).onClick(() => {
          })
        }.padding({top:4, bottom: 4})

        ListItem() {
          Row() {
            Column() {
              Text('开源贡献').fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
              Text('westinyang').fontSize(14).fontColor('#99182431').alignSelf(ItemAlign.Start).margin({top: 2})
            }.margin({ left: 14 }).alignItems(HorizontalAlign.Center)
            Blank();
            Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
          }
          .width('100%').height(48).onClick(() => {
          })
        }.padding({top:4, bottom: 4})

        ListItem() {
          Row() {
            Column() {
              Text('交流群组').fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
              Text('752399947').fontSize(14).fontColor('#99182431').alignSelf(ItemAlign.Start).margin({top: 2})
            }.margin({ left: 14 }).alignItems(HorizontalAlign.Center)
            Blank();
            Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
          }
          .width('100%').height(48).onClick(() => {
          })
        }.padding({top:4, bottom: 4})
      }
      .divider({ strokeWidth: 0.5, color: '#cccccc', startMargin: 14, endMargin: 14 })
    }.borderRadius(18).backgroundColor('#fff')
  }
}