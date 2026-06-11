@Entry
@Component
struct LightControl {
  @State @Watch('onPowerChanged') isPowerOn: boolean = true;
  @State lightLevel: number = 68;
  @State lastMessage: string = '台灯已连接';

  onPowerChanged(): void {
    this.lastMessage = this.isPowerOn ? '电源已开启' : '电源已关闭，亮度控制已锁定';
  }

  build() {
    Column({ space: 22 }) {
      Row() {
        Button('<')
          .width(48)
          .height(40)
          .fontSize(18)
          .backgroundColor('#E7EDF3')
          .fontColor('#1A1F2B')
          .borderRadius(6)
          .onClick(() => {
            this.getUIContext().getRouter().back();
          })

        Text('客厅台灯')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#18202C')
          .layoutWeight(1)
          .textAlign(TextAlign.Center)

        Blank()
          .width(48)
      }
      .width('100%')

      Column({ space: 18 }) {
        Text('LIGHT')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.isPowerOn ? '#946200' : '#8D96A6')
          .width(132)
          .height(132)
          .textAlign(TextAlign.Center)
          .borderRadius(66)
          .backgroundColor(this.isPowerOn ? '#FFE6A3' : '#E5E7EB')
          .opacity(this.isPowerOn ? Math.max(0.25, this.lightLevel / 100) : 0.28)

        Text(`${Math.round(this.lightLevel)}%`)
          .fontSize(36)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1F2B')

        Text(this.lastMessage)
          .fontSize(14)
          .fontColor('#687385')
      }
      .padding(24)
      .width('100%')
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDE3EA' })

      Column({ space: 12 }) {
        Row() {
          Text('亮度')
            .fontSize(17)
            .fontColor('#1A1F2B')
          Blank()
          Text(this.isPowerOn ? '可调节' : '已禁用')
            .fontSize(13)
            .fontColor(this.isPowerOn ? '#18794E' : '#B42318')
        }
        .width('100%')

        Slider({
          value: this.lightLevel,
          min: 0,
          max: 100,
          step: 1,
          style: SliderStyle.OutSet
        })
          .enabled(this.isPowerOn)
          .trackColor('#DDE3EA')
          .selectedColor('#246B8F')
          .onChange((value: number) => {
            this.lightLevel = value;
          })
      }
      .padding(16)
      .width('100%')
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDE3EA' })

      Row() {
        Column({ space: 4 }) {
          Text('总开关')
            .fontSize(17)
            .fontColor('#1A1F2B')
          Text('@Watch 只更新派生提示，不回写 isPowerOn')
            .fontSize(12)
            .fontColor('#687385')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Toggle({ type: ToggleType.Switch, isOn: this.isPowerOn })
          .selectedColor('#246B8F')
          .onChange((isOn: boolean) => {
            this.isPowerOn = isOn;
          })
      }
      .padding(16)
      .width('100%')
      .borderRadius(8)
      .backgroundColor(Color.White)
      .border({ width: 1, color: '#DDE3EA' })
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor('#F6F8FA')
  }
}
