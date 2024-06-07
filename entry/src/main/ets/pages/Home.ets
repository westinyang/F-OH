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
import { HomePageData } from '../model/HomePageData';
import promptAction from '@ohos.promptAction';

const ToastDuration = 2000

@Component
export default struct Home {
  // 搜索
  private swiperController: SwiperController = new SwiperController()
  private controller: SearchController = new SearchController()
  @State changeValue: string = ''
  @State submitValue: string = ''

  // 应用收录
  @State totalCount: number = 0;
  @State appCount: number = 0;
  @State gameCount: number = 0;

  @State homePageData: HomePageData = new HomePageData({});

  aboutToAppear() {
    DataSource.getHomePageData((data) =>{
      this.homePageData = data;
    }, (err) => {
      promptAction.showToast({ message: $r('app.string.network_error'), duration: ToastDuration });
    });

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
    .width('100%')
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
            // 搜索
            Search({ value: this.changeValue, placeholder: (Object)($r('app.string.app_game_search')), controller: this.controller })
              .searchButton(getContext(this).resourceManager.getStringSync($r('app.string.search')))
              .width('100%')
              .height(40)
              .backgroundColor('#F5F5F5')
              .placeholderColor(Color.Grey)
              .placeholderFont({ size: 14, weight: 400 })
              .textFont({ size: 14, weight: 400 })
              .onSubmit((value: string) => {
                promptAction.showToast({ message: $r('app.string.few_apps_no_search'), duration: ToastDuration });
              })
              .onChange((value: string) => {
              })
              .focusable(false)

            // 滚动图
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

            // 收录统计
            Column() {
              Text($r('app.string.inclusion_stats')).fontSize(20).width('100%').margin({bottom: 10})
              Flex({
                direction: FlexDirection.Row,
                justifyContent: FlexAlign.SpaceBetween,
                alignItems: ItemAlign.Center
              }) {
                Column() {
                  Column() {
                    Text($r('app.string.total')).height(30).fontSize(16).fontColor('#333')
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
                    Text($r('app.string.app')).height(30).fontSize(16).fontColor('#333')
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
                    Text($r('app.string.game')).height(30).fontSize(16).fontColor('#333')
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

            // 最新公告
            Column() {
              Text($r('app.string.latest_announcement')).fontSize(20).width('100%').margin({bottom: 10})

              Text(this.homePageData.announcement || HomePageData.defaultAnnouncement)
                .width('100%')
                .borderRadius(15)
                .backgroundColor('#f6f6f6')
                .padding(10)
                .fontSize(16)
                .fontColor('#555555')

            }.margin({top: 15}).visibility(this.homePageData.showAnnouncement ? Visibility.Visible : Visibility.None)

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