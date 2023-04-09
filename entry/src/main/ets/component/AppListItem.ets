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

import {AppInfo, AppActionText} from '../model/AppInfo';

@Component
export default struct AppListItem {
  @State appInfo: AppInfo = null;

  build() {
    // 应用信息行
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Center
    }) {
      // 左 应用图标
      Column() {
        Image(this.appInfo.icon || $r('app.media.icon'))
      }
      .width(55)
      .height('100%')
      .border({width: 0.7, radius: 13, color: '#ebebeb'})
      .flexShrink(0)

      // 中 应用信息
      Column() {
        Text(this.appInfo.name).fontSize(16).margin({top: 2, bottom: 5})
        Text(this.appInfo.desc)
          .fontSize(12).maxLines(2).textOverflow({overflow: TextOverflow.Ellipsis})
      }
      .height('100%')
      .margin({left: 10, right: 10})
      .alignItems(HorizontalAlign.Start)
      .flexGrow(1)
      .justifyContent(FlexAlign.Start)

      // 右 安装按钮
      Column() {
        Button(this.appInfo.actionText.toString())
          .width('100%')
          .height(26)
          .fontSize(14)
          .fontColor('#3478f6')
          .backgroundColor('#eeeeee')
          .onClick(()=>{
            this.appAction();
          })
      }
      .width(60)
      .height('100%')
      .flexShrink(0)
      .justifyContent(FlexAlign.Center)
    }
    .height(55)
  }

  appAction() {
    this.appInfo.actionText = AppActionText.OPEN;
  }

}