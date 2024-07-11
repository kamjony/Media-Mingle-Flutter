import 'package:flutter/foundation.dart' show immutable;
import 'package:media_mingle/view/components/dialogs/alert_dialog_model.dart';
import 'package:media_mingle/view/components/constants/strings.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
            title: Strings.logOut,
            message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
            buttons: const {
              Strings.cancel: false,
              Strings.logOut: true,
            });
}
