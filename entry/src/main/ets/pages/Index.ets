import { common, ConfigurationConstant } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { scanBarcode } from '@kit.ScanKit';
import { DeviceCard } from '../components/DeviceCard';
import { SettingsPanel } from '../components/SettingsPanel';
import { WeatherPanel } from '../components/WeatherPanel';
import { DEFAULT_WEATHER, DEVICE_LIST, IDevice, WeatherInfo } from '../models/DeviceModel';
import { HttpUtil } from '../utils/HttpUtil';
import { PreferencesUtil } from '../utils/PreferencesUtil';

@Entry
@Component
struct Index {
  @State currentTab: number = 0;
  @State loadState: string = 'loading';
  @State weather: WeatherInfo = {
    city: '广州',
    temperature: '26',
    humidity: '62',
    text: '模拟晴天'
  };
  @State @Watch('onDarkModeChanged') darkMode: boolean = false;
  @State @Watch('onGatewayIpChanged') gatewayIp: string = '192.168.31.1';
  @State loadedDarkMode: boolean = false;
  @State loadedGatewayIp: string = '192.168.31.1';
  @State restoringSettings: boolean = false;
  @State weatherProfiles: WeatherInfo[] = [
    {
      city: '广州',
      temperature: '26',
      humidity: '62',
      text: '模拟晴天'
    },
    {
      city: '广州',
      temperature: '24',
      humidity: '78',
      text: '模拟阴天'
    }
  ];
  @State weatherProfileIndex: number = 0;

  private devices: IDevice[] = DEVICE_LIST;
  private context: common.UIAbilityContext = this.getUIContext().getHostContext() as common.UIAbilityContext;

  async aboutToAppear(): Promise<void> {
    await this.restoreSettings();
    await this.loadWeather();
    AppStorage.setOrCreate('darkMode', this.darkMode);
  }

  async restoreSettings(): Promise<void> {
    try {
      this.restoringSettings = true;
      const settings = await PreferencesUtil.load(this.context);
      this.darkMode = settings.darkMode;
      this.gatewayIp = settings.gatewayIp;
      this.loadedDarkMode = settings.darkMode;
      this.loadedGatewayIp = settings.gatewayIp;
    } catch (error) {
      const err = error as BusinessError;
      console.error(`load preferences failed: ${err.code} ${err.message}`);
    } finally {
      this.restoringSettings = false;
    }
  }

  async loadWeather(): Promise<void> {
    this.loadState = 'loading';
    console.log('loadWeather start, index:', this.weatherProfileIndex);
    try {
      this.weather = HttpUtil.getMockWeather(this.weatherProfileIndex);
      console.log('loadWeather result:', JSON.stringify(this.weather));
      this.loadState = 'success';
    } catch (error) {
      const err = error as BusinessError;
      console.error(`weather mock failed: ${err.code} ${err.message}`);
      this.weather = this.weatherProfiles[0];
      this.loadState = 'success';
    }
    console.log('loadWeather end, loadState:', this.loadState);
  }

  async switchWeatherProfile(): Promise<void> {
    this.weatherProfileIndex = this.weatherProfileIndex === 0 ? 1 : 0;
    await this.loadWeather();
  }

  async saveDarkMode(value: boolean): Promise<void> {
    try {
      await PreferencesUtil.saveDarkMode(this.context, value);
      this.loadedDarkMode = value;
    } catch (error) {
      const err = error as BusinessError;
      console.error(`save dark mode failed: ${err.code} ${err.message}`);
    }
  }

  async saveGatewayIp(value: string): Promise<void> {
    try {
      await PreferencesUtil.saveGatewayIp(this.context, value);
      this.loadedGatewayIp = value;
    } catch (error) {
      const err = error as BusinessError;
      console.error(`save gateway failed: ${err.code} ${err.message}`);
    }
  }

  async startScan(): Promise<void> {
    try {
      const result = await scanBarcode.startScanForResult(this.context, {
        enableAlbum: true,
        enableMultiMode: false
      });
      this.getUIContext().getPromptAction().showToast({
        message: `绑定设备: ${result.originalValue}`,
        duration: 2600
      });
    } catch (error) {
      const err = error as BusinessError;
      try {
        this.getUIContext().getPromptAction().showToast({
          message: `扫码未完成: ${err.message}`,
          duration: 2200
        });
      } catch (e) {
        console.error('showToast failed in catch block', e);
      }
    }
  }

  @Builder
  tabBuilder(index: number, icon: string, label: string) {
    Column({ space: 2 }) {
      Text(icon)
        .fontSize(20)
        .fontColor(this.currentTab === index ? (this.darkMode ? '#58A6FF' : '#246B8F') : (this.darkMode ? '#8B949E' : '#7B8190'))
      Text(label)
        .fontSize(11)
        .fontColor(this.currentTab === index ? (this.darkMode ? '#58A6FF' : '#246B8F') : (this.darkMode ? '#8B949E' : '#7B8190'))
    }
    .width('100%')
    .height(54)
    .justifyContent(FlexAlign.Center)
  }

  build() {
    Tabs({
      index: this.currentTab,
      barPosition: BarPosition.End
    }) {
      TabContent() {
        this.homePage()
      }
      .tabBar(this.tabBuilder(0, '⌂', '首页'))

      TabContent() {
        SettingsPanel({
          loadedDarkMode: this.loadedDarkMode,
          loadedGatewayIp: this.loadedGatewayIp,
          darkMode: $darkMode,
          gatewayIp: $gatewayIp
        })
      }
      .tabBar(this.tabBuilder(1, '◎', '我的'))
    }
    .onChange((index: number) => {
      this.currentTab = index;
    })
    .vertical(false)
    .barHeight(60)
    .backgroundColor(this.darkMode ? '#0D1117' : '#F6F8FA')
    .width('100%')
    .height('100%')
  }

  onDarkModeChanged(): void {
    AppStorage.set('darkMode', this.darkMode);
    try {
      this.context.setColorMode(this.darkMode ? ConfigurationConstant.ColorMode.COLOR_MODE_DARK : ConfigurationConstant.ColorMode.COLOR_MODE_LIGHT);
    } catch (err) {
      console.error('setColorMode failed:', JSON.stringify(err));
    }
    if (!this.restoringSettings) {
      this.saveDarkMode(this.darkMode);
    }
  }

  onGatewayIpChanged(): void {
    if (!this.restoringSettings) {
      this.saveGatewayIp(this.gatewayIp);
    }
  }

  @Builder
  homePage() {
    Column({ space: 14 }) {
      Row() {
        Column({ space: 4 }) {
          Text('智享家')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.darkMode ? '#E6EDF1' : '#18202C')
          Text(`默认网关 ${this.gatewayIp}`)
            .fontSize(13)
            .fontColor(this.darkMode ? '#8B949E' : '#687385')
        }
        .alignItems(HorizontalAlign.Start)

        Blank()

        Button('扫码')
          .height(40)
          .fontSize(14)
          .backgroundColor(this.darkMode ? '#2E7AB5' : '#246B8F')
          .borderRadius(6)
          .onClick(() => {
            this.startScan();
          })
      }
      .width('100%')

      WeatherPanel({
        weather: this.weather,
        loadState: this.loadState
      })

      Row({ space: 10 }) {
        Button('刷新样本')
          .height(40)
          .fontSize(14)
          .backgroundColor(this.darkMode ? '#C97A2E' : '#B54708')
          .borderRadius(6)
          .onClick(() => {
            this.loadWeather();
          })

        Button('切换天气')
          .height(40)
          .fontSize(14)
          .backgroundColor(this.darkMode ? '#5A8A6A' : '#4E7A5A')
          .borderRadius(6)
          .onClick(() => {
            this.switchWeatherProfile();
          })
      }
      .width('100%')

      Row() {
        Text('设备列表')
          .fontSize(20)
          .fontWeight(FontWeight.Medium)
          .fontColor(this.darkMode ? '#C9D1D9' : '#1A1F2B')
        Blank()
        Button('台灯控制')
          .height(36)
          .fontSize(13)
          .backgroundColor(this.darkMode ? '#4F6F5B' : '#426B4D')
          .borderRadius(6)
          .onClick(() => {
            this.getUIContext().getRouter().pushUrl({ url: 'pages/LightControl' });
          })
      }
      .width('100%')

      Grid() {
        ForEach(this.devices, (item: IDevice) => {
          GridItem() {
            DeviceCard({ device: item })
          }
        }, (item: IDevice) => item.id.toString())
      }
      .columnsTemplate('1fr 1fr')
      .columnsGap(12)
      .rowsGap(12)
      .layoutWeight(1)
    }
    .padding(16)
    .width('100%')
    .height('100%')
    .backgroundColor(this.darkMode ? '#0D1117' : '#F6F8FA')
  }
}
