@Component
export struct SettingsPanel {
  @Prop loadedDarkMode: boolean;
  @Prop loadedGatewayIp: string;
  @Link darkMode: boolean;
  @Link gatewayIp: string;

  build() {
    Column({ space: 16 }) {
      Text('我的')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#18202C')
        .width('100%')

      Row() {
        Column({ space: 4 }) {
          Text('深色模式')
            .fontSize(17)
            .fontColor('#1A1F2B')
          Text(this.loadedDarkMode ? '上次保存为开启' : '上次保存为关闭')
            .fontSize(12)
            .fontColor('#687385')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
          .selectedColor('#246B8F')
          .onChange((isOn: boolean) => {
            this.darkMode = isOn;
          })
      }
      .padding(16)
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDE3EA' })

      Column({ space: 8 }) {
        Text('默认网关 IP')
          .fontSize(17)
          .fontColor('#1A1F2B')
          .width('100%')
        TextInput({ text: this.gatewayIp, placeholder: this.loadedGatewayIp })
          .height(44)
          .fontSize(15)
          .backgroundColor('#F5F7FA')
          .borderRadius(6)
          .onChange((value: string) => {
            this.gatewayIp = value;
          })
        Text('用于应用冷启动时恢复家庭网关连接配置')
          .fontSize(12)
          .fontColor('#687385')
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDE3EA' })

      Column({ space: 8 }) {
        Text('持久化状态')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor('#1A1F2B')
          .width('100%')
        Text(`当前主题: ${this.darkMode ? '深色' : '浅色'}`)
          .fontSize(14)
          .fontColor('#4E5969')
          .width('100%')
        Text(`当前网关: ${this.gatewayIp}`)
          .fontSize(14)
          .fontColor('#4E5969')
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .borderRadius(8)
      .backgroundColor('#EEF4F0')
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F8FA')
  }
}
