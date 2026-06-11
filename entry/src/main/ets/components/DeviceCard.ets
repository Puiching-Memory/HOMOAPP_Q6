import { IDevice } from '../models/DeviceModel';

@Component
export struct DeviceCard {
  @Prop device: IDevice;

  private iconOf(type: string): string {
    if (type === 'light') {
      return '☀';
    }
    if (type === 'air') {
      return 'A/C';
    }
    if (type === 'camera') {
      return 'CAM';
    }
    if (type === 'sensor') {
      return 'CO';
    }
    if (type === 'curtain') {
      return 'WIN';
    }
    return 'GW';
  }

  build() {
    Column({ space: 10 }) {
      Row() {
        Text(this.iconOf(this.device.type))
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#1A1F2B')
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .borderRadius(22)
          .backgroundColor(this.device.online ? '#CDEBDD' : '#E7E8EA')

        Blank()

        Text(this.device.online ? '在线' : '离线')
          .fontSize(12)
          .fontColor(this.device.online ? '#18794E' : '#7B8190')
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)
          .backgroundColor(this.device.online ? '#E6F6EC' : '#F0F1F3')
      }
      .width('100%')

      Text(this.device.name)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor('#1A1F2B')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(`${this.device.room} | ${this.device.status}`)
        .fontSize(13)
        .fontColor('#5B6372')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
        Text(`${this.device.power}W`)
          .fontSize(13)
          .fontColor('#2B5A83')
        Blank()
        Button('控制')
          .fontSize(13)
          .height(32)
          .backgroundColor('#246B8F')
          .borderRadius(6)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(14)
    .width('100%')
    .height(160)
    .borderRadius(8)
    .backgroundColor(Color.White)
    .border({ width: 1, color: '#DDE3EA' })
  }
}
