import { IDevice } from '../models/DeviceModel';

@Component
export struct DeviceCard {
  @Prop device: IDevice;
  @StorageLink('darkMode') darkMode: boolean = false;

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
          .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
          .width(44)
          .height(44)
          .textAlign(TextAlign.Center)
          .borderRadius(22)
          .backgroundColor(this.device.online ? (this.darkMode ? '#1E442E' : '#CDEBDD') : (this.darkMode ? '#30363D' : '#E7E8EA'))

        Blank()

        Text(this.device.online ? '在线' : '离线')
          .fontSize(12)
          .fontColor(this.device.online ? (this.darkMode ? '#3FB950' : '#18794E') : (this.darkMode ? '#8B949E' : '#7B8190'))
          .padding({ left: 8, right: 8, top: 4, bottom: 4 })
          .borderRadius(6)
          .backgroundColor(this.device.online ? (this.darkMode ? '#1E442E' : '#E6F6EC') : (this.darkMode ? '#30363D' : '#F0F1F3'))
      }
      .width('100%')

      Text(this.device.name)
        .fontSize(17)
        .fontWeight(FontWeight.Medium)
        .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Text(`${this.device.room} | ${this.device.status}`)
        .fontSize(13)
        .fontColor(this.darkMode ? '#8B949E' : '#5B6372')
        .maxLines(1)
        .textOverflow({ overflow: TextOverflow.Ellipsis })

      Row() {
        Text(`${this.device.power}W`)
          .fontSize(13)
          .fontColor(this.darkMode ? '#58A6FF' : '#2B5A83')
        Blank()
        Button('控制')
          .fontSize(13)
          .height(32)
          .backgroundColor(this.darkMode ? '#2E7AB5' : '#246B8F')
          .borderRadius(6)
      }
      .width('100%')
    }
    .alignItems(HorizontalAlign.Start)
    .padding(14)
    .width('100%')
    .height(160)
    .borderRadius(8)
    .backgroundColor(this.darkMode ? '#1C2128' : Color.White)
    .border({ width: 1, color: this.darkMode ? '#30363D' : '#DDE3EA' })
  }
}
