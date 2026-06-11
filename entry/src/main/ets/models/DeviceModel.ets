export interface IDevice {
  id: number;
  name: string;
  room: string;
  type: string;
  status: string;
  online: boolean;
  power: number;
}

export interface WeatherInfo {
  city: string;
  temperature: string;
  humidity: string;
  text: string;
}

export interface AppSettings {
  darkMode: boolean;
  gatewayIp: string;
}

export const DEVICE_LIST: IDevice[] = [
  {
    id: 1,
    name: '客厅台灯',
    room: '客厅',
    type: 'light',
    status: '亮度 68%',
    online: true,
    power: 18
  },
  {
    id: 2,
    name: '卧室空调',
    room: '卧室',
    type: 'air',
    status: '26C 制冷',
    online: true,
    power: 720
  },
  {
    id: 3,
    name: '门厅摄像头',
    room: '玄关',
    type: 'camera',
    status: '实时守护',
    online: true,
    power: 9
  },
  {
    id: 4,
    name: '厨房烟感',
    room: '厨房',
    type: 'sensor',
    status: '正常',
    online: true,
    power: 2
  },
  {
    id: 5,
    name: '阳台窗帘',
    room: '阳台',
    type: 'curtain',
    status: '开启 45%',
    online: false,
    power: 0
  },
  {
    id: 6,
    name: '书房网关',
    room: '书房',
    type: 'gateway',
    status: '在线',
    online: true,
    power: 7
  }
];

export const DEFAULT_WEATHER: WeatherInfo = {
  city: '广州',
  temperature: '--',
  humidity: '--',
  text: '加载中'
};
