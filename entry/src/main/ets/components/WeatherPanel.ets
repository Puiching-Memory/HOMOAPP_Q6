import { WeatherInfo } from '../models/DeviceModel';

@Component
export struct WeatherPanel {
  @Prop weather: WeatherInfo;
  @Prop loadState: string;

  build() {
    Column({ space: 8 }) {
      Row() {
        Column({ space: 4 }) {
          Text('家庭环境')
            .fontSize(15)
            .fontColor('#5B6372')
          Text(this.weather.city)
            .fontSize(24)
            .fontWeight(FontWeight.Bold)
            .fontColor('#18202C')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        if (this.loadState === 'loading') {
          LoadingProgress()
            .width(36)
            .height(36)
            .color('#246B8F')
        } else if (this.loadState === 'failed') {
          Text('离线')
            .fontSize(14)
            .fontColor('#B42318')
        } else {
          Text(this.weather.text)
            .fontSize(16)
            .fontColor('#246B8F')
        }
      }
      .width('100%')

      Row({ space: 12 }) {
        this.metric('温度', `${this.weather.temperature}C`)
        this.metric('湿度', `${this.weather.humidity}%`)
        this.metric('设备', '5/6')
      }
      .width('100%')
    }
    .padding(16)
    .width('100%')
    .borderRadius(8)
    .backgroundColor('#E9F3F7')
  }

  @Builder
  metric(label: string, value: string) {
    Column({ space: 4 }) {
      Text(value)
        .fontSize(18)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1F2B')
      Text(label)
        .fontSize(12)
        .fontColor('#647181')
    }
    .layoutWeight(1)
    .alignItems(HorizontalAlign.Start)
    .padding(10)
    .borderRadius(6)
    .backgroundColor('#FFFFFF')
  }
}
