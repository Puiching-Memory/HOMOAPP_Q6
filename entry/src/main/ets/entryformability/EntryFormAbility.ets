import { Want } from '@kit.AbilityKit';
import { formBindingData, FormExtensionAbility, formInfo } from '@kit.FormKit';

class SmartHomeFormData {
  title: string = '智享家';
  temperature: string = '26C';
  humidity: string = '62%';
  onlineCount: number = 5;
}

export default class EntryFormAbility extends FormExtensionAbility {
  onAddForm(want: Want): formBindingData.FormBindingData {
    const formData: SmartHomeFormData = new SmartHomeFormData();
    return formBindingData.createFormBindingData(formData);
  }

  onUpdateForm(formId: string): void {
    console.info(`update smart home form: ${formId}`);
  }

  onFormEvent(formId: string, message: string): void {
    console.info(`form event: ${formId}, ${message}`);
  }

  onRemoveForm(formId: string): void {
    console.info(`remove smart home form: ${formId}`);
  }

  onAcquireFormState(want: Want): formInfo.FormState {
    return formInfo.FormState.READY;
  }
}
