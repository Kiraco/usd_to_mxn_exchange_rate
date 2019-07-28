import 'package:usd_to_mxn_exchange_rate/models/provider_model.dart';
import 'package:usd_to_mxn_exchange_rate/providers/provider.dart';

class Fixer implements Provider {
  ProviderModel getProviderModel() {
    ProviderModel dummyProviderModel = ProviderModel();
    dummyProviderModel.setProvider("Fixer");
    dummyProviderModel.setUpdatedAt(DateTime.now().toIso8601String());
    dummyProviderModel.setValue("19.35");
    return dummyProviderModel;
  }
}
