@Component
export struct SettingsPanel {
  @Prop loadedDarkMode: boolean;
  @Prop loadedGatewayIp: string;
  @Link darkMode: boolean;
  @Link gatewayIp: string;
  @StorageLink('darkMode') storageDarkMode: boolean = false;

  build() {
    Column({ space: 16 }) {
      Text('我的')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.darkMode ? '#E6EDF1' : '#18202C')
        .width('100%')

      Row() {
        Column({ space: 4 }) {
          Text('深色模式')
            .fontSize(17)
            .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
          Text(this.loadedDarkMode ? '上次保存为开启' : '上次保存为关闭')
            .fontSize(12)
            .fontColor(this.darkMode ? '#8B949E' : '#687385')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.darkMode })
          .selectedColor(this.darkMode ? '#58A6FF' : '#246B8F')
          .onChange((isOn: boolean) => {
            this.darkMode = isOn;
          })
      }
      .padding(16)
      .borderRadius(8)
      .backgroundColor(this.darkMode ? '#1C2128' : Color.White)
      .border({ width: 1, color: this.darkMode ? '#30363D' : '#DDE3EA' })

      Column({ space: 8 }) {
        Text('默认网关 IP')
          .fontSize(17)
          .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
          .width('100%')
        TextInput({ text: this.gatewayIp, placeholder: this.loadedGatewayIp })
          .height(44)
          .fontSize(15)
          .backgroundColor(this.darkMode ? '#21262D' : '#F5F7FA')
          .borderRadius(6)
          .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
          .onChange((value: string) => {
            this.gatewayIp = value;
          })
        Text('用于应用冷启动时恢复家庭网关连接配置')
          .fontSize(12)
          .fontColor(this.darkMode ? '#8B949E' : '#687385')
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .borderRadius(8)
      .backgroundColor(this.darkMode ? '#1C2128' : Color.White)
      .border({ width: 1, color: this.darkMode ? '#30363D' : '#DDE3EA' })

      Column({ space: 8 }) {
        Text('持久化状态')
          .fontSize(17)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
          .width('100%')
        Text(`当前主题: ${this.darkMode ? '深色' : '浅色'}`)
          .fontSize(14)
          .fontColor(this.darkMode ? '#8B949E' : '#4E5969')
          .width('100%')
        Text(`当前网关: ${this.gatewayIp}`)
          .fontSize(14)
          .fontColor(this.darkMode ? '#8B949E' : '#4E5969')
          .width('100%')
      }
      .alignItems(HorizontalAlign.Start)
      .padding(16)
      .borderRadius(8)
      .backgroundColor(this.darkMode ? '#21262D' : '#EEF4F0')
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor(this.darkMode ? '#0D1117' : '#F6F8FA')
  }
}
