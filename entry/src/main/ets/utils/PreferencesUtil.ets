import { common } from '@kit.AbilityKit';
import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import { AppSettings } from '../models/DeviceModel';

const STORE_NAME = 'smart_home_settings';
const KEY_DARK_MODE = 'darkMode';
const KEY_GATEWAY_IP = 'gatewayIp';
const DEFAULT_GATEWAY = '192.168.31.1';

export class PreferencesUtil {
  static async load(context: common.Context): Promise<AppSettings> {
    try {
      const store = await preferences.getPreferences(context, STORE_NAME);
      const darkMode = await store.get(KEY_DARK_MODE, false) as boolean;
      const gatewayIp = await store.get(KEY_GATEWAY_IP, DEFAULT_GATEWAY) as string;
      return {
        darkMode,
        gatewayIp
      };
    } catch (error) {
      const err = error as BusinessError;
      console.error(`PreferencesUtil load failed: ${err.code} ${err.message}`);
      return {
        darkMode: false,
        gatewayIp: DEFAULT_GATEWAY
      };
    }
  }

  static async saveDarkMode(context: common.Context, value: boolean): Promise<void> {
    try {
      const store = await preferences.getPreferences(context, STORE_NAME);
      await store.put(KEY_DARK_MODE, value);
      await store.flush();
    } catch (error) {
      const err = error as BusinessError;
      console.error(`PreferencesUtil saveDarkMode failed: ${err.code} ${err.message}`);
    }
  }

  static async saveGatewayIp(context: common.Context, value: string): Promise<void> {
    try {
      const store = await preferences.getPreferences(context, STORE_NAME);
      await store.put(KEY_GATEWAY_IP, value);
      await store.flush();
    } catch (error) {
      const err = error as BusinessError;
      console.error(`PreferencesUtil saveGatewayIp failed: ${err.code} ${err.message}`);
    }
  }
}
