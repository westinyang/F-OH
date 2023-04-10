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

import { AppType } from '../model/AppInfo';
import { DataSource } from '../data/DataSource';

@Component
export default struct Home {
  private swiperController: SwiperController = new SwiperController()
  private controller: SearchController = new SearchController()
  @State changeValue: string = ''
  @State submitValue: string = ''

  @State start: boolean = true
  private fromStart: boolean = true
  private step: number = 20
  private loop: number = Infinity
  private src: string = "F-OH 是一个 OpenHarmony 平台上 FOSS（Free and Open Source Software，自由开源软件）的应用中心"

  @State totalCount: number = 0;
  @State appCount: number = 0;
  @State gameCount: number = 0;

  aboutToAppear() {
    DataSource.getAppList(AppType.APP, (data, totalCount)=>{
      this.totalCount = totalCount;
      this.appCount = (data as []).length;
      this.gameCount = totalCount - this.appCount;
    })
  }

  @Builder NavigationTitle() {
    Column() {
      Text('F-OH')
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
            Search({ value: this.changeValue, placeholder: '应用、游戏...', controller: this.controller })
              .searchButton('搜索')
              .width('100%')
              .height(40)
              .backgroundColor('#F5F5F5')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
              })
              .onChange((value: string) => {
              }).focusable(false)

            Swiper(this.swiperController) {
              Image($r('app.media.main_banner_1')).width('100%').height(150).borderRadius(15)
              Image($r('app.media.main_banner_2')).width('100%').height(150).borderRadius(15)
              Image($r('app.media.main_banner_3')).width('100%').height(150).borderRadius(15)
            }
            .cachedCount(3)
            .index(0)
            .autoPlay(true)
            .interval(5000)
            .indicator(true)
            .loop(true)
            .duration(1000)
            .itemSpace(20)
            .curve(Curve.Linear)
            .onChange((index: number) => {
              console.info(index.toString())
            })
            .margin({top: 10})

            Column() {
              Text("应用收录").fontSize(20).width('100%').margin({bottom: 10})
              Flex({
                direction: FlexDirection.Row,
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Center
              }) {
                Column() {
                  Column() {
                    Text('总计').height(30).fontSize(16).fontColor('#333')
                  }.width('100%').border({width: {bottom: 1}, color: '#fff'})
                  Column() {
                    Text(this.totalCount.toString()).height(30).fontSize(16).fontColor('#555')
                  }.width('100%')
                }
                .width('100%').margin({right: 10}).padding({left:5, right: 5}).flexGrow(1)
                .backgroundImage($r('app.media.main_card_1'))
                .backgroundImageSize(ImageSize.Cover)
                .border({width: 0.7, radius: 15, color: '#ebebeb'})

                Column() {
                  Column() {
                    Text('应用').height(30).fontSize(16).fontColor('#333')
                  }.width('100%').border({width: {bottom: 1}, color: '#fff'})
                  Column() {
                    Text(this.appCount.toString()).height(30).fontSize(16).fontColor('#555')
                  }.width('100%')
                }
                .width('100%').margin({left: 5, right: 5}).padding({left:5, right: 5}).flexGrow(0)
                .backgroundImage($r('app.media.main_card_1'))
                .backgroundImageSize(ImageSize.Cover)
                .border({width: 0.7, radius: 15, color: '#ebebeb'})

                Column() {
                  Column() {
                    Text('游戏').height(30).fontSize(16).fontColor('#333')
                  }.width('100%').border({width: {bottom: 1}, color: '#fff'})
                  Column() {
                    Text(this.gameCount.toString()).height(30).fontSize(16).fontColor('#555')
                  }.width('100%')
                }
                .width('100%').margin({left: 10}).padding({left:5, right: 5}).flexGrow(0)
                .backgroundImage($r('app.media.main_card_1'))
                .backgroundImageSize(ImageSize.Cover)
                .border({width: 0.7, radius: 15, color: '#ebebeb'})
              }
            }.margin({top: 15})

            Column() {
              Text("最新公告").fontSize(20).width('100%').margin({bottom: 10})

              Marquee({
                start: this.start,
                step: this.step,
                loop: this.loop,
                fromStart: this.fromStart,
                src: this.src
              })
                .width('100%')
                .height(50)
                .fontColor('#FFFFFF')
                .fontSize(20)
                .fontWeight(500)
                .borderRadius(15)
                .backgroundColor('#182431')
                .onStart(() => {
                  console.info('Marquee animation complete onStart')
                })
                .onBounce(() => {
                  console.info('Marquee animation complete onBounce')
                })
                .onFinish(() => {
                  console.info('Marquee animation complete onFinish')
                })

            }.margin({top: 15})

          }
          .width('100%')
          .padding({left: 15, right: 15})
        }
        .edgeEffect(EdgeEffect.None)
        .width('100%')
        .height('auto')
        .margin({bottom: 56})
      }
      .width('100%')
      .height('100%')
    }.width('100%').height('100%').backgroundColor('#ffffff')
  }
}