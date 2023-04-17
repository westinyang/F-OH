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
