@Entry
@Component
struct WidgetCard {
  build() {
    FormLink({
      action: 'router',
      abilityName: 'EntryAbility',
      params: {
        from: 'smart-home-card'
      }
    }) {
      Column({ space: 8 }) {
        Row() {
          Text('智享家')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor('#18202C')
          Blank()
          Text('在线')
            .fontSize(11)
            .fontColor('#18794E')
        }
        .width('100%')

        Text('26C  |  62%')
          .fontSize(26)
          .fontWeight(FontWeight.Bold)
          .fontColor('#246B8F')
          .width('100%')

        Text('5 台设备在线')
          .fontSize(13)
          .fontColor('#4E5969')
          .width('100%')

        Text('点击进入主页')
          .fontSize(11)
          .fontColor('#687385')
          .width('100%')
      }
      .padding(14)
      .width('100%')
      .height('100%')
      .backgroundColor('#E9F3F7')
    }
  }
}
