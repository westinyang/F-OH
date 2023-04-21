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

@Component
export struct SettingRow {
  icon?: string | PixelMap | Resource
  title: string
  info?: string | Resource
  clickHandler?: (event?: ClickEvent) => void
  showRightArrow?: boolean = true

  build() {
    Row() {
      Image(this.icon).width(26).height(26).borderRadius(13).margin({ left: 14 })
      Column() {
        Text(this.title).fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
        Text(this.info).fontSize(12).fontColor('#99182431').alignSelf(ItemAlign.Start).margin({top: 4})
      }.margin({ left: 14 }).alignItems(HorizontalAlign.Center)
      Blank();
      // Text('RightInfo').fontSize(12).fontColor('#99182431').margin({ right: 4 })
      if (this.showRightArrow) {
        Image($r('app.media.ic_right_arrow')).width(12).height(24).objectFit(ImageFit.Contain).margin({ right: 14 })
      }
    }
    .width('100%')
    .height(48)
    .onClick(this.clickHandler)
    .margin({top:5, bottom: 5})
  }
}
