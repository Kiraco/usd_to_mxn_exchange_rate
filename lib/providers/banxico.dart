import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';
import 'package:usd_to_mxn_exchange_rate/providers/provider.dart';

class Banxico implements Provider {
  ProviderModel getProviderModel() {
    ProviderModel dummyProviderModel = ProviderModel();
    dummyProviderModel.setProvider("Banxico");
    dummyProviderModel.setUpdatedAt(DateTime.now().toIso8601String());
    dummyProviderModel.setValue("10.12");
    return dummyProviderModel;
  }
}
