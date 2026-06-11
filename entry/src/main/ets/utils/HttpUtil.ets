import { WeatherInfo } from '../models/DeviceModel';

export class HttpUtil {
  static getMockWeather(index: number): WeatherInfo {
    const samples: WeatherInfo[] = [
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
    return samples[index % samples.length];
  }
}
