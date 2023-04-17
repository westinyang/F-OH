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
import { SettingRow } from '../components/Settings';
import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

const ToastDuration = 1000
const APP_VERSION = "1.1.2";

@Entry
@Component
export default struct AboutApp {

  onPageShow() {
    console.info('AboutComponent onPageShow');
    WindowStageUtil.setLayoutFullScreen(globalThis.windowStage, '#f3f4f6', WindowStageUtil.COLOR_BLACK, '#f3f4f6', WindowStageUtil.COLOR_BLACK);
  }

  @Builder NavigationTitle() {
    Column() {
      Text('关于F-OH')
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
    }.width('100%').height('100%').backgroundColor('#f3f4f6')
//    .padding({top: WindowStageUtil.STATUS_BAR_HEIGHT})
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
      Text('版本 ' + APP_VERSION)
        .fontSize(14)
        .fontColor('#99182431')
        .margin({top: 4})
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
        ListItem() { SettingRow({icon: $r('app.media.ic_foh'), title: '应用简介', info: 'OpenHarmony自由开源软件的应用中心', showRightArrow: false, clickHandler: ()=> {}}) }
        ListItem() { SettingRow({icon: $r('app.media.author_avatar'), title: '应用作者', info: 'westinyang', clickHandler: ()=> {
          router.pushUrl({ url: 'pages/AboutAuthor', params: {} });
        }}) }
        ListItem() { SettingRow({icon: $r('app.media.ic_favorite'), title: '开源仓库', info: 'https://gitee.com/ohos-dev/f-oh', clickHandler: ()=> {
          router.pushUrl({ url: 'pages/Browser', params: {title: '开源仓库', url: 'https://gitee.com/ohos-dev/f-oh'} });
        }}) }
        ListItem() { SettingRow({icon: $r('app.media.ic_gitee'), title: '开源社区', info: 'https://gitee.com/ohos-dev', clickHandler: ()=> {
          router.pushUrl({ url: 'pages/Browser', params: {title: '开源社区', url: 'https://gitee.com/ohos-dev'} });
        }}) }
        ListItem() { SettingRow({icon: $r('app.media.ic_qq'), title: '开源社区交流群', info: '752399947', clickHandler: ()=> {
          promptAction.showToast({ message: '待实现，跳转开源社区交流群', duration: ToastDuration });
        }}) }
      }.divider({ strokeWidth: 0.5, color: '#d6d6d6', startMargin: 58, endMargin: 14 })
    }.borderRadius(18).backgroundColor('#fff')
  }
}