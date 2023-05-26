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
import promptAction from '@ohos.promptAction'
import pasteboard from '@ohos.pasteboard'

@Component
export struct InfoRow {
  icon?: string | PixelMap | Resource
  title: string
  info?: string | Resource
  clickHandler?: (event?: ClickEvent) => void
  showRightArrow?: boolean = true

  build() {
    Flex({
      direction: FlexDirection.Row,
      justifyContent: FlexAlign.SpaceBetween,
      alignItems: ItemAlign.Center
    }) {
      Image(this.icon).width(26).height(26).borderRadius(13)
      .flexShrink(0)

      Column() {
        Text(this.title).fontSize(16).fontColor('#FF182431').alignSelf(ItemAlign.Start)
        Text(this.info).fontSize(13).fontColor('#99182431').maxLines(1).textOverflow({ overflow: TextOverflow.Ellipsis }).alignSelf(ItemAlign.Start).margin({top: 4})
      }
      .margin({ left: 14 })
      .alignItems(HorizontalAlign.Center)
      .flexGrow(1)

      if (this.showRightArrow) {
        Image($r('app.media.ic_right_arrow')).width(24).height(24).objectFit(ImageFit.Contain).flexShrink(0)
      }
    }
    .width('100%')
    .height(48)
    .onClick(this.clickHandler || ((e) => {
      let pasteData = pasteboard.createData(pasteboard.MIMETYPE_TEXT_PLAIN, this.info.toString())
      pasteboard.getSystemPasteboard()
      let systemPasteboard = pasteboard.getSystemPasteboard();
      systemPasteboard.setData(pasteData, (err, data) => {
        if (err) {
          console.error('Failed to set PasteData. Cause: ' + err.message);
          return;
        }
        console.info('Succeeded in setting PasteData.');
        // 提示
        try {
          promptAction.showToast({
            message: '已复制 ' + this.title,
            duration: 1000,
          });
        } catch (error) {
          console.error(`showToast args error code is ${error.code}, message is ${error.message}`);
        };
      });
    }))
    .margin({top:5, bottom: 5})
  }
}
