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

import {AppInfo, AppType} from '../model/AppInfo';
import AppListItem from '../component/AppListItem';
import { DataSource } from '../data/DataSource';

@Component
export default struct App {
  appType: AppType
  @State appList: AppInfo[] = []

  aboutToAppear() {
    DataSource.getAppList(this.appType, (data, totalCount)=>{
      this.appList = data;
    })
  }

  @Builder NavigationTitle() {
    Column() {
      Text(this.appType == AppType.APP ? '应用' : '游戏')
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
          .border({width: {bottom: 0.5}, color: '#c9c9c9'})
          .padding({left: 15, right: 15})

        Scroll() {
          Column() {
            List({ space: 15, initialIndex: 0 }) {
              ForEach(this.appList, (item: AppInfo) => {
                ListItem() {
                  AppListItem({appInfo: item})
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
        }
        .edgeEffect(EdgeEffect.Spring)
        .width('100%')
        .height('auto')
        .margin({bottom: 56})
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffffff')
  }
}
